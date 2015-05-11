AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Engine Maker"
ENT.WireDebugName = "ACF Engine Maker"

if CLIENT then
	
	function ACFEngineMakerGUICreate( Table )
		if not acfmenupanelcustom.ModData then
			acfmenupanelcustom.ModData = {}
		end
		if not acfmenupanelcustom.ModData[Table.id] then
			acfmenupanelcustom.ModData[Table.id] = {}
			acfmenupanelcustom.ModData[Table.id]["ModTable"] = Table.modtable
		end
		
		acfmenupanelcustom:CPanelText("Name", Table.name)
		acfmenupanelcustom:CPanelText("Desc", "Desc : "..Table.desc)
		
		for ID,Value in pairs(acfmenupanelcustom.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_ModingEngine()
			end
		end
				
	acfmenupanelcustom.CustomDisplay:PerformLayout()
	
	end
	
	function ACF_ModingEngine( )
		--Set vars
		local NameLoad = "No Name"
		local SoundLoad = "No Sound"
		local ModelLoad = "models/engines/inline4s.mdl"
		local FuelTypeLoad = "Petrol"
		local EngineTypeLoad = "GenericPetrol"
		local TorqueLoad = 1
		local IdleLoad = 1
		local PeakMinLoad = 1
		local PeakMaxLoad = 1
		local LimitRpmLoad = 1
		local FlywheelLoad = 1
		local WeightLoad = 1
		local EngineSizeText = 1
		local EngineTypeText = 1
		local IselectText = "false"
		local IsTransText = "false"
		local FlywheelOverNumber = 1
		
		if not file.Exists("acf/lastengine.txt", "DATA") then
			local txt = NameLoad..","..SoundLoad..","..ModelLoad..","..FuelTypeLoad..","..EngineTypeLoad..","..TorqueLoad..","
			txt = txt ..IdleLoad..","..PeakMinLoad..","..PeakMaxLoad..","..LimitRpmLoad..","..FlywheelLoad..","..WeightLoad..","
			txt = txt ..EngineSizeText..","..EngineTypeText..","..IselectText..","..IsTransText..","..FlywheelOverNumber
			file.CreateDir("acf")
			file.CreateDir("acf/custom.engines")
			file.Write("acf/lastengine.txt", txt)
			acfmenupanelcustom.CustomDisplay:PerformLayout()
		end
		
		--Start code
		local wide = acfmenupanelcustom.CustomDisplay:GetWide()
		
		Open = vgui.Create("DButton")
		Open:SetText("Open Engine Menu")
		Open:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Open:SetWide(wide)
		Open:SetTall(30)
		Open:SetVisible(true)
		Open.DoClick = function()
			RunConsoleCommand("acf_enginestart_open")
		end
		acfmenupanelcustom.CustomDisplay:AddItem(Open)
		
		DisplayModel = vgui.Create( "DModelPanel", acfmenupanelcustom.CustomDisplay )
		DisplayModel:SetModel( ModelLoad )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 20 )
		DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
		DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( DisplayModel )
		
		acfmenupanelcustom:CPanelText("EngName", "Engine Name : "..NameLoad)
		acfmenupanelcustom:CPanelText("EngSound", "Sound : "..SoundLoad)
		acfmenupanelcustom:CPanelText("EngModel", "Model : "..ModelLoad)
		acfmenupanelcustom:CPanelText("EngFuel", "Fuel Type : "..FuelTypeLoad)
		acfmenupanelcustom:CPanelText("EngType", "Engine Type : "..EngineTypeLoad)
		acfmenupanelcustom:CPanelText("EngTorque", "Torque : "..TorqueLoad)
		acfmenupanelcustom:CPanelText("EngIdle", "Idle Rpm : "..IdleLoad)
		acfmenupanelcustom:CPanelText("EngPeakMin", "Peak Min Rpm : "..PeakMinLoad)
		acfmenupanelcustom:CPanelText("EngPeakMax", "Peak Max Rpm : "..PeakMaxLoad)
		acfmenupanelcustom:CPanelText("EngLimit", "Limit Rpm : "..LimitRpmLoad)
		acfmenupanelcustom:CPanelText("EngFly", "Flywheel Mass : "..FlywheelLoad)
		acfmenupanelcustom:CPanelText("EngWeight", "Weight : "..WeightLoad)
		
		Help = vgui.Create("DButton")
		Help:SetToolTip("1.Create/Load a engine in the Engine menu\n2.Update the text by selecting again Engine Maker\n3.Spawn the Engine !")
		Help:SetTextColor(Color(0,150,0,255))
		Help:SetWide(wide/2)
		Help:SetTall(30)
		Help:SetVisible(true)
		Help:SetText("Help")
		acfmenupanelcustom.CustomDisplay:AddItem(Help)
		
		--Reload Last Engine
		if file.Exists("acf/lastengine.txt", "DATA") then
			local LastEngineText = file.Read("acf/lastengine.txt")
			local EngT = {}
			for w in string.gmatch(LastEngineText, "([^,]+)") do
				table.insert(EngT, w)
			end
			
			RunConsoleCommand( "acfcustom_data1", EngT[1] )
			RunConsoleCommand( "acfcustom_data2", EngT[2] )
			RunConsoleCommand( "acfcustom_data3", EngT[3] )
			RunConsoleCommand( "acfcustom_data4", EngT[4] )
			RunConsoleCommand( "acfcustom_data5", EngT[5] )
			RunConsoleCommand( "acfcustom_data6", EngT[6] )
			RunConsoleCommand( "acfcustom_data7", EngT[7] )
			RunConsoleCommand( "acfcustom_data8", EngT[8] )
			RunConsoleCommand( "acfcustom_data9", EngT[9] )
			RunConsoleCommand( "acfcustom_data10", EngT[10] )
			RunConsoleCommand( "acfcustom_data11", EngT[11] )
			RunConsoleCommand( "acfcustom_data12", EngT[12] )
			RunConsoleCommand( "acfcustom_data13", EngT[15] )
			RunConsoleCommand( "acfcustom_data14", EngT[16] )
			RunConsoleCommand( "acfcustom_data15", EngT[17] )
			
			acfmenupanelcustom:CPanelText("EngName", "Engine Name : "..EngT[1])
			acfmenupanelcustom:CPanelText("EngSound", "Sound : "..EngT[2])
			acfmenupanelcustom:CPanelText("EngModel", "Model : "..EngT[3])
			acfmenupanelcustom:CPanelText("EngFuel", "Fuel Type : "..EngT[4])
			acfmenupanelcustom:CPanelText("EngType", "Engine Type : "..EngT[5])
			acfmenupanelcustom:CPanelText("EngTorque", "Torque : "..EngT[6])
			acfmenupanelcustom:CPanelText("EngIdle", "Idle Rpm : "..EngT[7])
			acfmenupanelcustom:CPanelText("EngPeakMin", "Peak Min Rpm : "..EngT[8])
			acfmenupanelcustom:CPanelText("EngPeakMax", "Peak Max Rpm : "..EngT[9])
			acfmenupanelcustom:CPanelText("EngLimit", "Limit Rpm : "..EngT[10])
			acfmenupanelcustom:CPanelText("EngFly", "Flywheel Mass : "..EngT[11])
			acfmenupanelcustom:CPanelText("EngWeight", "Weight : "..EngT[12])
			DisplayModel:SetModel( EngT[3] )
			
			acfmenupanelcustom.CustomDisplay:PerformLayout()
		end
	
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
	self.FuelTank = 1
	self.Legal = true
	self.CanUpdate = true
	self.RequiresFuel = false
	
	self.CutMode = 0
	self.CutRpm = 0
	self.Fuelusing = 0
	self.DisableCut = 0
	self.ExtraLink = {}
	self.RadiatorLink = {}
	self.PeakTorqueExtra = 0
	self.RPMExtra = 0
	self.ExtraUsing = 0
	self.PeakTorqueHealth = 0
	
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Torque", "Power", "Fuel Use", "Entity", "Mass", "Physical Mass" }, { "NORMAL","NORMAL","NORMAL", "NORMAL", "ENTITY", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput( self, "Entity", self )
end

