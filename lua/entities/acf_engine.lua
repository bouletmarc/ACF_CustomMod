
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
	self.ExtraLink = {}
	self.Master = {}
	self.PeakTorqueExtra = 0
	self.PeakMaxRPMExtra = 0
	self.LimitRPMExtra = 0
	self.ExtraUsing = 0
	self.PeakTorqueHealth = 0
	--#####################
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Torque", "Power", "Fuel Use", "Entity", "Mass", "Physical Mass" }, { "NORMAL","NORMAL","NORMAL", "NORMAL", "ENTITY", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput( self, "Entity", self )
end

--###################################################
--##### 			MAKE ENGINE					#####
--###################################################

function MakeACF_Engine(Owner, Pos, Angle, Id)

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
	Engine.SpecialDamage = true
	Engine.TorqueMult = 1
	---------------------
	Engine:FirstLoadCustom()
	Engine.FlywheelMassValue = Lookup.flywheelmass
	--Creating Wire Inputs
	Engine.CustomLimit = GetConVarNumber("sbox_max_acf_modding")
	local Inputs = {"Active", "Throttle"}
	if Engine.CustomLimit > 0 then
		if Engine.EngineType == "Turbine" or Engine.EngineType == "Electric" then	--Create inputs for Electric&Turbine
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Override")
			table.insert(Inputs, "Gearbox RPM")
		else		 --Create inputs others engines
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "MaxRpmAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Idle")
			table.insert(Inputs, "Disable Cutoff")
			table.insert(Inputs, "Gearbox RPM")
		end
	end
	Engine.Inputs = Wire_CreateInputs( Engine, Inputs )
	---------------------
	if Engine.EngineType == "GenericDiesel" then
		Engine.TorqueScale = ACF.DieselTorqueScale
	else
		Engine.TorqueScale = ACF.TorqueScale
	end
	
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
	self.SpecialDamage = true
	self.TorqueMult = self.TorqueMult or 1
	---------------------
	self:FirstLoadCustom()
	self.FlywheelMassValue = Lookup.flywheelmass
	--Creating Wire Inputs
	self.CustomLimit = GetConVarNumber("sbox_max_acf_modding")
	local Inputs = {"Active", "Throttle"}
	if self.CustomLimit > 0 then
		if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Create inputs for Electric&Turbine
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Override")
			table.insert(Inputs, "Gearbox RPM")
		else 		--Create inputs others engines
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "MaxRpmAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Idle")
			table.insert(Inputs, "Disable Cutoff")
			table.insert(Inputs, "Gearbox RPM")
		end
	end
	self.Inputs = Wire_CreateInputs( self, Inputs )
	---------------------
	if self.EngineType == "GenericDiesel" then
		self.TorqueScale = ACF.DieselTorqueScale
	else
		self.TorqueScale = ACF.TorqueScale
	end
	
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
		self.TorqueGUI = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth)*ACF.TorqueBoost
	else
		self.PowerGUI = self.peakkw
		self.TorqueGUI = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth)
	end
	
	local text = "Power: " .. math.Round(self.PowerGUI) .. " kW / " .. math.Round(self.PowerGUI * 1.34) .. " hp\n"
	text = text .. "Torque: " .. math.Round(self.TorqueGUI) .. " Nm / " .. math.Round(self.TorqueGUI * 0.73) .. " ft-lb\n"
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Set Gui on electric&turbine
		text = text .. "Override: " .. math.Round(self.FlywheelOverride) .. " RPM\n"
		text = text .. "Redline: " .. math.Round((self.LimitRPM+self.LimitRPMExtra)) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		if self.RequiresFuel == 1 then text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n" end
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	else --Set Gui on Others
		text = text .. "Powerband: " .. math.Round(self.PeakMinRPM) .. " - " .. math.Round((self.PeakMaxRPM+self.PeakMaxRPMExtra)) .. " RPM\n"
		text = text .. "Redline: " .. math.Round((self.LimitRPM+self.LimitRPMExtra)) .. " RPM\n"
		text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
		text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
		if self.RequiresFuel == 1 then text = text .. "Consumption: " .. math.Round(self.Fuelusing,3) .. " liters/min\n" end
		text = text .. "Idle: " .. math.Round(self.IdleRPM) .. " RPM\n"
		text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg\n"
	end
	self:SetOverlayText( text )
	
end

