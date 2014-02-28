AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Engine"
ENT.WireDebugName = "ACF Engine"

if CLIENT then
	
	function ACFEngineGUICreate( Table )

		acfmenupanel:CPanelText("Name", Table.name)
		
		acfmenupanel.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
			acfmenupanel.CData.DisplayModel:SetModel( Table.model )
			acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
			acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanel.CData.DisplayModel:SetFOV( 20 )
			acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
			acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
		
		acfmenupanel:CPanelText("Desc", Table.desc)
		acfmenupanel:CPanelText("RPM", "Idle : "..(Table.idlerpm).." RPM\nIdeal RPM Range : "..(Table.peakminrpm).."-"..(Table.peakmaxrpm).." RPM\nRedline : "..(Table.limitrpm).." RPM\nWeight : "..(Table.weight).." kg\nFlywheelMass : "..(Table.flywheelmass).." kg\nFuel Type : "..(Table.fuel))
		
		local peakkw
		local peakkwrpm
		if (Table.iselec == true )then --elecs and turbs get peak power in middle of rpm range
			peakkw = Table.torque * Table.limitrpm / (4*9548.8)
			peakkwrpm = math.floor(Table.limitrpm / 2)
		else	
			peakkw = Table.torque * Table.peakmaxrpm / 9548.8
			peakkwrpm = Table.peakmaxrpm
		end
		
		TextNeedFuel = vgui.Create( "DLabel" )
		TextNeedFuel:SetText( "When supplied with fuel:")
		TextNeedFuel:SetTextColor(Color(0,150,0,255))
		acfmenupanel.CustomDisplay:AddItem( TextNeedFuel )
		acfmenupanel:CPanelText("WhenFuel2", "Peak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM\nPeak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
			
		if Table.fuel == "Electric" then
			local cons = ACF.ElecRate * peakkw / ACF.Efficiency[Table.enginetype]
			acfmenupanel:CPanelText("FuelCons", "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
		elseif Table.fuel == "Any" then
			local petrolcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity.Petrol)
			local dieselcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity.Diesel)
			acfmenupanel:CPanelText("FuelConsP", "Petrol Use at "..peakkwrpm.." rpm : "..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
			acfmenupanel:CPanelText("FuelConsD", "Diesel Use at "..peakkwrpm.." rpm : "..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
		else
			local fuelcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity[Table.fuel])
			acfmenupanel:CPanelText("FuelCons", (Table.fuel).." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
		end
		
		TextNotFuel = vgui.Create( "DLabel" )
		TextNotFuel:SetText( "When NOT supplied with fuel:")
		TextNotFuel:SetTextColor(Color(200,0,0,255))
		acfmenupanel.CustomDisplay:AddItem( TextNotFuel )
		acfmenupanel:CPanelText("WhenNotFuel2", "Peak Power : "..math.floor(peakkw).." kW / "..math.Round(peakkw*1.34).." HP @ "..peakkwrpm.." RPM\nPeak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
	
	acfmenupanel.CustomDisplay:PerformLayout()	
	
	end
	
	return
	
end

--###################################################
--##### 			END CL_INIT					#####
--###################################################

function ENT:Initialize()

	self.Throttle = 0
	self.Active = false
	self.IsMaster = true
	self.GearLink = {} -- a "Link" has these components: Ent, Rope, RopeLen, ReqTq
	self.FuelLink = {}

	self.LastCheck = 0
	self.LastThink = 0
	self.MassRatio = 1
	self.Legal = true
	self.CanUpdate = true
	self.RequiresFuel = 0
	
	--####################
	self.TqAdd = 0
	self.MaxRpmAdd = 0
	self.LimitRpmAdd = 0
	self.FlywheelMass = 0
	self.Override = 0
	self.WeightKg = 0
	self.idle = 0
	self.CutMode = 0
	self.CutValue = 0
	self.CutRpm = 0
	self.DisableAutoClutch = 0
	self.Fuelusing = 0
	self.DisableCut = 0
	--#####################
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Torque", "Power", "Fuel Use", "Entity", "Mass", "Physical Mass" }, { "NORMAL","NORMAL","NORMAL", "NORMAL", "ENTITY", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput( self, "Entity", self )
end

--###################################################
--##### 			MAKE ENGINE					#####
--###################################################

function MakeACF_Engine(Owner, Pos, Angle, Id, Data13, Data14, Data15, Data16, Data17)

	if not Owner:CheckLimit("_acf_misc") then return false end

	local Engine = ents.Create( "acf_engine" )
	if not IsValid( Engine ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List.Mobility[Id] then EID = Id else EID = "5.7-V8" end
	local Lookup = List.Mobility[EID]
	
	Engine:SetAngles(Angle)
	Engine:SetPos(Pos)
	Engine:Spawn()
	Engine:SetPlayer(Owner)
	Engine.Owner = Owner
	Engine.Id = EID
	
	Engine.Model = Lookup.model
	Engine.SoundPath = Lookup.sound
	Engine.Weight = Lookup.weight
	Engine.IdleRPM = Lookup.idlerpm
	Engine.PeakTorque = Lookup.torque
	Engine.PeakTorqueHeld = Lookup.torque
	Engine.PeakMinRPM = Lookup.peakminrpm
	Engine.PeakMaxRPM = Lookup.peakmaxrpm
	Engine.LimitRPM = Lookup.limitrpm
	Engine.Inertia = Lookup.flywheelmass*(3.1416)^2
	Engine.iselec = Lookup.iselec
	Engine.elecpower = Lookup.elecpower
	Engine.FlywheelOverride = Lookup.flywheeloverride
	Engine.IsTrans = Lookup.istrans -- driveshaft outputs to the side
	Engine.FuelType = Lookup.fuel or "Petrol"
	Engine.EngineType = Lookup.enginetype or "GenericPetrol"
	Engine.SoundPitch = Lookup.pitch or 1
	Engine.SpecialHealth = true
	---------------------
	Engine:FirstLoadCustom()
	Engine.FlywheelMassValue = Lookup.flywheelmass
	--Creating Wire Inputs
	local Inputs = {"Active", "Throttle", "TqAdd"}
	if Engine.EngineType == "Turbine" or Engine.EngineType == "Electric" then	--Create inputs for Electric&Turbine
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Override")
		table.insert(Inputs, "Gearbox RPM")
	else		 --Create inputs others engines
		table.insert(Inputs, "MaxRpmAdd")
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Idle")
		table.insert(Inputs, "Disable Cutoff")
		table.insert(Inputs, "Gearbox RPM")
	end
	Engine.Inputs = Wire_CreateInputs( Engine, Inputs )
	---------------------
	--calculate boosted peak kw
	if Engine.EngineType == "Turbine" or Engine.EngineType == "Electric" then
		Engine.DisableCut = 1
		Engine.peakkw = Engine.PeakTorque * Engine.LimitRPM / (4 * 9548.8)
		Engine.PeakKwRPM = math.floor(Engine.LimitRPM / 2)
	else
		Engine.peakkw = Engine.PeakTorque * Engine.PeakMaxRPM / 9548.8
		Engine.PeakKwRPM = Engine.PeakMaxRPM
	end
	--calculate base fuel usage
	if Engine.EngineType == "Electric" then
		Engine.FuelUse = ACF.ElecRate / (ACF.Efficiency[Engine.EngineType] * 60 * 60) --elecs use current power output, not max
	else
		Engine.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[Engine.EngineType] * Engine.peakkw / (60 * 60)
	end

	Engine.FlyRPM = 0
	Engine:SetModel( Engine.Model )	
	Engine.Sound = nil
	Engine.RPM = {}

	Engine:PhysicsInit( SOLID_VPHYSICS )      	
	Engine:SetMoveType( MOVETYPE_VPHYSICS )     	
	Engine:SetSolid( SOLID_VPHYSICS )

	Engine.Out = Engine:WorldToLocal(Engine:GetAttachment(Engine:LookupAttachment( "driveshaft" )).Pos)

	local phys = Engine:GetPhysicsObject()  	
	if IsValid( phys ) then
		phys:SetMass( Engine.Weight ) 
	end

	Engine:SetNetworkedString( "WireName", Lookup.name )
	------ GUI ---------
	Engine.FlywheelMassGUI = Engine.FlywheelMassValue
	Engine:UpdateOverlayText()
	
	Owner:AddCount("_acf_engine", Engine)
	Owner:AddCleanup( "acfmenu", Engine )
	
	ACF_Activate( Engine, 0 )

	return Engine
end
list.Set( "ACFCvars", "acf_engine", {"id"} )
duplicator.RegisterEntityClass("acf_engine", MakeACF_Engine, "Pos", "Angle", "Id")

--###################################################
--##### 		UPDATE ENGINE					#####
--###################################################

function ENT:Update( ArgsTable )	
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.Active then
		return false, "Turn off the engine before updating it!"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFEnts").Mobility[Id]

	if Lookup.model ~= self.Model then
		return false, "The new engine must have the same model!"
	end
	
	local Feedback = ""
	if Lookup.fuel != self.FuelType then
		Feedback = " Fuel type changed, fuel tanks unlinked."
		for Key,Value in pairs(self.FuelLink) do
			table.remove(self.FuelLink,Key)
			--need to remove from tank master?
		end
	end

	self.Id = Id
	self.SoundPath = Lookup.sound
	self.Weight = Lookup.weight
	self.IdleRPM = Lookup.idlerpm
	self.PeakTorque = Lookup.torque
	self.PeakTorqueHeld = Lookup.torque
	self.PeakMinRPM = Lookup.peakminrpm
	self.PeakMaxRPM = Lookup.peakmaxrpm
	self.LimitRPM = Lookup.limitrpm
	self.Inertia = Lookup.flywheelmass*(3.1416)^2
	self.iselec = Lookup.iselec -- is the engine electric?
	self.elecpower = Lookup.elecpower -- how much power does it output
	self.FlywheelOverride = Lookup.flywheeloverride -- how much power does it output
	self.IsTrans = Lookup.istrans
	self.FuelType = Lookup.fuel
	self.EngineType = Lookup.enginetype
	self.SoundPitch = Lookup.pitch or 1
	self.SpecialHealth = true
	---------------------
	self:FirstLoadCustom()
	self.FlywheelMassValue = Lookup.flywheelmass
	--Creating Wire Inputs
	local Inputs = {"Active", "Throttle", "TqAdd"}
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Create inputs for Electric&Turbine
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Override")
		table.insert(Inputs, "Gearbox RPM")
	else 		--Create inputs others engines
		table.insert(Inputs, "MaxRpmAdd")
		table.insert(Inputs, "LimitRpmAdd")
		table.insert(Inputs, "FlywheelMass")
		table.insert(Inputs, "Idle")
		table.insert(Inputs, "Disable Cutoff")
		table.insert(Inputs, "Gearbox RPM")
	end
	self.Inputs = Wire_CreateInputs( self, Inputs )
	---------------------
	--calculate boosted peak kw
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.DisableCut = 1
		self.peakkw = self.PeakTorque * self.LimitRPM / (4 * 9548.8)
		self.PeakKwRPM = math.floor(self.LimitRPM / 2)
	else
		self.peakkw = self.PeakTorque * self.PeakMaxRPM / 9548.8
		self.PeakKwRPM = self.PeakMaxRPM
	end
	--calculate base fuel usage
	if self.EngineType == "Electric" then
		self.FuelUse = ACF.ElecRate / (ACF.Efficiency[self.EngineType] * 60 * 60) --elecs use current power output, not max
	else
		self.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[self.EngineType] * self.peakkw / (60 * 60)
	end

	self:SetModel( self.Model )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Out = self:WorldToLocal(self:GetAttachment(self:LookupAttachment( "driveshaft" )).Pos)

	local phys = self:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end
	
	self:SetNetworkedString( "WireName", Lookup.name )
	------ GUI ---------
	self.FlywheelMassGUI = self.FlywheelMassValue
	self:UpdateOverlayText()
	
	ACF_Activate( self, 1 )
	
	return true, "Engine updated successfully!"..Feedback
end

--###################################################
--##### 			FUNCTIONS					#####
--###################################################

function ENT:FirstLoadCustom( )
	self.PeakMaxRPM2 = self.PeakMaxRPM
	self.LimitRPM2 = self.LimitRPM
	self.FlywheelMass3 = self.FlywheelMassValue
	self.Idling = self.IdleRPM
	self.CutValue = self.LimitRPM / 40
	self.CutRpm = self.LimitRPM - 100
	self.FlywheelOverride2 = self.FlywheelOverride
	self.PeakTorqueLoad = self.PeakTorque
	self.PeakTorqueAdd = self.PeakTorque
end

function ENT:UpdateOverlayText()
	--Better values for Power Gui and Torque Gui
	if self.RequiresFuel == 1 then
		self.PowerGUI = self.peakkw*ACF.TorqueBoost
		self.TorqueGUI = self.PeakTorqueAdd*ACF.TorqueBoost
	else
		self.PowerGUI = self.peakkw
		self.TorqueGUI = self.PeakTorqueAdd
	end
	
	local text = "Power: " .. math.Round(self.PowerGUI) .. " kW / " .. math.Round(self.PowerGUI * 1.34) .. " hp\n"
	text = text .. "Torque: " .. math.Round(self.TorqueGUI) .. " Nm / " .. math.Round(self.TorqueGUI * 0.73) .. " ft-lb\n"
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Set Gui on electric&turbine
		text = text .. "Override: " .. math.Round(self.FlywheelOverride) .. " RPM\n"
		text = text .. "Redline: " .. math.Round(self.LimitRPM) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n"
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	else --Set Gui on Others
		text = text .. "Powerband: " .. math.Round(self.PeakMinRPM) .. " - " .. math.Round(self.PeakMaxRPM) .. " RPM\n"
		text = text .. "Redline: " .. math.Round(self.LimitRPM) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n"
		text = text .. "Idle: " .. math.Round(self.IdleRPM) .. " RPM\n"
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	end
	self:SetOverlayText( text )
end

function ENT:UpdateEngineConsumption()
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.peakkw = self.PeakTorqueAdd * self.LimitRPM / (4 * 9548.8)
		self.PeakKwRPM = math.floor(self.LimitRPM / 2)
	else
		self.peakkw = self.PeakTorqueAdd * self.PeakMaxRPM / 9548.8
		self.PeakKwRPM = self.PeakMaxRPM
	end
	if self.EngineType == "Electric" then 
		self.FuelUse = ACF.ElecRate / (ACF.Efficiency[self.EngineType] * 60 * 60) --elecs use current power output, not max
	else
		self.FuelUse = ACF.TorqueBoost * ACF.FuelRate * ACF.Efficiency[self.EngineType] * self.peakkw / (60 * 60)
	end
	self:UpdateOverlayText()
end

--###################################################
--##### 		TRIGGER INPUTS					#####
--###################################################

function ENT:TriggerInput( iname, value )
	if (iname == "Throttle") then
		self.Throttle = math.Clamp(value,0,100)/100
	elseif (iname == "Active") then
		if (value > 0 and not self.Active) then
			--make sure we have fuel
			local HasFuel
			if self.RequiresFuel == 0 then
				HasFuel = true
			else 
				for _,fueltank in pairs(self.FuelLink) do
					if fueltank.Fuel > 0 and fueltank.Active then HasFuel = true break end
				end
			end
			
			if HasFuel then
				self.RPM = {}
				self.RPM[1] = self.IdleRPM
				self.Active = true
				self.Active2 = true
				self.Sound = CreateSound(self, self.SoundPath)
				self.Sound:PlayEx(0.5,100)
				self:ACFInit()
			end
		elseif (value > 0) then
			local HasFuel
			if self.RequiresFuel == 0 then
				HasFuel = true
			else
				for _,fueltank in pairs(self.FuelLink) do
					if fueltank.Fuel <= 0 or not fueltank.Active then HasFuel = false break end
				end
			end
			if not HasFuel then
				self:TriggerInput( "Active" , 0 )
				self.Active = false
				Wire_TriggerOutput( self, "RPM", 0 )
				Wire_TriggerOutput( self, "Torque", 0 )
				Wire_TriggerOutput( self, "Power", 0 )
				Wire_TriggerOutput( self, "Fuel Use", 0 )
			end
		elseif (value <= 0 and self.Active) then
			self.Active = false
			Wire_TriggerOutput( self, "RPM", 0 )
			Wire_TriggerOutput( self, "Torque", 0 )
			Wire_TriggerOutput( self, "Power", 0 )
			Wire_TriggerOutput( self, "Fuel Use", 0 )
		end
	--##########################################
	elseif (iname == "TqAdd") then
		if (value ~= 0 ) then
			self.PeakTorqueAdd = self.PeakTorqueLoad+value
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.PeakTorqueAdd = self.PeakTorqueLoad
			self:UpdateEngineConsumption()
		end
	elseif (iname == "MaxRpmAdd") then
		if (value ~= 0 ) then
			if( self.PeakMaxRPM2+value <= self.LimitRPM ) then
				self.PeakMaxRPM = self.PeakMaxRPM2+value
			elseif( self.PeakMaxRPM2+value > self.LimitRPM ) then
				self.PeakMaxRPM = self.LimitRPM
			end
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.PeakMaxRPM = self.PeakMaxRPM2
			self:UpdateEngineConsumption()
		end
	elseif (iname == "LimitRpmAdd") then
		if (value ~= 0 ) then
			self.LimitRPM = self.LimitRPM2+value
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
			self:UpdateEngineConsumption()
		elseif (value == 0 ) then
			self.LimitRPM = self.LimitRPM2
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
			self:UpdateEngineConsumption()
		end
	elseif (iname == "FlywheelMass") then
		if (value > 0 ) then
			self.FlywheelMassValue = value
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.FlywheelMassValue = self.FlywheelMass3
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		end
	elseif (iname == "Override") then
		if (value > 0 ) then
			self.FlywheelOverride = value
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.FlywheelOverride = self.FlywheelOverride2
			self:UpdateOverlayText()
		end
	elseif (iname == "Idle") then
		if (value > 0 ) then
			self.IdleRPM = value
			self:UpdateOverlayText()
		elseif (value <= 0 ) then
			self.IdleRPM = self.Idling
			self:UpdateOverlayText()
		end
	elseif (iname == "Disable Cutoff") then
		if (value > 0 ) then
			self.DisableCut = 1
		elseif (value <= 0 ) then
			self.DisableCut = 0
		end
	--Disabling AutoClutch on Engine while Moving
	elseif (iname == "Gearbox RPM") then
		if ((value*0.8) > self.IdleRPM and self.Throttle == 0) then
			self.DisableAutoClutch = 1
			self.GearboxRpm = value
		elseif (value <= self.IdleRPM or self.Throttle > 0 and self.DisableAutoClutch == 1) then
			self.DisableAutoClutch = 0
			self.GearboxRpm = 0
		end
	end
end
--#########################
function ENT:ACF_Activate()
	--Density of steel = 7.8g cm3 so 7.8kg for a 1mx1m plate 1m thick
	local Entity = self
	Entity.ACF = Entity.ACF or {} 
	
	local Count
	local PhysObj = Entity:GetPhysicsObject()
	if PhysObj:GetMesh() then Count = #PhysObj:GetMesh() end
	if PhysObj:IsValid() and Count and Count>100 then

		if not Entity.ACF.Aera then
			Entity.ACF.Aera = (PhysObj:GetSurfaceArea() * 6.45) * 0.52505066107
		end
		--if not Entity.ACF.Volume then
		--	Entity.ACF.Volume = (PhysObj:GetVolume() * 16.38)
		--end
	else
		local Size = Entity.OBBMaxs(Entity) - Entity.OBBMins(Entity)
		if not Entity.ACF.Aera then
			Entity.ACF.Aera = ((Size.x * Size.y)+(Size.x * Size.z)+(Size.y * Size.z)) * 6.45
		end
		--if not Entity.ACF.Volume then
		--	Entity.ACF.Volume = Size.x * Size.y * Size.z * 16.38
		--end
	end
	
	Entity.ACF.Ductility = Entity.ACF.Ductility or 0
	--local Area = (Entity.ACF.Aera+Entity.ACF.Aera*math.Clamp(Entity.ACF.Ductility,-0.8,0.8))
	local Area = (Entity.ACF.Aera)
	--local Armour = (Entity:GetPhysicsObject():GetMass()*1000 / Area / 0.78) / (1 + math.Clamp(Entity.ACF.Ductility, -0.8, 0.8))^(1/2)	--So we get the equivalent thickness of that prop in mm if all it's weight was a steel plate
	local Armour = (Entity:GetPhysicsObject():GetMass()*1000 / Area / 0.78) 
	--local Health = (Area/ACF.Threshold) * (1 + math.Clamp(Entity.ACF.Ductility, -0.8, 0.8))												--Setting the threshold of the prop aera gone
	local Health = (Area/ACF.Threshold)
	
	local Percent = 1 
	
	if Recalc and Entity.ACF.Health and Entity.ACF.MaxHealth then
		Percent = Entity.ACF.Health/Entity.ACF.MaxHealth
	end
	
	Entity.ACF.Health = Health * Percent * ACF.EngineHPMult
	Entity.ACF.MaxHealth = Health * ACF.EngineHPMult
	Entity.ACF.Armour = Armour * (0.5 + Percent/2)
	Entity.ACF.MaxArmour = Armour * ACF.ArmorMod
	Entity.ACF.Type = nil
	Entity.ACF.Mass = PhysObj:GetMass()
	--Entity.ACF.Density = (PhysObj:GetMass()*1000)/Entity.ACF.Volume
	
	Entity.ACF.Type = "Prop"
end

function ENT:Think()

	local Time = CurTime()

	if self.Active2 then
		if self.Legal then
			self:CalcRPM()
		end

		if self.LastCheck < CurTime() then
			self:CheckRopes()
			self:CheckFuel()
			self:CalcMassRatio()
			self.Legal = self:CheckLegal()

			self.LastCheck = Time + math.Rand(5, 10)
		end
	end

	self.LastThink = Time
	self:NextThink( Time )
	return true

end

function ENT:CheckLegal()
	
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Weight then return false end
	
	-- if it's not parented we're fine
	if not IsValid( self:GetParent() ) then return true end
	
	-- but not if it's parented to a parented prop
	if IsValid( self:GetParent():GetParent() ) then return false end
	
	-- parenting is only legal if it's also welded
	for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
		
		if v.Ent1 == self:GetParent() or v.Ent2 == self:GetParent() then return true end
		
	end
	
	return false
	
end

function ENT:CalcMassRatio()
	
	local Mass = 0
	local PhysMass = 0
	
	-- get the shit that is physically attached to the vehicle
	local PhysEnts = ACF_GetAllPhysicalConstraints( self )
	
	-- add any parented but not constrained props you sneaky bastards
	local AllEnts = table.Copy( PhysEnts )
	for k, v in pairs( PhysEnts ) do
		
		table.Merge( AllEnts, ACF_GetAllChildren( v ) )
	
	end
	
	for k, v in pairs( AllEnts ) do
		
		if not IsValid( v ) then continue end
		
		local phys = v:GetPhysicsObject()
		if not IsValid( phys ) then continue end
		
		Mass = Mass + phys:GetMass()
		
		if PhysEnts[ v ] then
			PhysMass = PhysMass + phys:GetMass()
		end
		
	end

	self.MassRatio = PhysMass / Mass
	
	Wire_TriggerOutput( self, "Mass", math.Round( Mass, 2 ) )
	Wire_TriggerOutput( self, "Physical Mass", math.Round( PhysMass, 2 ) )
	
end

function ENT:ACFInit()
	
	self:CalcMassRatio()

	self.LastThink = CurTime()
	self.Torque = self.PeakTorqueAdd
	self.FlyRPM = self.IdleRPM * 1.5

end

function ENT:CalcRPM()

	local DeltaTime = CurTime() - self.LastThink
	
	--find first active tank with fuel
	local Tank = nil
	local boost = 1
	for _,fueltank in pairs(self.FuelLink) do
		if fueltank.Fuel > 0 and fueltank.Active then Tank = fueltank break end
		if fueltank.Fuel <= 0 or not fueltank.Active then Tank = false break end
	end
	if (not Tank) and self.RequiresFuel == 1 then  --make sure we've got a tank with fuel if needed
		self:TriggerInput( "Active" , 0 )
	end
	
	--calculate fuel usage
	if Tank then
		local Consumption
		if self.FuelType == "Electric" then
			Consumption = (self.Torque * self.FlyRPM / 9548.8) * self.FuelUse * DeltaTime
		else
			local Load = 0.3 + self.Throttle * 0.7
			Consumption = Load * self.FuelUse * (self.FlyRPM / self.PeakKwRPM) * DeltaTime / ACF.FuelDensity[Tank.FuelType]
		end
		Tank.Fuel = math.max(Tank.Fuel - Consumption,0)
		boost = ACF.TorqueBoost
		Wire_TriggerOutput(self, "Fuel Use", math.Round(60*Consumption/DeltaTime,3))
		self.Fuelusing = math.Round((60*Consumption/DeltaTime),3)
	else
		Wire_TriggerOutput(self, "Fuel Use", 0)
	end
	
	--Function Calling
	self:UpdateOverlayText()
	
	-- Calculate the current torque from flywheel RPM
	local TorqueScale = ACF.TorqueScale
	local TorqueMult = 1
	if (self.ACF.Health and self.ACF.MaxHealth) then
		TorqueMult = math.Clamp(((1 - TorqueScale) / (0.5)) * ((self.ACF.Health/self.ACF.MaxHealth) - 1) + 1, TorqueScale, 1)
	end
	
	self.PeakTorque = self.PeakTorqueAdd * TorqueMult
	self.Inertia = self.FlywheelMassValue*(3.1416)^2
	
	local Drag
	local TorqueDiff
	if self.Active then
	if( self.CutMode == 0 ) then
		self.Torque = boost * self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - self.Throttle) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - self.Throttle) / self.Inertia
		end
	
	elseif( self.CutMode == 1 ) then
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
		
	end 
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	if self.DisableAutoClutch == 0 then
		-- This is the presently avaliable torque from the engine
		TorqueDiff = math.max( self.FlyRPM - self.IdleRPM, 0 ) * self.Inertia
	elseif self.DisableAutoClutch == 1 then
		TorqueDiff = 0
	end

	end
	
	if( self.Active == false ) then
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
	
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	-- This is the presently avaliable torque from the engine
	TorqueDiff = 0
	
	end
	--##############
	
	-- The gearboxes don't think on their own, it's the engine that calls them, to ensure consistent execution order
	local Boxes = table.Count( self.GearLink )
	
	local TotalReqTq = 0
	
	-- Get the requirements for torque for the gearboxes (Max clutch rating minus any wheels currently spinning faster than the Flywheel)
	for Key, Link in pairs( self.GearLink ) do
	
		if not Link.Ent.Legal then continue end
		
		Link.ReqTq = Link.Ent:Calc( self.FlyRPM, self.Inertia )
		TotalReqTq = TotalReqTq + Link.ReqTq
		
	end

	-- Calculate the ratio of total requested torque versus what's avaliable
	local AvailRatio = math.min( TorqueDiff / TotalReqTq / Boxes, 1 )
	
	-- Split the torque fairly between the gearboxes who need it
	for Key, Link in pairs( self.GearLink ) do
		
		if not Link.Ent.Legal then continue end
		
		Link.Ent:Act( Link.ReqTq * AvailRatio * self.MassRatio, DeltaTime )
		
	end

	if self.DisableAutoClutch == 0 then
		self.FlyRPM = self.FlyRPM - math.min( TorqueDiff, TotalReqTq ) / self.Inertia
	elseif self.DisableAutoClutch == 1 then
		self.FlyRPM = self.GearboxRpm*0.8
	end
	
	--#######################################
	if( self.DisableCut == 0 ) then
		if( self.FlyRPM >= self.CutRpm and self.CutMode == 0 and self.DisableAutoClutch == 0 ) then
			self.CutMode = 1
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			self.Sound2 = CreateSound(self, "acf_other/penetratingshots/00000293.wav")
			self.Sound2:PlayEx(0.5,100)
		end
		if( self.FlyRPM <= self.CutRpm - self.CutValue and self.CutMode == 1 ) then
			self.CutMode = 0
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
			if self.Sound2 then
				self.Sound2:Stop()
			end
		end
	elseif( self.DisableCut == 1 ) then
		self.CutMode = 0
	end
	if( self.FlyRPM <= 50 and self.Active == false ) then
		self.Active2 = false
		self.FlyRPM = 0
		if self.Sound then
			self.Sound:Stop()
		end
		self.Sound = nil
		self:UpdateOverlayText()
	end
	--#######################################

	-- Then we calc a smoothed RPM value for the sound effects
	table.remove( self.RPM, 10 )
	table.insert( self.RPM, 1, self.FlyRPM )
	local SmoothRPM = 0
	for Key, RPM in pairs( self.RPM ) do
		SmoothRPM = SmoothRPM + (RPM or 0)
	end
	SmoothRPM = SmoothRPM / 10

	local Power = self.Torque * SmoothRPM / 9548.8
	Wire_TriggerOutput(self, "Torque", math.floor(self.Torque))
	Wire_TriggerOutput(self, "Power", math.floor(Power))
	Wire_TriggerOutput(self, "RPM", self.FlyRPM)
	
	if self.Sound then
		self.Sound:ChangePitch( math.min( 20 + (SmoothRPM * self.SoundPitch) / 50, 255 ), 0 )
		self.Sound:ChangeVolume( 0.25 + (0.1 + 0.9 * ((SmoothRPM / self.LimitRPM) ^ 1.5)) * self.Throttle / 1.5, 0 )
	end
	
	return RPM
end

function ENT:CheckRopes()
	
	for Key, Link in pairs( self.GearLink ) do
		
		local Ent = Link.Ent
		
		-- make sure the rope is still there
		if not IsValid( Link.Rope ) then 
			self:Unlink( Ent )
		continue end
		
		local OutPos = self:LocalToWorld( self.Out )
		local InPos = Ent:LocalToWorld( Ent.In )
		
		-- make sure it is not stretched too far
		if OutPos:Distance( InPos ) > Link.RopeLen * 1.5 then
			self:Unlink( Ent )
		continue end
		
		-- make sure the angle is not excessive
		local Direction
		if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
		
		local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
		if DrvAngle < 0.7 then
			self:Unlink( Ent )
		end
		
	end
	
end

--unlink fuel tanks out of range
function ENT:CheckFuel()
	for _,tank in pairs(self.FuelLink) do
		if self:GetPos():Distance(tank:GetPos()) > 512 then
			self:Unlink( tank )
			soundstr =  "physics/metal/metal_box_impact_bullet" .. tostring(math.random(1, 3)) .. ".wav"
			self:EmitSound(soundstr,500,100)
		end
	end
end

function ENT:Link( Target )

	if not IsValid( Target ) or Target:GetClass() ~= "acf_gearbox" and Target:GetClass() ~= "acf_fueltank" and Target:GetClass() ~= "acf_gearboxcvt" then
		return false, "Can only link to gearboxes or fuel tanks!"
	end
	
	if Target:GetClass() == "acf_fueltank" then
		return self:LinkFuel( Target )
	end
	
	-- Check if target is already linked
	for Key, Link in pairs( self.GearLink ) do
		if Link.Ent == Target then
			return false, "That is already linked to this engine!"
		end
	end
	
	-- make sure the angle is not excessive
	local InPos = Target:LocalToWorld( Target.In )
	local OutPos = self:LocalToWorld( self.Out )
	
	local Direction
	if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
	
	local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end
	
	local Rope = constraint.CreateKeyframeRope( OutPos, 1, "cable/cable2", nil, self, self.Out, 0, Target, Target.In, 0 )
	
	local Link = {
		Ent = Target,
		Rope = Rope,
		RopeLen = ( OutPos - InPos ):Length(),
		ReqTq = 0
	}
	
	table.insert( self.GearLink, Link )
	table.insert( Target.Master, self )
	
	return true, "Link successful!"
end

function ENT:Unlink( Target )

	if Target:GetClass() == "acf_fueltank" then
		return self:UnlinkFuel( Target )
	end
	
	for Key, Link in pairs( self.GearLink ) do
		
		if Link.Ent == Target then
			
			-- Remove any old physical ropes leftover from dupes
			for Key, Rope in pairs( constraint.FindConstraints( Link.Ent, "Rope" ) ) do
				if Rope.Ent1 == self or Rope.Ent2 == self then
					Rope.Constraint:Remove()
				end
			end
			
			if IsValid( Link.Rope ) then
				Link.Rope:Remove()
			end
			
			table.remove( self.GearLink,Key )
			
			return true, "Unlink successful!"
			
		end
		
	end
	
	return false, "That gearbox is not linked to this engine!"
	
end

function ENT:LinkFuel( Target )
	
	if not (self.FuelType == "Any" and not (Target.FuelType == "Electric")) then
		if self.FuelType ~= Target.FuelType then
			return false, "Cannot link because fuel type is incompatible."
		end
	end
	
	if Target.NoLinks then
		return false, "This fuel tank doesn\'t allow linking."
	end
	
	for Key,Value in pairs(self.FuelLink) do
		if Value == Target then 
			return false, "That fuel tank is already linked to this engine!"
		end
	end
	
	if self:GetPos():Distance( Target:GetPos() ) > 512 then
		return false, "Fuel tank is too far away."
	end
	
	table.insert( self.FuelLink, Target )
	table.insert( Target.Master, self )
	
	self.RequiresFuel = 1
	
	return true, "Link successful! Now Require Fuel"
	
end

function ENT:UnlinkFuel( Target )
	
	for Key, Value in pairs( self.FuelLink ) do
		if Value == Target then
			self.RequiresFuel = 0
			table.remove( self.FuelLink, Key )
			return true, "Unlink successful! Now NOT Require Fuel"
		end
	end
	
	return false, "That fuel tank is not linked to this engine!"
	
end

function ENT:PreEntityCopy()

	//Link Saving
	local info = {}
	local entids = {}
	for Key, Link in pairs( self.GearLink ) do					--First clean the table of any invalid entities
		if not IsValid( Link.Ent ) then
			table.remove( self.GearLink, Key )
		end
	end
	for Key, Link in pairs( self.GearLink ) do					--Then save it
		table.insert( entids, Link.Ent:EntIndex() )
	end

	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self, "GearLink", info )
	end
	
	--fuel tank link saving
	local fuel_info = {}
	local fuel_entids = {}
	for Key, Value in pairs(self.FuelLink) do					--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.FuelLink, Value)
		end
	end
	for Key, Value in pairs(self.FuelLink) do					--Then save it
		table.insert(fuel_entids, Value:EntIndex())
	end
	
	fuel_info.entities = fuel_entids
	if fuel_info.entities then
		duplicator.StoreEntityModifier( self, "FuelLink", fuel_info )
	end

	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )

end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	//Link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.GearLink) and (Ent.EntityMods.GearLink.entities) then
		local GearLink = Ent.EntityMods.GearLink
		if GearLink.entities and table.Count(GearLink.entities) > 0 then
			timer.Simple( 0, function() -- this timer is a workaround for an ad2/makespherical issue https://github.com/nrlulz/ACF/issues/14#issuecomment-22844064
				for _,ID in pairs(GearLink.entities) do
					local Linked = CreatedEntities[ ID ]
					if IsValid( Linked ) then
						self:Link( Linked )
					end
				end
			end )
		end
		Ent.EntityMods.GearLink = nil
	end

	--fuel tank link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.FuelLink) and (Ent.EntityMods.FuelLink.entities) then
		local FuelLink = Ent.EntityMods.FuelLink
		if FuelLink.entities and table.Count(FuelLink.entities) > 0 then
			for _,ID in pairs(FuelLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then
					self.RequiresFuel = 1
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.FuelLink = nil
	end
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end