--###################################################
--##### 			MAKE ENGINE					#####
--###################################################

function MakeACF_EngineMaker(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11, Data12, Data13, Data14, Data15)

	if not Owner:CheckLimit("_acf_maker") then return false end

	local Engine = ents.Create( "acf_engine_maker" )
	if not IsValid( Engine ) then return false end
	
	local EID
	local List = list.Get("ACFCUSTOMEnts")
	if List["MobilityCustom"][Id] then EID = Id else EID = "Maker" end
	local Lookup = List.MobilityCustom[EID]
	
	Engine:SetAngles(Angle)
	Engine:SetPos(Pos)
	Engine:Spawn()
	Engine:SetPlayer(Owner)
	Engine.Owner = Owner
	Engine.Id = EID
	
	Engine.elecpower = Lookup.elecpower
	Engine.SoundPitch = Lookup.pitch or 1
	Engine.SpecialHealth = true
	Engine.SpecialDamage = true
	Engine.TorqueMult = 1
	
	Engine.ModTable = Lookup.modtable
		Engine.ModTable[1] = Data1
		Engine.ModTable[2] = Data2
		Engine.ModTable[3] = Data3
		Engine.ModTable[4] = Data4
		Engine.ModTable[5] = Data5
		Engine.ModTable[6] = Data6
		Engine.ModTable[7] = Data7
		Engine.ModTable[8] = Data8
		Engine.ModTable[9] = Data9
		Engine.ModTable[10] = Data10
		Engine.ModTable[11] = Data11
		Engine.ModTable[12] = Data12
		Engine.ModTable[13] = Data13
		Engine.ModTable[14] = Data14
		Engine.ModTable[15] = Data15
		
		Engine.Mod1 = Data1
		Engine.Mod2 = Data2
		Engine.Mod3 = Data3
		Engine.Mod4 = Data4
		Engine.Mod5 = Data5
		Engine.Mod6 = Data6
		Engine.Mod7 = Data7
		Engine.Mod8 = Data8
		Engine.Mod9 = Data9
		Engine.Mod10 = Data10
		Engine.Mod11 = Data11
		Engine.Mod12 = Data12
		Engine.Mod13 = Data13
		Engine.Mod14 = Data14
		Engine.Mod15 = Data15
		--Set Strings Values
		if tostring(Engine.Mod1) != nil then Engine.EngineName = tostring(Engine.Mod1) else Engine.EngineName = "No Name" end
		if tostring(Engine.Mod2) != nil then Engine.SoundPath = tostring(Engine.Mod2) else Engine.SoundPath = "" end
		if string.find(tostring(Engine.Mod3),".mdl") then Engine.Model = tostring(Engine.Mod3) else Engine.Model = "models/engines/inline4s.mdl" end
		if tostring(Engine.Mod4) != nil then Engine.FuelType = tostring(Engine.Mod4) else Engine.FuelType = "Petrol" end
		if tostring(Engine.Mod5) != nil then Engine.EngineType = tostring(Engine.Mod5) else Engine.EngineType = "GenericPetrol" end
		--Set Torque
		if(tonumber(Engine.Mod6) >= 1) then Engine.PeakTorque = tonumber(Engine.Mod6)
		elseif(tonumber(Data6) < 1 or tonumber(Data6) == nil) then Engine.PeakTorque = 1 end
		--Set Idle
		if(tonumber(Engine.Mod7) >= 1) then Engine.IdleRPM = tonumber(Engine.Mod7)
		elseif(tonumber(Engine.Mod7) < 1 or tonumber(Engine.Mod7) == nil) then Engine.IdleRPM = 1 end
		--Set PeakMin
		if(tonumber(Engine.Mod8) >= 1) then Engine.PeakMinRPM = tonumber(Engine.Mod8)
		elseif(tonumber(Engine.Mod8) < 1 or tonumber(Engine.Mod8) == nil) then Engine.PeakMinRPM = 1 end
		--Set PeakMax
		if(Engine.Mod9 <= Engine.Mod10 and tonumber(Engine.Mod9) >= 1 ) then  Engine.PeakMaxRPM = tonumber(Engine.Mod9)
		elseif(Engine.Mod9 > Engine.Mod10 ) then Engine.PeakMaxRPM = tonumber(Engine.Mod10)
		elseif(tonumber(Engine.Mod9) < 1 or tonumber(Engine.Mod9) == nil) then Engine.PeakMaxRPM = 1 end
		--Set Limit
		if(tonumber(Engine.Mod10) >= 100) then Engine.LimitRPM = tonumber(Engine.Mod10)
		elseif(tonumber(Engine.Mod10) < 100 or tonumber(Engine.Mod10) == nil) then Engine.LimitRPM = 100 end
		--Set Flywheel
		if(tonumber(Engine.Mod11) >= 0.001) then Engine.FlywheelMassValue = tonumber(Engine.Mod11)
		elseif(tonumber(Engine.Mod11) < 0.001 or tonumber(Engine.Mod11) == nil) then Engine.FlywheelMassValue = 0.001 end
		--Set Weight
		if(tonumber(Engine.Mod12) >= 1) then Engine.Weight = tonumber(Engine.Mod12)
		elseif(tonumber(Engine.Mod12) < 1 or tonumber(Engine.Mod12) == nil ) then Engine.Weight = 1 end
		--Set Electric/turbine stuff
		if tobool(Engine.Mod13) != nil then Engine.iselec = tobool(Engine.Mod13) else Engine.iselec = false end
		if tobool(Engine.Mod14) != nil then Engine.IsTrans = tobool(Engine.Mod14) else Engine.IsTrans = false end
		if tonumber(Engine.Mod15) != nil then Engine.FlywheelOverride = tonumber(Engine.Mod15) else Engine.FlywheelOverride = 1200  end
		--Set Original Values
		Engine.PeakTorqueHeld = Engine.PeakTorque
		Engine.CutValue = Engine.LimitRPM / 20
		Engine.CutRpm = Engine.LimitRPM - 100
		Engine.Inertia = Engine.FlywheelMassValue*(3.1416)^2
		--Set Custom Values
		Engine:FirstLoadCustom()
		
		--Creating Wire Inputs
		Engine.CustomLimit = GetConVarNumber("sbox_max_acf_modding")
		local Inputs = {"Active", "Throttle"}
		if Engine.CustomLimit > 0 then
			if Engine.EngineType == "Turbine" or Engine.EngineType == "Electric" then	--Create inputs for Electric&Turbine
				table.insert(Inputs, "TqAdd")
				table.insert(Inputs, "LimitRpmAdd")
				table.insert(Inputs, "FlywheelMass")
				table.insert(Inputs, "Override")
			else		 --Create inputs others engines
				table.insert(Inputs, "TqAdd")
				table.insert(Inputs, "MaxRpmAdd")
				table.insert(Inputs, "LimitRpmAdd")
				table.insert(Inputs, "FlywheelMass")
				table.insert(Inputs, "Idle")
				table.insert(Inputs, "Disable Cutoff")
			end
		end
		Engine.Inputs = Wire_CreateInputs( Engine, Inputs )
		
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

	Engine:SetNWString( "WireName", Lookup.name )
	------ GUI ---------
	Engine.FlywheelMassGUI = Engine.FlywheelMassValue
	Engine:UpdateOverlayText()
	
	Owner:AddCount("_acf_engine_maker", Engine)
	Owner:AddCleanup( "acfmenu", Engine )
	
	ACF_Activate( Engine, 0 )

	return Engine