function ENT:UpdateEngineConsumption()
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.peakkw = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth) * (self.LimitRPM+self.LimitRPMExtra) / (4 * 9548.8)
		self.PeakKwRPM = math.floor((self.LimitRPM+self.LimitRPMExtra) / 2)
	else
		self.peakkw = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth) * (self.PeakMaxRPM+self.PeakMaxRPMExtra) / 9548.8
		self.PeakKwRPM = (self.PeakMaxRPM+self.PeakMaxRPMExtra)
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
	
	if self.EngineType == "GenericDiesel" then
		Entity.ACF.Health = Health * Percent * ACF.DieselEngineHPMult
		Entity.ACF.MaxHealth = Health * ACF.DieselEngineHPMult
	else
		Entity.ACF.Health = Health * Percent * ACF.EngineHPMult
		Entity.ACF.MaxHealth = Health * ACF.EngineHPMult
	end
	Entity.ACF.Armour = Armour * (0.5 + Percent/2)
	Entity.ACF.MaxArmour = Armour * ACF.ArmorMod
	Entity.ACF.Type = nil
	Entity.ACF.Mass = PhysObj:GetMass()
	--Entity.ACF.Density = (PhysObj:GetMass()*1000)/Entity.ACF.Volume
	
	Entity.ACF.Type = "Prop"
	--print(Entity.ACF.Health)
end

function ENT:ACF_OnDamage( Entity, Energy, FrAera, Angle, Inflictor, Bone, Type )	--This function needs to return HitRes

	local Mul = ((Type == "HEAT" and 6.6) or 1) --Heat penetrators deal bonus damage to engines, roughly half an AP round
	local HitRes = ACF_PropDamage( Entity, Energy, FrAera * Mul, Angle, Inflictor )	--Calling the standard damage prop function
	
	return HitRes --This function needs to return HitRes
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
			self:CheckExtra()
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
	self.Torque = self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth
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
	self:UpdateOverlayText()	--Update GUI
	for Key, Extra in pairs(self.ExtraLink) do	--Update Power with Extra Link
		if IsValid( Extra ) then
			self:AddExtraValue( )
		end
	end
	
	--adjusting performance based on damage
	self.TorqueMult = math.Clamp(((1 - self.TorqueScale) / (0.5)) * ((self.ACF.Health/self.ACF.MaxHealth) - 1) + 1, self.TorqueScale, 1)
	self.PeakTorque = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth) * self.TorqueMult
	
	-- Calculate the current torque from flywheel RPM
	self.Torque = boost * self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM, (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
	
	self.Inertia = self.FlywheelMassValue*(3.1416)^2
	
	local Drag
	local TorqueDiff
	if self.Active then
	if( self.CutMode == 0 ) then
		self.Torque = boost * self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.LimitRPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.LimitRPMExtra) - (self.PeakMaxRPM+self.PeakMaxRPMExtra)), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - self.Throttle) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / (self.PeakMaxRPM+self.PeakMaxRPMExtra)) * ( 1 - self.Throttle) / self.Inertia
		end
	
	elseif( self.CutMode == 1 ) then
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.LimitRPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.LimitRPMExtra) - (self.PeakMaxRPM+self.PeakMaxRPMExtra)), 1 ), 0 )
		
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / (self.PeakMaxRPM+self.PeakMaxRPMExtra)) * ( 1 - 0) / self.Inertia
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
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.LimitRPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.LimitRPMExtra) - (self.PeakMaxRPM+self.PeakMaxRPMExtra)), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / (self.PeakMaxRPM+self.PeakMaxRPMExtra)) * ( 1 - 0) / self.Inertia
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
	
	--SET RPM FOR EXTRA
	for Key, Extra in pairs(self.ExtraLink) do
		if IsValid( Extra ) then
			if Extra.KickRpmNumber > 0 then	--Send Rpm for vtec
				if not Extra.Legal then continue end
				Extra:GetRPM( self.FlyRPM )
			end
		end
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
		self.Sound:ChangeVolume( 0.25 + (0.1 + 0.9 * ((SmoothRPM / (self.LimitRPM+self.LimitRPMExtra)) ^ 1.5)) * self.Throttle / 1.5, 0 )
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
	--Allowable Target
	--if not IsValid( Target ) or Target:GetClass() ~= "acf_gearbox" and Target:GetClass() ~= "acf_fueltank" and Target:GetClass() ~= "acf_gearboxcvt" and Target:GetClass() ~= "acf_chips" and Target:GetClass() ~= "acf_nos" and  Target:GetClass() ~= "acf_gearboxauto" then
	if not IsValid( Target ) or not table.HasValue( { "acf_gearbox", "acf_gearboxcvt", "acf_gearboxauto", "acf_fueltank", "acf_chips", "acf_nos" }, Target:GetClass() ) then
		return false, "Can only link to gearboxes, fuel tanks or engine extras!"
	end
	
	if Target:GetClass() == "acf_fueltank" then
		return self:LinkFuel( Target )
	end
	--Link Extra Object
	if self.ExtraUsing == 1 then	--Not link severals Extra Object
		return false, "You CAN'T use more that one Extra!"
	end
	if Target:GetClass() == "acf_chips" or Target:GetClass() == "acf_nos" then
		if self.EngineType == "Turbine" or self.EngineType == "Electric" then
			return false, "You CAN'T link Extra to this engine type!"
		else
			return self:LinkExtra( Target )
		end
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
	--unlink extra
	if Target:GetClass() == "acf_chips" or Target:GetClass() == "acf_nos" then
		return self:UnlinkExtra( Target )
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
	self:UpdateOverlayText()
	
	return true, "Link successful! Now Require Fuel"
	
