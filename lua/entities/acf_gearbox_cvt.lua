AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Gearbox CVT"
ENT.WireDebugName = "ACF Gearbox CVT"

if CLIENT then

	local ACF_GearboxCVTInfoWhileSeated = CreateClientConVar("ACF_GearboxCVTInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
	
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACF_GearboxCVTInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
		
	end
	
	function ACFGearboxCVTGUICreate( Table )
	
		if not acfmenupanelcustom.GearboxData then
			acfmenupanelcustom.GearboxData = {}
		end
		if not acfmenupanelcustom.GearboxData[Table.id] then
			acfmenupanelcustom.GearboxData[Table.id] = {}
			acfmenupanelcustom.GearboxData[Table.id].GearTable = Table.geartable
		end
			
		acfmenupanelcustom:CPanelText("Name", Table.name)
		
		acfmenupanelcustom.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanelcustom.CustomDisplay )
			acfmenupanelcustom.CData.DisplayModel:SetModel( Table.model )
			acfmenupanelcustom.CData.DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
			acfmenupanelcustom.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanelcustom.CData.DisplayModel:SetFOV( 20 )
			acfmenupanelcustom.CData.DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
			acfmenupanelcustom.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData.DisplayModel )
		
		acfmenupanelcustom:CPanelText("Desc", "Desc : "..Table.desc)
		acfmenupanelcustom:CPanelText("MaxTq", "Max Torque Rating : "..(Table.maxtq).."n-m / "..math.Round(Table.maxtq*0.73).."ft-lb\nWeight : "..(Table.weight).." kg")
		for ID,Value in pairs(acfmenupanelcustom.GearboxData[Table.id]["GearTable"]) do
			if ID > 0 and ID < 3 then
				ACF_CvtSlider1(ID, Value, Table.id)
			elseif ID == 3 then
				ACF_CvtSlider3(3, Value, Table.id, "Ratio Minimum")
			elseif ID == 4 then
				ACF_CvtSlider4(4, Value, Table.id, "Ratio Maximum")
			elseif ID == 5 then
				ACF_CvtSlider2(5, Value, Table.id, "Rpm maximum")
			elseif ID == 6 then
				ACF_CvtSlider5(6, Value, Table.id, "Rpm minimum")
			elseif ID == 7 then
				ACF_CvtSlider6(7, Value, Table.id, "Declutch Rpm")
			end
		end
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		maxtorque = Table.maxtq
	end

	function ACF_CvtSlider1(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Gear "..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( -1 )
				acfmenupanelcustom.CData[Gear]:SetMax( 1 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 2 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end

	function ACF_CvtSlider2(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Rpm maximum"..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( 3000 )
				acfmenupanelcustom.CData[Gear]:SetMax( 10000 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 0 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end

	function ACF_CvtSlider3(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Ratio Minimum"..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( 0.001 )
				acfmenupanelcustom.CData[Gear]:SetMax( 0.5 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 3 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end

	function ACF_CvtSlider4(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Ratio Maximum"..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( 0.3 )
				acfmenupanelcustom.CData[Gear]:SetMax( 4 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 1 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end

	function ACF_CvtSlider5(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Rpm minimum"..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( 2000 )
				acfmenupanelcustom.CData[Gear]:SetMax( 7000 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 0 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end

	function ACF_CvtSlider6(Gear, Value, ID, Desc)
		if Gear and not acfmenupanelcustom.CData[Gear] then	
			acfmenupanelcustom.CData[Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Gear]:SetText( Desc or "Declutch Rpm"..Gear )
				acfmenupanelcustom.CData[Gear].Label:SizeToContents()
				acfmenupanelcustom.CData[Gear]:SetMin( 1000 )
				acfmenupanelcustom.CData[Gear]:SetMax( 4000 )
				acfmenupanelcustom.CData[Gear]:SetDecimals( 0 )
				acfmenupanelcustom.CData[Gear]["Gear"] = Gear
				acfmenupanelcustom.CData[Gear]["ID"] = ID
				acfmenupanelcustom.CData[Gear]:SetValue(Value)
				acfmenupanelcustom.CData[Gear]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom.CData[Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Gear] )
		end
	end
	
	return
	
end

function ENT:Initialize()
	
	self.IsGeartrain = true
	self.Master = {}
	self.IsMaster = true
	
	self.WheelLink = {} -- a "Link" has these components: Ent, Side, Axis, Rope, RopeLen, Output, ReqTq, Vel
	
	self.TotalReqTq = 0
	self.RClutch = 0
	self.LClutch = 0
	self.LBrake = 0
	self.RBrake = 0
	self.SteerRate = 0

	self.Gear = 1
	self.GearRatio = 0
	self.ChangeFinished = 0
	
	self.LegalThink = 0
	
	self.RPM = {}
	self.CurRPM = 0
	self.InGear = false
	self.CanUpdate = true
	self.LastActive = 0
	self.Legal = true
	
	self.CurrentRPM = 0
	self.ClutchMode = 0
	self.ClutchModeUse = 0
	
end  

function MakeACF_GearboxCVT(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local GearboxCVT = ents.Create("acf_gearbox_cvt")
	local List = list.Get("ACFCUSTOMEnts")
	local Classes = list.Get("ACFClasses")
	if not IsValid( GearboxCVT ) then return false end
	GearboxCVT:SetAngles(Angle)
	GearboxCVT:SetPos(Pos)
	GearboxCVT:Spawn()

	GearboxCVT:SetPlayer(Owner)
	GearboxCVT.Owner = Owner
	GearboxCVT.Id = Id
	GearboxCVT.Model = List.MobilityCustom[Id].model
	GearboxCVT.Mass = List.MobilityCustom[Id].weight
	GearboxCVT.SwitchTime = List.MobilityCustom[Id].switch
	GearboxCVT.MaxTorque = List.MobilityCustom[Id].maxtq
	GearboxCVT.Gears = List.MobilityCustom[Id].gears
	GearboxCVT.Dual = List.MobilityCustom[Id].doubleclutch
	GearboxCVT.GearTable = List.MobilityCustom[Id].geartable
		GearboxCVT.GearTable.Final = Data10
		GearboxCVT.GearTable[1] = Data1
		GearboxCVT.GearTable[2] = Data2
		GearboxCVT.GearTable[3] = Data3
		GearboxCVT.GearTable[4] = Data4
		GearboxCVT.GearTable[5] = Data5
		GearboxCVT.GearTable[6] = Data6
		GearboxCVT.GearTable[7] = Data7
		GearboxCVT.GearTable[8] = Data8
		GearboxCVT.GearTable[9] = Data9
		GearboxCVT.GearTable[0] = 0
		
		GearboxCVT.Gear0 = Data10
		GearboxCVT.Gear1 = Data1
		GearboxCVT.Gear2 = Data2
		GearboxCVT.Gear3 = Data3
		GearboxCVT.Gear4 = Data4
		GearboxCVT.Gear5 = Data5
		GearboxCVT.Gear6 = Data6
		GearboxCVT.Gear7 = Data7
		GearboxCVT.Gear8 = Data8
		GearboxCVT.Gear9 = Data9
				
	GearboxCVT:SetModel( GearboxCVT.Model )	
	
	GearboxCVT.GearFinal = tonumber(GearboxCVT.Gear3)
	GearboxCVT.RatioMin = tonumber(GearboxCVT.Gear3)
	GearboxCVT.RatioMax = tonumber(GearboxCVT.Gear4)
	GearboxCVT.RpmLimit = tonumber(GearboxCVT.Gear5)
	GearboxCVT.RpmLimit2 = tonumber(GearboxCVT.Gear6)
	GearboxCVT.DeclutchRpm = tonumber(GearboxCVT.Gear7)
	GearboxCVT.GearFinal2 = tonumber(GearboxCVT.GearFinal)
		
	local Inputs = {"Gear","Gear Up","Gear Down"}
	if GearboxCVT.Dual then
		table.insert(Inputs, "Left Clutch")
		table.insert(Inputs, "Right Clutch")
		table.insert(Inputs, "Left Brake")
		table.insert(Inputs, "Right Brake")
	else
		table.insert(Inputs, "Clutch")
		table.insert(Inputs, "Brake")
	end
	
    GearboxCVT.Inputs = Wire_CreateInputs( GearboxCVT.Entity, Inputs )
	GearboxCVT.Outputs = WireLib.CreateSpecialOutputs( GearboxCVT.Entity, { "Ratio", "Entity" , "Current Gear", "Gearbox RPM" }, { "NORMAL" , "ENTITY" , "NORMAL" , "NORMAL" } )
	Wire_TriggerOutput(GearboxCVT.Entity, "Entity", GearboxCVT.Entity)
	
	GearboxCVT.LClutch = GearboxCVT.MaxTorque
	GearboxCVT.RClutch = GearboxCVT.MaxTorque

	GearboxCVT:PhysicsInit( SOLID_VPHYSICS )      	
	GearboxCVT:SetMoveType( MOVETYPE_VPHYSICS )     	
	GearboxCVT:SetSolid( SOLID_VPHYSICS )

	local phys = GearboxCVT:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( GearboxCVT.Mass ) 
	end
	
	GearboxCVT.In = GearboxCVT:WorldToLocal(GearboxCVT:GetAttachment(GearboxCVT:LookupAttachment( "input" )).Pos)
	GearboxCVT.OutL = GearboxCVT:WorldToLocal(GearboxCVT:GetAttachment(GearboxCVT:LookupAttachment( "driveshaftL" )).Pos)
	GearboxCVT.OutR = GearboxCVT:WorldToLocal(GearboxCVT:GetAttachment(GearboxCVT:LookupAttachment( "driveshaftR" )).Pos)
	
	Owner:AddCount("_acf_gearbox_cvt", GearboxCVT)
	Owner:AddCleanup( "acfcustom", GearboxCVT )
	
	GearboxCVT:ChangeGear(1)
	
	if GearboxCVT.Dual then
		GearboxCVT:SetBodygroup(1, 1)
	else
		GearboxCVT:SetBodygroup(1, 0)
	end
	
	GearboxCVT:SetNWString( "WireName", List.MobilityCustom[Id].name )
	GearboxCVT:UpdateOverlayText()
		
	return GearboxCVT
end
list.Set( "ACFCvars", "acf_gearbox_cvt" , {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"} )
duplicator.RegisterEntityClass("acf_gearbox_cvt", MakeACF_GearboxCVT, "Pos", "Angle", "Id", "Gear1", "Gear2", "Gear3", "Gear4", "Gear5", "Gear6", "Gear7", "Gear8", "Gear9", "Gear0" )

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that gearbox!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFCUSTOMEnts")
	
	if List.MobilityCustom[Id].model ~= self.Model then
		return false, "The new gearbox must have the same model!"
	end
		
	if self.Id != Id then
	
		self.Id = Id
		self.Mass = List.MobilityCustom[Id].weight
		self.SwitchTime = List.MobilityCustom[Id].switch
		self.MaxTorque = List.MobilityCustom[Id].maxtq
		self.Gears = List.MobilityCustom[Id].gears
		self.Dual = List.MobilityCustom[Id].doubleclutch
		
		local Inputs = {"Gear","Gear Up","Gear Down"}
		if self.Dual then
			table.insert(Inputs,"Left Clutch")
			table.insert(Inputs,"Right Clutch")
			table.insert(Inputs,"Left Brake")
			table.insert(Inputs,"Right Brake")
		else
			table.insert(Inputs, "Clutch")
			table.insert(Inputs, "Brake")
		end
		
		local phys = self:GetPhysicsObject()    
		if IsValid( phys ) then 
			phys:SetMass( self.Mass ) 
		end
		
		self.Inputs = Wire_CreateInputs( self, Inputs )
        Wire_TriggerOutput( self, "Entity", self )
		
	end
	
	self.GearTable.Final = ArgsTable[14]
	self.GearTable[1] = ArgsTable[5]
	self.GearTable[2] = ArgsTable[6]
	self.GearTable[3] = ArgsTable[7]
	self.GearTable[4] = ArgsTable[8]
	self.GearTable[5] = ArgsTable[9]
	self.GearTable[6] = ArgsTable[10]
	self.GearTable[7] = ArgsTable[11]
	self.GearTable[8] = ArgsTable[12]
	self.GearTable[9] = ArgsTable[13]
	self.GearTable[0] = 0
	
	self.Gear0 = ArgsTable[14]
	self.Gear1 = ArgsTable[5]
	self.Gear2 = ArgsTable[6]
	self.Gear3 = ArgsTable[7]
	self.Gear4 = ArgsTable[8]
	self.Gear5 = ArgsTable[9]
	self.Gear6 = ArgsTable[10]
	self.Gear7 = ArgsTable[11]
	self.Gear8 = ArgsTable[12]
	self.Gear9 = ArgsTable[13]
	
	self:ChangeGear(1)
	
	self.GearFinal = tonumber(self.Gear3)
	self.RatioMin = tonumber(self.Gear3)
	self.RatioMax = tonumber(self.Gear4)
	self.RpmLimit = tonumber(self.Gear5)
	self.RpmLimit2 = tonumber(self.Gear6)
	self.DeclutchRpm = tonumber(self.Gear7)
	self.GearFinal2 = tonumber(self.GearFinal)
	
	if self.Dual then
		self:SetBodygroup(1, 1)
	else
		self:SetBodygroup(1, 0)
	end	
	
	self:SetNWString( "WireName", List.MobilityCustom[Id].name )
	self:UpdateOverlayText()
	
	return true, "CVT Gearbox updated successfully!"
end

function ENT:UpdateOverlayText()
	
	local text = "Current Gear: " .. self.Gear .. "\n"
	text = text .. "Final Ratio: " .. self.GearFinal2 .. "\n"
	text = text .. "Gear1: " .. self.Gear1 .. "\n"
	text = text .. "Gear2: " .. self.Gear2 .. "\n"
	text = text .. "Rpm Max: " .. self.RpmLimit .. "Rpm\n"
	text = text .. "Rpm Min: " .. self.RpmLimit2 .. "Rpm\n"
	text = text .. "Declutch: " .. self.DeclutchRpm .. "Rpm\n"
	text = text .. "Weight: "..self.Mass.." Kg\n"
	
	self:SetOverlayText( text )
	
end


-- prevent people from changing bodygroup
function ENT:CanProperty( ply, property )
	return property ~= "bodygroups"
end

function ENT:TriggerInput( iname , value )
	if ( iname == "Gear" and self.Gear != math.floor(value) ) then
		self:ChangeGear(math.floor(value))
	elseif ( iname == "Gear Up" ) then
		if ( self.Gear < self.Gears and value > 0 ) then
			self:ChangeGear(math.floor(self.Gear + 1))
		end
	elseif ( iname == "Gear Down" ) then
		if ( self.Gear > 1 and value > 0 ) then
			self:ChangeGear(math.floor(self.Gear - 1))
		end
	elseif ( iname == "Clutch" ) then
		self.ClutchModeUse = value
		self.ClutchMode = value
		self.LClutch = math.Clamp(1-value,0,1)*self.MaxTorque
		self.RClutch = math.Clamp(1-value,0,1)*self.MaxTorque
	elseif ( iname == "Brake" ) then
		self.LBrake = math.Clamp(value,0,100)
		self.RBrake = math.Clamp(value,0,100)
	elseif ( iname == "Left Brake" ) then
		self.LBrake = math.Clamp(value,0,100)
	elseif ( iname == "Right Brake" ) then
		self.RBrake = math.Clamp(value,0,100)
	elseif ( iname == "Left Clutch" ) then
		self.LClutch = math.Clamp(1-value,0,1)*self.MaxTorque
	elseif ( iname == "Right Clutch" ) then
		self.RClutch = math.Clamp(1-value,0,1)*self.MaxTorque
	end
end

function ENT:Think()
	local Time = CurTime()
	
	if self.LastActive + 2 > Time then
		self:CheckRopes()
	end
	
	self.Legal = self:CheckLegal()
	
	self:NextThink(Time+0.2)
	return true
end

function ENT:CheckLegal()

	--make sure it's not invisible to traces
	if not self:IsSolid() then return false end
	
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Mass then return false end
	
	self.RootParent = nil
	local rootparent = self:GetParent()
	
	-- if it's not parented, we're fine
	if not IsValid( rootparent ) then return true end
	
	--find the root parent
	local depth = 0
	while rootparent:GetParent():IsValid() and depth<5 do
		depth = depth + 1
		rootparent = rootparent:GetParent()
	end
	
	--if there's still more parents, it's not legal
	if rootparent:GetParent():IsValid() then return false end
	
	--if it's welded, make sure it's welded to root parent
	if IsValid( constraint.FindConstraintEntity( self, "Weld" ) ) then
		for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
			if v.Ent1 == rootparent or v.Ent2 == rootparent then return true end
		end
	else
		--if it's parented and not welded, check that it's allowed for this gearbox type
		if self.Parentable then
			self.RootParent = rootparent
			return true
		end
	end
	
	return false
	
end

function ENT:CheckRopes()

	for Key, Link in pairs( self.WheelLink ) do
	
		local Ent = Link.Ent
		
		local OutPos = self:LocalToWorld( Link.Output )
		local InPos = Ent:GetPos()
		if Ent.IsGeartrain then
			InPos = Ent:LocalToWorld( Ent.In )
		end
		
		-- make sure it is not stretched too far
		if OutPos:Distance( InPos ) > Link.RopeLen * 1.5 then
			self:Unlink( Ent )
		end
		
		-- make sure the angle is not excessive
		local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( ( self:GetRight() * Link.Output.y ):GetNormalized() )
		if DrvAngle < 0.7 then
			self:Unlink( Ent )
		end
		
	end

end

-- Check if every entity we are linked to still actually exists
-- and remove any links that are invalid.
function ENT:CheckEnts()
	
	for Key, Link in pairs( self.WheelLink ) do
	
		if not IsValid( Link.Ent ) then
			table.remove( self.WheelLink, Key )
		continue end

		local Phys = Link.Ent:GetPhysicsObject()
		if not IsValid( Phys ) then
			Link.Ent:Remove()
			table.remove( self.WheelLink, Key )
		end
		
	end
	
end

function ENT:Calc( InputRPM, InputInertia )
	if self.LastActive == CurTime() then
		return math.min( self.TotalReqTq, self.MaxTorque )
	end
	
	if self.ChangeFinished < CurTime() then
		self.InGear = true
	end
	
	self:CheckEnts()

	local BoxPhys = self:GetPhysicsObject()
	local SelfWorld = self:LocalToWorld( BoxPhys:GetAngleVelocity() ) - self:GetPos()
	
	self.TotalReqTq = 0
	
	--Clutching
	if self.ClutchModeUse == 0 then
		if (InputRPM < self.DeclutchRpm ) then
			self.ClutchMode = 1
			self.LClutch = math.Clamp(1-1,0,1)*self.MaxTorque
			self.RClutch = math.Clamp(1-1,0,1)*self.MaxTorque
		elseif (InputRPM >= self.DeclutchRpm ) then
			self.ClutchMode = 0
			self.LClutch = math.Clamp(1-0,0,1)*self.MaxTorque
			self.RClutch = math.Clamp(1-0,0,1)*self.MaxTorque
		end
	end
	
	if self.ClutchMode == 1 then
		if(self.GearFinal2 > self.RatioMin) then
			--self.Reducer = ((self.RpmLimit2-InputRPM)+((self.RpmLimit2-InputRPM)/6000))-(self.RpmLimit2-InputRPM)
			self.Reducer = self.Reducer + self.Reducer + 0.002
			self.GearFinal = self.GearFinal-(0.002+self.Reducer)
			self.GearFinal2 = tonumber(self.GearFinal)
		elseif(self.GearFinal2 <= self.RatioMin) then
			self.Reducer = 0
			self.GearFinal = self.RatioMin
			self.GearFinal2 = tonumber(self.GearFinal)
		end
		self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
		self:UpdateOverlayText()
		Wire_TriggerOutput(self, "Ratio", self.GearRatio)
	else
		if (InputRPM >= self.RpmLimit) then	--Increase
			self.Reducer = ((InputRPM-self.RpmLimit)+((InputRPM-self.RpmLimit)/6000))-(InputRPM-self.RpmLimit)
			if(self.GearFinal2 < self.RatioMax) then
				self.GearFinal = self.GearFinal+(0.002+self.Reducer)
				self.GearFinal2 = tonumber(self.GearFinal)
			elseif(self.GearFinal2 >= self.RatioMax) then
				self.GearFinal = self.RatioMax
				self.GearFinal2 = tonumber(self.GearFinal)
			end
			self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
			self:UpdateOverlayText()
			Wire_TriggerOutput(self, "Ratio", self.GearRatio)
		elseif (InputRPM <= self.RpmLimit2) then --Decrease
			self.Reducer = ((self.RpmLimit2-InputRPM)+((self.RpmLimit2-InputRPM)/6000))-(self.RpmLimit2-InputRPM)
			if(self.GearFinal2 > self.RatioMin) then
				self.GearFinal = self.GearFinal-(0.002+self.Reducer)
				self.GearFinal2 = tonumber(self.GearFinal)
			elseif(self.GearFinal2 <= self.RatioMin) then
				self.GearFinal = self.RatioMin
				self.GearFinal2 = tonumber(self.GearFinal)
			end
			self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
			self:UpdateOverlayText()
			Wire_TriggerOutput(self, "Ratio", self.GearRatio)
		end
	end
	
	for Key, Link in pairs( self.WheelLink ) do
		if not IsValid( Link.Ent ) then
			table.remove( self.WheelLink, Key )
		continue end
		
		local Clutch = 0
		if Link.Side == 0 then
			Clutch = self.LClutch
		elseif Link.Side == 1 then
			Clutch = self.RClutch
		end
	
		Link.ReqTq = 0
		if Link.Ent.IsGeartrain then
			if not Link.Ent.Legal then continue end
			local Inertia = 0
			if self.GearRatio ~= 0 then Inertia = InputInertia / self.GearRatio end
			Link.ReqTq = math.min( Clutch, math.abs( Link.Ent:Calc( InputRPM * self.GearRatio, Inertia, self.GearRatio ) * self.GearRatio ) )
		else
			local RPM = self:CalcWheel( Link, SelfWorld )
			if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
				Link.ReqTq = math.min( Clutch, ( InputRPM - RPM ) * InputInertia )
			end
			--Calling RPM Ouputs Value's
			if Clutch == 0 then
				Wire_TriggerOutput(self, "Gearbox RPM", 0)
			elseif Clutch > 0 then
				Wire_TriggerOutput(self, "Gearbox RPM", RPM)
			end
		end
		self.TotalReqTq = self.TotalReqTq + math.abs( Link.ReqTq )
	end

	return math.min( self.TotalReqTq, self.MaxTorque )
end

function ENT:CalcWheel( Link, SelfWorld )

	local Wheel = Link.Ent
	local WheelPhys = Wheel:GetPhysicsObject()
	local VelDiff = ( Wheel:LocalToWorld( WheelPhys:GetAngleVelocity() ) - Wheel:GetPos() ) - SelfWorld
	local BaseRPM = VelDiff:Dot( Wheel:LocalToWorld( Link.Axis ) - Wheel:GetPos() )
	Link.Vel = BaseRPM
	
	if self.GearRatio == 0 then return 0 end
	
	-- Reported BaseRPM is in angle per second and in the wrong direction, so we convert and add the gearratio
	return BaseRPM / self.GearRatio / -6
	
end

function ENT:Act( Torque, DeltaTime, MassRatio )

	--internal torque loss from being damaged
	local Loss = math.Clamp(((1 - 0.4) / (0.5)) * ((self.ACF.Health/self.ACF.MaxHealth) - 1) + 1, 0.4, 1)
	
	--internal torque loss from inefficiency
	local Slop = self.Auto and 0.9 or 1
	
	local ReactTq = 0	
	-- Calculate the ratio of total requested torque versus what's avaliable, and then multiply it but the current gearratio
	local AvailTq = 0
	if Torque ~= 0 then
		AvailTq = math.min( math.abs( Torque ) / self.TotalReqTq, 1 ) / self.GearRatio * -( -Torque / math.abs( Torque ) ) * Loss * Slop
	end
	
	for Key, Link in pairs( self.WheelLink ) do
		
		local Brake = 0
		if Link.Side == 0 then
			Brake = self.LBrake
		elseif Link.Side == 1 then
			Brake = self.RBrake
		end
		
		if Link.Ent.IsGeartrain then
			Link.Ent:Act( Link.ReqTq * AvailTq, DeltaTime, MassRatio )
		else
			self:ActWheel( Link, Link.ReqTq * AvailTq, Brake, DeltaTime )
			ReactTq = ReactTq + Link.ReqTq * AvailTq
		end
		
	end
	
	local BoxPhys
	if IsValid( self.RootParent ) then
		BoxPhys = self.RootParent:GetPhysicsObject()
	else
		BoxPhys = self:GetPhysicsObject()
	end
	
	if IsValid( BoxPhys ) and ReactTq ~= 0 then	
		local Force = self:GetForward() * ReactTq * MassRatio - self:GetForward()
		BoxPhys:ApplyForceOffset( Force * 39.37 * DeltaTime, self:GetPos() + self:GetUp() * -39.37 )
		BoxPhys:ApplyForceOffset( Force * -39.37 * DeltaTime, self:GetPos() + self:GetUp() * 39.37 )
	end
	
	self.LastActive = CurTime()
	
end

function ENT:ActWheel( Link, Torque, Brake, DeltaTime )
	local Phys = Link.Ent:GetPhysicsObject()
	local Pos = Link.Ent:GetPos()
	local TorqueAxis = Link.Ent:LocalToWorld( Link.Axis ) - Pos
	local Cross = TorqueAxis:Cross( Vector( TorqueAxis.y, TorqueAxis.z, TorqueAxis.x ) )
	local TorqueVec = TorqueAxis:Cross( Cross ):GetNormalized()
	
	local BrakeMult = 0
	if Brake > 0 then
		BrakeMult = Link.Vel * Phys:GetInertia() * Brake / 10
	end
	
	local Force = TorqueVec * Torque * 0.75 + TorqueVec * BrakeMult
	Phys:ApplyForceOffset( Force * -39.37 * DeltaTime, Pos + Cross * 39.37 )
	Phys:ApplyForceOffset( Force * 39.37 * DeltaTime, Pos + Cross * -39.37 )
end

function ENT:ChangeGear(value)

	local new = math.Clamp(math.floor(value),0,self.Gears)
	if self.Gear == new then return end
	
	self.Gear = new
	self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearTable.Final
	self.ChangeFinished = CurTime() + self.SwitchTime
	self.InGear = false
	
	Wire_TriggerOutput(self, "Current Gear", self.Gear)
	self:EmitSound("buttons/lever7.wav",250,100)
	Wire_TriggerOutput(self, "Ratio", self.GearRatio)
	
end

function ENT:Link( Target )
	if not IsValid( Target ) or not table.HasValue( { "prop_physics", "acf_gearbox", "tire", "acf_gearboxair" }, Target:GetClass() ) then
		return false, "Can only link props or gearboxes!"
	end
	-- Check if target is already linked
	for Key, Link in pairs( self.WheelLink ) do
		if Link.Ent == Target then 
			return false, "That is already linked to this gearbox!"
		end
	end
	-- make sure the angle is not excessive
	local InPos = Vector( 0, 0, 0 )
	if Target.IsGeartrain then
		InPos = Target.In
	end
	local InPosWorld = Target:LocalToWorld( InPos )
	
	local OutPos = self.OutR
	local Side = 1
	if self:WorldToLocal( InPosWorld ).y < 0 then
		OutPos = self.OutL
		Side = 0
	end
	local OutPosWorld = self:LocalToWorld( OutPos )
	
	local DrvAngle = ( OutPosWorld - InPosWorld ):GetNormalized():DotProduct( ( self:GetRight() * OutPos.y ):GetNormalized() )
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end
	
	local Rope = nil
	if self.Owner:GetInfoNum( "ACF_MobilityRopeLinks", 1) == 1 then
		Rope = constraint.CreateKeyframeRope( OutPosWorld, 1, "cable/cable2", nil, self, OutPos, 0, Target, InPos, 0 )
	end
	
	local Link = {
		Ent = Target,
		Side = Side,
		Axis = Target:WorldToLocal( self:GetRight() + InPosWorld ),
		Rope = Rope,
		RopeLen = ( OutPosWorld - InPosWorld ):Length(),
		Output = OutPos,
		ReqTq = 0,
		Vel = 0
	}
	table.insert( self.WheelLink, Link )
	
	return true, "Link successful!"
end

function ENT:Unlink( Target )
	for Key, Link in pairs( self.WheelLink ) do
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
			
			table.remove( self.WheelLink, Key )
			
			return true, "Unlink successful!"
		end
	end
	return false, "That entity is not linked to this gearbox!"
end

function ENT:PreEntityCopy()
	-- Link Saving
	local info = {}
	local entids = {}
	-- Clean the table of any invalid entities
	for Key, Link in pairs( self.WheelLink ) do
		if not IsValid( Link.Ent ) then
			table.remove( self.WheelLink, Key )
		end
	end
	-- Then save it
	for Key, Link in pairs( self.WheelLink ) do
		table.insert( entids, Link.Ent:EntIndex() )
	end
	
	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self, "WheelLink", info )
	end
	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	-- Link Pasting
	if Ent.EntityMods and Ent.EntityMods.WheelLink and Ent.EntityMods.WheelLink.entities then
		local WheelLink = Ent.EntityMods.WheelLink
		if WheelLink.entities and table.Count( WheelLink.entities ) > 0 then
			timer.Simple( 0, function() -- this timer is a workaround for an ad2/makespherical issue https://github.com/nrlulz/ACF/issues/14#issuecomment-22844064
				for _, ID in pairs( WheelLink.entities ) do
					local Linked = CreatedEntities[ ID ]
					if IsValid( Linked ) then
						self:Link( Linked )
					end
				end
			end )
		end
		Ent.EntityMods.WheelLink = nil
	end
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )
end

function ENT:OnRemove()
	for Key,Value in pairs(self.Master) do		--Let's unlink ourselves from the engines properly
		if IsValid( self.Master[Key] ) then
			self.Master[Key]:Unlink( self )
		end
	end
end