end
list.Set( "ACFCvars", "acf_engine_maker", {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"} )
duplicator.RegisterEntityClass("acf_engine_maker", MakeACF_EngineMaker, "Pos", "Angle", "Id", "Mod1", "Mod2", "Mod3", "Mod4", "Mod5", "Mod6", "Mod7", "Mod8", "Mod9", "Mod10", "Mod11", "Mod12", "Mod13")

--###################################################
--##### 		UPDATE ENGINE					#####
--###################################################

function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.Active then
		return false, "Turn off the engine before updating it!"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFCUSTOMEnts").MobilityCustom[Id]

	if ArgsTable[7] ~= self.Model then
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
	
	if self.Id != Id then
		self.Id = Id
		self.elecpower = Lookup.elecpower -- how much power does it output
		self.SoundPitch = Lookup.pitch or 1
		self.SpecialHealth = true
		self.SpecialDamage = true
		self.TorqueMult = self.TorqueMult or 1
	end
	self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
	self.ModTable[3] = ArgsTable[7]
	self.ModTable[4] = ArgsTable[8]
	self.ModTable[5] = ArgsTable[9]
	self.ModTable[6] = ArgsTable[10]
	self.ModTable[7] = ArgsTable[11]
	self.ModTable[8] = ArgsTable[12]
	self.ModTable[9] = ArgsTable[13]
	self.ModTable[10] = ArgsTable[14]
	self.ModTable[11] = ArgsTable[15]
	self.ModTable[12] = ArgsTable[16]
	self.ModTable[13] = ArgsTable[17]
	self.ModTable[14] = ArgsTable[18]
	self.ModTable[15] = ArgsTable[19]
	self.Mod1 = ArgsTable[5]
	self.Mod2 = ArgsTable[6]
	self.Mod3 = ArgsTable[7]
	self.Mod4 = ArgsTable[8]
	self.Mod5 = ArgsTable[9]
	self.Mod6 = ArgsTable[10]
	self.Mod7 = ArgsTable[11]
	self.Mod8 = ArgsTable[12]
	self.Mod9 = ArgsTable[13]
	self.Mod10 = ArgsTable[14]
	self.Mod11 = ArgsTable[15]
	self.Mod12 = ArgsTable[16]
	self.Mod13 = ArgsTable[17]
	self.Mod14 = ArgsTable[18]
	self.Mod15 = ArgsTable[19]
	--Set String Values
	if tostring(self.Mod1) != nil then self.EngineName = tostring(self.Mod1) else self.EngineName = "No Name" end
	if tostring(self.Mod2) != nil then self.SoundPath = tostring(self.Mod2) else self.SoundPath = "" end
	if string.find(tostring(self.Mod3),".mdl") then self.Model = tostring(self.Mod3) else self.Model = "models/engines/v8s.mdl" end
	if tostring(self.Mod4) != nil then self.FuelType = tostring(self.Mod4) else self.FuelType = "Petrol" end
	if tostring(self.Mod5) != nil then self.EngineType = tostring(self.Mod5) else self.EngineType = "GenericPetrol" end
	--Set Torque
	if(tonumber(self.Mod6) >= 1) then self.PeakTorque = tonumber(self.Mod6)
	elseif(tonumber(self.Mod6) < 1 or tonumber(self.Mod6) == nil) then self.PeakTorque = 1 end
	--Set Idle
	if(tonumber(self.Mod7) >= 1) then self.IdleRPM = tonumber(self.Mod7)
	elseif(tonumber(self.Mod7) < 1 or tonumber(self.Mod7) == nil) then self.IdleRPM = 1 end
	--Set PeakMin
	if(tonumber(self.Mod8) >= 1) then self.PeakMinRPM = tonumber(self.Mod8)
	elseif(tonumber(self.Mod8) < 1 or tonumber(self.Mod8) == nil) then self.PeakMinRPM = 1 end
	--Set PeakMax
	if(self.Mod9 <= self.Mod10 and tonumber(self.Mod9) >= 1 ) then self.PeakMaxRPM = tonumber(self.Mod9)
	elseif(self.Mod9 > self.Mod10 ) then self.PeakMaxRPM = tonumber(self.Mod10)
	elseif(tonumber(self.Mod9) < 1 or tonumber(self.Mod9) == nil) then self.PeakMaxRPM = 1 end
	--Set Limit
	if(tonumber(self.Mod10) >= 100) then self.LimitRPM = tonumber(self.Mod10)
	elseif(tonumber(self.Mod10) < 100 or tonumber(self.Mod10) == nil) then self.LimitRPM = 100 end
	--Set Flywheel
	if(tonumber(self.Mod11) >= 0.001) then self.FlywheelMassValue = tonumber(self.Mod11)
	elseif(tonumber(self.Mod11) < 0.001 or tonumber(self.Mod11) == nil) then self.FlywheelMassValue = 0.001 end
	--Set Weight
	if(tonumber(self.Mod12) >= 1) then self.Weight = tonumber(self.Mod12)
	elseif(tonumber(self.Mod12) < 1 or tonumber(self.Mod12) == nil) then self.Weight = 1 end
	--Set Electric/Turbine Stuff
	if tobool(self.Mod13) != nil then self.iselec = tobool(self.Mod13) else self.iselec = false end
	if tobool(self.Mod14) != nil then self.IsTrans = tobool(self.Mod14) else self.IsTrans = false end
	if tonumber(self.Mod15) != nil then self.FlywheelOverride = tonumber(self.Mod15) else self.FlywheelOverride = 1200 end
	--Set Original Values
	self.PeakTorqueHeld = self.PeakTorque
	self.CutValue = self.LimitRPM / 20
	self.CutRpm = self.LimitRPM - 100
	self.Inertia = self.FlywheelMassValue*(3.1416)^2
	--Set Custom Values
	self:FirstLoadCustom()
	
	--Creating Wire Inputs
	self.CustomLimit = GetConVarNumber("sbox_max_acf_modding")
	local Inputs = {"Active", "Throttle"}
	if self.CustomLimit > 0 then
		if self.EngineType == "Turbine" or self.EngineType == "Electric" then	--Create inputs for Electric&Turbine
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Override")
		else 		--Create inputs others engines
			table.insert(Inputs, "TqAdd")
			table.insert(Inputs, "MaxRpmAdd")
			table.insert(Inputs, "LimitRpmAdd")
			table.insert(Inputs, "FlywheelMass")
			table.insert(Inputs, "Idle")
			table.insert(Inputs, "Disable Cutoff")
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

	self:SetNWString( "WireName", self.EngineName )
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
	self.PeakTorqueNormal = self.PeakTorque
	self.PeakMaxRPMNormal = self.PeakMaxRPM
	self.LimitRPMNormal = self.LimitRPM
	self.FlywheelMassNormal = self.FlywheelMassValue
	self.IdleRPMNormal = self.IdleRPM
	self.FlywheelOverrideNormal = self.FlywheelOverride
	self.CutValue = self.LimitRPM / 20
	self.CutRpm = self.LimitRPM - 100
	self.PeakTorqueAdd = self.PeakTorque
end

function ENT:UpdateOverlayText()
	local SpecialBoost = self.RequiresFuel and ACF.TorqueBoost or 1
	self.PowerGUI = self.peakkw*SpecialBoost
	self.TorqueGUI = (self.PeakTorqueAdd+self.PeakTorqueExtra-self.PeakTorqueHealth)*SpecialBoost
	self.FuelusingGUI = self.Fuelusing
	self.FlyRPMGUI = self.FlyRPM
	
	local text = "Power: " .. math.Round(self.PowerGUI) .. " kW / " .. math.Round(self.PowerGUI * 1.34) .. " hp\n"
	text = text .. "Torque: " .. math.Round(self.TorqueGUI) .. " Nm / " .. math.Round(self.TorqueGUI * 0.73) .. " ft-lb\n"
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		text = text .. "Override: " .. math.Round(self.FlywheelOverride) .. " RPM\n"
	else
		text = text .. "Powerband: " .. math.Round(self.PeakMinRPM) .. " - " .. math.Round((self.PeakMaxRPM+self.RPMExtra)) .. " RPM\n"
		text = text .. "Idle: " .. math.Round(self.IdleRPM) .. " RPM\n"
	end
	text = text .. "Redline: " .. math.Round((self.LimitRPM+self.RPMExtra)) .. " RPM\n"
	text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMassGUI,3) .. " Kg\n"
	text = text .. "Rpm: " .. math.Round(self.FlyRPM) .. " RPM\n"
	if self.RequiresFuel then text = text .. "Consumption: " .. math.Round(self.FuelusingGUI,3) .. " liters/min\n" end
	text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg"

	self:SetOverlayText( text )
end

function ENT:UpdateEngineConsumption()
	if self.EngineType == "Turbine" or self.EngineType == "Electric" then
		self.peakkw = (self.PeakTorque+self.PeakTorqueExtra-self.PeakTorqueHealth) * (self.LimitRPM+self.RPMExtra) / (4 * 9548.8)
		self.PeakKwRPM = math.floor((self.LimitRPM+self.RPMExtra) / 2)
	else
		self.peakkw = (self.PeakTorque+self.PeakTorqueExtra-self.PeakTorqueHealth) * (self.PeakMaxRPM+self.RPMExtra) / 9548.8
		self.PeakKwRPM = (self.PeakMaxRPM+self.RPMExtra)
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
			if not self.RequiresFuel then
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
			if not self.RequiresFuel then
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
	
	elseif (iname == "TqAdd") then
		if (self.PeakTorqueAdd != self.PeakTorqueNormal+value) then
			self.PeakTorqueAdd = self.PeakTorqueNormal+value
			self:UpdateEngineConsumption()
		end
	elseif (iname == "RpmAdd") then
		if (self.PeakMaxRPM != self.PeakMaxRPMNormal+value) then
			self.PeakMaxRPM = self.PeakMaxRPMNormal+value
			self.LimitRPM = self.LimitRPMNormal+value
			self.CutValue = self.LimitRPM / 20
			self.CutRpm = self.LimitRPM - 100
			self:UpdateEngineConsumption()
		end
	elseif (iname == "FlywheelMass") then
		if (value > 0 and self.FlywheelMassValue != value) then
			self.FlywheelMassValue = value
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		elseif (value <= 0 and self.FlywheelMassValue != self.FlywheelMassNormal) then
			self.FlywheelMassValue = self.FlywheelMassNormal
			self.FlywheelMassGUI = self.FlywheelMassValue
			self:UpdateOverlayText()
		end
	elseif (iname == "Override") then
		if (value > 0 and self.FlywheelOverride != value) then
			self.FlywheelOverride = value
			self:UpdateOverlayText()
		elseif (value <= 0 and self.FlywheelOverride != self.FlywheelOverrideNormal) then
			self.FlywheelOverride = self.FlywheelOverrideNormal
			self:UpdateOverlayText()
		end
	elseif (iname == "Idle") then
		if (value > 0 and self.IdleRPM != value) then
			self.IdleRPM = value
			self:UpdateOverlayText()
		elseif (value <= 0 and self.IdleRPM != self.IdleRPMNormal) then
			self.IdleRPM = self.IdleRPMNormal
			self:UpdateOverlayText()
		end
	elseif (iname == "Disable Cutoff") then
		if (value > 0 and self.DisableCut != 1) then
			self.DisableCut = 1
		elseif (value <= 0 and self.DisableCut != 0) then
			self.DisableCut = 0
		end
	end
end

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
	elseif self.EngineType == "Electric" then
		Entity.ACF.Health = Health * Percent * ACF.ElectricEngineHPMult
		Entity.ACF.MaxHealth = Health * ACF.ElectricEngineHPMult
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

	local Mul = ((Type == "HEAT" and ACF.HEATMulEngine) or 1) --Heat penetrators deal bonus damage to engines
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
			self:CheckRadiator()
			self:CalcMassRatio()
			self.Legal = self:CheckLegal()

			self.LastCheck = Time + math.Rand(5, 10)
		end
	else
		--SET VALUES FOR RADIATORS
		for Key, Radiator in pairs(self.RadiatorLink) do
			if IsValid( Radiator ) then
				if Radiator.GetRpm == true then
					if not Radiator.Legal then continue end
					Radiator:GetRPM(0, self.LimitRPM, self.Active2)
				end
			end
		end
	end
	
	self:SetRadsInfos()

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
	
	--find next active tank with fuel
	local Tank = nil
	local boost = 1
	local i = 0
	local MaxTanks = #self.FuelLink
	
	while i <= MaxTanks  and not (Tank and Tank:IsValid() and Tank.Fuel > 0) do
		self.FuelTank = self.FuelTank % MaxTanks + 1
		Tank = self.FuelLink[self.FuelTank]
		if Tank and Tank:IsValid() and Tank.Fuel > 0 and Tank.Active then
			break --return Tank
		end
		Tank = nil
		i = i + 1
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
	elseif self.RequiresFuel then
		self:TriggerInput( "Active", 0 ) --shut off if no fuel and requires it
		return 0
	else
		Wire_TriggerOutput(self, "Fuel Use", 0)
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
			self.Torque = boost * self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.RPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.RPMExtra) - (self.PeakMaxRPM+self.RPMExtra)), 1 ), 0 )
			
			if self.iselec == true then
				Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - self.Throttle) / self.Inertia
			else
				Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / (self.PeakMaxRPM+self.RPMExtra)) * ( 1 - self.Throttle) / self.Inertia
			end
		
		elseif( self.CutMode == 1 ) then
			self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.RPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.RPMExtra) - (self.PeakMaxRPM+self.RPMExtra)), 1 ), 0 )
			
			if self.iselec == true then
				Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
			else
				Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / (self.PeakMaxRPM+self.RPMExtra)) * ( 1 - 0) / self.Inertia
			end
			
		end 
		-- Let's accelerate the flywheel based on that torque
		self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
		-- This is the presently avaliable torque from the engine
		TorqueDiff = math.max( self.FlyRPM - self.IdleRPM, 0 ) * self.Inertia
	else
		self.Torque = boost * 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , ((self.LimitRPM+self.RPMExtra) - self.FlyRPM) / ((self.LimitRPM+self.RPMExtra) - (self.PeakMaxRPM+self.RPMExtra)), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / (self.PeakMaxRPM+self.RPMExtra)) * ( 1 - 0) / self.Inertia
		end
	
		-- Let's accelerate the flywheel based on that torque
		self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
		-- This is the presently avaliable torque from the engine
		TorqueDiff = 0
	end
	
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
		Link.Ent:Act( Link.ReqTq * AvailRatio * self.MassRatio, DeltaTime, self.MassRatio )
	end

	self.FlyRPM = self.FlyRPM - math.min( TorqueDiff, TotalReqTq ) / self.Inertia
	
	if( self.DisableCut == 0 ) then
		if( self.FlyRPM >= self.CutRpm and self.CutMode == 0 ) then
			self.CutMode = 1
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			local MakeSound = math.random(1,3)
			if MakeSound <= 1 and self.Sound2 and self.Sound2:IsPlaying() then self.Sound2:Stop() end
			if MakeSound <= 1 then
				self.Sound2 = CreateSound(self, "ambient/explosions/explode_4.wav")
				self.Sound2:PlayEx(0.7,100)
			end
		end
		if( self.FlyRPM <= self.CutRpm - self.CutValue and self.CutMode == 1 ) then
			self.CutMode = 0
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
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
	
	--Update Gui
	if self.FuelusingGUI != self.Fuelusing or self.FlyRPMGUI != self.FlyRPM then
		self:UpdateOverlayText()
	end
	--Update extras values
	for Key, Extra in pairs(self.ExtraLink) do
		if IsValid(Extra) then
			if self.PeakTorqueExtra != (Extra.TorqueAdd or 0) or self.RPMExtra != (Extra.RPMAdd or 0) then
				self:AddExtraValue()
			end
			if Extra.GetRpm == true then
				if not Extra.Legal then continue end
				local PeakTorqueSend = (self.PeakTorqueAdd-self.PeakTorqueHealth)*self.TorqueMult
				Extra:GetRPM(self.FlyRPM, self.LimitRPM, self.Weight, self.Throttle, self.EngineType, PeakTorqueSend, self.IdleRPM)
			end
		end
	end
	--Update radiator values
	for Key, Radiator in pairs(self.RadiatorLink) do
		if IsValid( Radiator ) then
			if Radiator.GetRpm == true then
				if not Radiator.Legal then continue end
				Radiator:GetRPM(self.FlyRPM, self.LimitRPM, self.Active2)
			end
		end
	end
	
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
		self.Sound:ChangeVolume( 0.25 + (0.1 + 0.9 * ((SmoothRPM / (self.LimitRPM+self.RPMExtra)) ^ 1.5)) * self.Throttle / 1.5, 0 )
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
	if not IsValid( Target ) or not table.HasValue( { "acf_gearbox", "acf_gearboxcvt", "acf_gearboxauto", "acf_fueltank", "acf_chips", "acf_nos", "acf_rads", "acf_turbo", "acf_supercharger" }, Target:GetClass() ) then
		return false, "Can only link to gearboxes, fuel tanks or engine extras!"
	end
	--Fuel Tank Linking
	if Target:GetClass() == "acf_fueltank" then
		return self:LinkFuel( Target )
	end
	--Extra Linking
	if Target:GetClass() == "acf_chips" or Target:GetClass() == "acf_nos" or Target:GetClass() == "acf_turbo" or Target:GetClass() == "acf_supercharger" then
		if self.ExtraUsing == 1 then	--Not link severals Extra Obje
			return false, "You CAN'T use more that one Extra!"
		else
			return self:LinkExtra( Target )
		end
	end
	--Radiators Linking
	if Target:GetClass() == "acf_rads" then
		return self:LinkRadiator( Target )
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
	--unlink fuel tank
	if Target:GetClass() == "acf_fueltank" then
		return self:UnlinkFuel( Target )
	end
	--unlink extra
	if Target:GetClass() == "acf_chips" or Target:GetClass() == "acf_nos" or Target:GetClass() == "acf_turbo" or Target:GetClass() == "acf_supercharger" then
		return self:UnlinkExtra( Target )
	end
	--unlink radiator
	if Target:GetClass() == "acf_rads" then
		return self:UnlinkRadiator( Target )
	end
	--unlink gearboxes
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
--LINKING FUEL TANK
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
	
	self.RequiresFuel = true
	self:UpdateOverlayText()
	
	return true, "Link successful! Now Require Fuel"
	