end

function ENT:UnlinkFuel( Target )
	
	for Key, Value in pairs( self.FuelLink ) do
		if Value == Target then
			self.RequiresFuel = 0
			self:UpdateOverlayText()
			table.remove( self.FuelLink, Key )
			return true, "Unlink successful! Now NOT Require Fuel"
		end
	end
	
	return false, "That fuel tank is not linked to this engine!"
	
end
--LINKING EXTRA
function ENT:LinkExtra( Target )
	
	for Key,Value in pairs(self.ExtraLink) do
		if Value == Target then 
			return false, "It's already linked to this engine!"
		end
	end
	
	if self:GetPos():Distance( Target:GetPos() ) > 512 then
		return false, "The Extra is too far away."
	end
	
	table.insert( self.ExtraLink, Target )
	table.insert( Target.Master, self )
	
	self:AddExtraValue( )	--Add Values
	self.ExtraUsing = 1		--Set Using Extra to 1
	
	return true, "Link successful!"
end
--UNLINK EXTRA
function ENT:UnlinkExtra( Target )
	
	for Key, Value in pairs( self.ExtraLink ) do
		if Value == Target then
			self:RemoveExtraValue( )	--Remove values
			self.ExtraUsing = 0			--Set Using Extra to 0
			table.remove( self.ExtraLink, Key )
			return true, "Unlink successful!"
		end
	end
	
	return false, "That's not linked to this engine!"
	
end
--UNLINK EXTRA out of range
function ENT:CheckExtra()
	for _,extra in pairs(self.ExtraLink) do
		if self:GetPos():Distance(extra:GetPos()) > 512 then
			self:Unlink( extra )
			self:RemoveExtraValue( )	--Remove values
			self.ExtraUsing = 0			--Set Using Extra to 0
			soundstr =  "physics/metal/metal_box_impact_bullet" .. tostring(math.random(1, 3)) .. ".wav"
			self:EmitSound(soundstr,500,100)
		end
	end
end
--ADD EXTRA SETTINGS FUNCTION
function ENT:AddExtraValue( )
	for Key, Extra in pairs(self.ExtraLink) do
		if IsValid( Extra ) then
			self.PeakTorqueExtra = (Extra.TorqueAdd or 0)
			self.PeakMaxRPMExtra = (Extra.MaxRPMAdd or 0)
			self.LimitRPMExtra = (Extra.LimitRPMAdd or 0)
			self:UpdateEngineConsumption()
		end
	end
end
--REMOVE EXTRA SETTINGS FUNCTION
function ENT:RemoveExtraValue( )
	for Key, Extra in pairs(self.ExtraLink) do
		if IsValid( Extra ) then
			self.PeakTorqueExtra = 0
			self.PeakMaxRPMExtra = 0
			self.LimitRPMExtra = 0
			self:UpdateEngineConsumption()
		end
	end
end
--SET THE ENGINE BLOWED (RADIATOR)
function ENT:SetBlow()
	self.Active = false
	self:TriggerInput( "Active" , 0 )
end
--SET ENGINE TORQUE WITH HIS HEALTH (RADIATOR)
function ENT:SetEngineHealth(RadiatorHealth)
	local TorqueBand = (self.PeakTorqueAdd+self.PeakTorqueExtra)/2
	if RadiatorHealth > 0 then
		self.PeakTorqueHealth = math.abs(((TorqueBand*(RadiatorHealth-100))/-100))
	end
	self:UpdateEngineConsumption()
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
	
	--extra link saving
	local extra_info = {}
	local extra_entids = {}
	for Key, Value in pairs(self.ExtraLink) do	--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.ExtraLink, Value)
		end
	end
	for Key, Value in pairs(self.ExtraLink) do	--Then save it
		table.insert(extra_entids, Value:EntIndex())
	end
	
	extra_info.entities = extra_entids
	if extra_info.entities then
		duplicator.StoreEntityModifier( self, "ExtraLink", extra_info )
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
					self:UpdateOverlayText()
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.FuelLink = nil
	end
	
	--Extra link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.ExtraLink) and (Ent.EntityMods.ExtraLink.entities) then
		local ExtraLink = Ent.EntityMods.ExtraLink
		if ExtraLink.entities and table.Count(ExtraLink.entities) > 0 then
			for _,ID in pairs(ExtraLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.ExtraLink = nil
	end
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end