end
--UNLINK FUEL TANK
function ENT:UnlinkFuel( Target )
	
	for Key, Value in pairs( self.FuelLink ) do
		if Value == Target then
			self.RequiresFuel = false
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
			self.RPMExtra = (Extra.RPMAdd or 0)
			self:UpdateEngineConsumption()
		end
	end
end
--REMOVE EXTRA SETTINGS FUNCTION
function ENT:RemoveExtraValue( )
	self.PeakTorqueExtra = 0
	self.RPMExtra = 0
	self:UpdateEngineConsumption()
end
--LINKING RADIATOR
function ENT:LinkRadiator( Target )
	for Key,Value in pairs(self.RadiatorLink) do
		if Value == Target then 
			return false, "It's already linked to this engine!"
		end
	end
	
	if self:GetPos():Distance( Target:GetPos() ) > 512 then
		return false, "The Radiator is too far away."
	end
	
	table.insert( self.RadiatorLink, Target )
	table.insert( Target.Master, self )
	
	return true, "Link successful!"
end
--UNLINK RADIATOR
function ENT:UnlinkRadiator( Target )
	for Key, Value in pairs( self.RadiatorLink ) do
		if Value == Target then
			self.PeakTorqueHealth = 0
			self:UpdateEngineConsumption()
			table.remove( self.RadiatorLink, Key )
			return true, "Unlink successful!"
		end
	end
	
	return false, "That's not linked to this engine!"
end
--UNLINK Radiator out of range
function ENT:CheckRadiator()
	for _,radiator in pairs(self.RadiatorLink) do
		if self:GetPos():Distance(radiator:GetPos()) > 512 then
			self:Unlink( radiator )
			soundstr =  "physics/metal/metal_box_impact_bullet" .. tostring(math.random(1, 3)) .. ".wav"
			self:EmitSound(soundstr,500,100)
		end
	end
end
--SET Radiator Functions
function ENT:SetRadsInfos()
	local Blowed = false
	
	for Key, Radiator in pairs(self.RadiatorLink) do
		if IsValid( Radiator ) then
			local TorqueBand = (self.PeakTorqueAdd+self.PeakTorqueExtra)/2
			self.PeakTorqueHealth = math.abs(((TorqueBand*(Radiator.HealthVal-100))/-100))
			if Radiator.HealthVal <= 0 then Blowed = true end
			self:UpdateEngineConsumption()
		end
	end
	
	if Blowed then
		self.Active = false
		self:TriggerInput( "Active" , 0 )
	end
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
	local extra_info, extra_entids = {}
	for Key, Value in pairs(self.ExtraLink) do
		if not Value:IsValid() then table.remove(self.ExtraLink, Value) end
	end
	for Key, Value in pairs(self.ExtraLink) do table.insert(extra_entids, Value:EntIndex()) end
	
	extra_info.entities = extra_entids
	if extra_info.entities then duplicator.StoreEntityModifier( self, "ExtraLink", extra_info ) end
	
	--radiator link saving
	local rads_info, rads_entids = {}
	for Key, Value in pairs(self.RadiatorLink) do
		if not Value:IsValid() then table.remove(self.RadiatorLink, Value) end
	end
	for Key, Value in pairs(self.RadiatorLink) do table.insert(rads_entids, Value:EntIndex()) end
	
	rads_info.entities = rads_entids
	if rads_info.entities then duplicator.StoreEntityModifier( self, "RadiatorLink", rads_info ) end

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
					self.RequiresFuel = true
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
				if IsValid( Linked ) then self:Link( Linked ) end
			end
		end
		Ent.EntityMods.ExtraLink = nil
	end
	
	--Radiator link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.RadiatorLink) and (Ent.EntityMods.RadiatorLink.entities) then
		local RadiatorLink = Ent.EntityMods.RadiatorLink
		if RadiatorLink.entities and table.Count(RadiatorLink.entities) > 0 then
			for _,ID in pairs(RadiatorLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then self:Link( Linked ) end
			end
		end
		Ent.EntityMods.RadiatorLink = nil
	end
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end
