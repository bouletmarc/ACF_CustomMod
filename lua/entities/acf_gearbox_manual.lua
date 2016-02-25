AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF GearboxManual"
ENT.WireDebugName = "ACF GearboxManual"

if CLIENT then
	
	local ACF_GearboxManualInfoWhileSeated = CreateClientConVar("ACF_GearboxManualInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
	
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACF_GearboxManualInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
		
	end
	
	function ACFGearboxManualGUICreate( Table )
		
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
		
		acfmenupanelcustom:CPanelText("Desc", Table.desc)	--Description (Name, Desc)
		
		for ID,Value in pairs(acfmenupanelcustom.GearboxData[Table.id]["GearTable"]) do
			if ID > 0 then
				ACF_ManualSlider(ID, Value, Table.id)
			elseif ID == -1 then
				ACF_ManualSlider(10, Value, Table.id, "Final Drive")
			end
		end
		
		acfmenupanelcustom:CPanelText("MaxTorque", "Clutch Maximum Torque Rating : "..(Table.maxtq).."n-m / "..math.Round(Table.maxtq*0.73).."ft-lb")
		acfmenupanelcustom:CPanelText("Weight", "Weight : "..Table.weight.."kg")
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		maxtorque = Table.maxtq
	end
	
	function ACF_ManualSlider(Gear, Value, ID)

		if Gear and not acfmenupanelcustom["CData"][Gear] then	
			acfmenupanelcustom["CData"][Gear] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom["CData"][Gear]:SetText("Gear "..Gear )
				acfmenupanelcustom["CData"][Gear].Label:SizeToContents()
				acfmenupanelcustom["CData"][Gear]:SetMin( -1 )
				acfmenupanelcustom["CData"][Gear]:SetMax( 1 )
				acfmenupanelcustom["CData"][Gear]:SetDecimals( 2 )
				acfmenupanelcustom["CData"][Gear]["Gear"] = Gear
				acfmenupanelcustom["CData"][Gear]["ID"] = ID
				acfmenupanelcustom["CData"][Gear]:SetValue(Value)
				RunConsoleCommand( "acfcustom_data"..Gear, Value )
				acfmenupanelcustom["CData"][Gear].OnValueChanged = function( slider, val )
					acfmenupanelcustom.GearboxData[slider.ID]["GearTable"][slider.Gear] = val
					RunConsoleCommand( "acfcustom_data"..Gear, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom["CData"][Gear] )
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
	
	self.Gear = 0
	self.GearRatio = 0
	self.ChangeFinished = 0
	
	self.LegalThink = 0
	
	self.DoubleDiff = false
	self.InGear = false
	self.CanUpdate = true
	self.LastActive = 0
	self.Legal = true
	
	//Manual Gearbox Vars
	self.isManual = true
	self.TotalReqTq2 = 0
	
end  

function MakeACF_GearboxManual(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local GearboxManual = ents.Create("acf_gearbox_manual")
	local List = list.Get("ACFCUSTOMEnts")
	local Classes = list.Get("ACFClasses")
	if not IsValid( GearboxManual ) then return false end
	GearboxManual:SetAngles(Angle)
	GearboxManual:SetPos(Pos)
	GearboxManual:Spawn()

	GearboxManual:SetPlayer(Owner)
	GearboxManual.Owner = Owner
	GearboxManual.Id = Id
	GearboxManual.Model = List.MobilityCustom[Id].model
	GearboxManual.Mass = List.MobilityCustom[Id].weight
	GearboxManual.SwitchTime = List.MobilityCustom[Id].switch
	GearboxManual.MaxTorque = List.MobilityCustom[Id].maxtq
	GearboxManual.Gears = List.MobilityCustom[Id].gears
	GearboxManual.Dual = List.MobilityCustom[Id].doubleclutch
	GearboxManual.GearTable = List.MobilityCustom[Id].geartable
		GearboxManual.GearTable.Final = Data10
		GearboxManual.GearTable[1] = Data1
		GearboxManual.GearTable[2] = Data2
		GearboxManual.GearTable[3] = Data3
		GearboxManual.GearTable[4] = Data4
		GearboxManual.GearTable[5] = Data5
		GearboxManual.GearTable[6] = Data6
		GearboxManual.GearTable[7] = Data7
		GearboxManual.GearTable[8] = Data8
		GearboxManual.GearTable[9] = Data9
		GearboxManual.GearTable[0] = 0
		
		GearboxManual.Gear0 = Data10
		GearboxManual.Gear1 = Data1
		GearboxManual.Gear2 = Data2
		GearboxManual.Gear3 = Data3
		GearboxManual.Gear4 = Data4
		GearboxManual.Gear5 = Data5
		GearboxManual.Gear6 = Data6
		GearboxManual.Gear7 = Data7
		GearboxManual.Gear8 = Data8
		GearboxManual.Gear9 = Data9
				
	GearboxManual:SetModel( GearboxManual.Model )
	
	local Inputs = {"Gear","Gear Up","Gear Down"}
	if GearboxManual.Dual then
		table.insert(Inputs, "Left Clutch")
		table.insert(Inputs, "Right Clutch")
		table.insert(Inputs, "Left Brake")
		table.insert(Inputs, "Right Brake")
	else
		table.insert(Inputs, "Clutch")
		table.insert(Inputs, "Brake")
	end
	
    local Outputs = { "Ratio", "Entity", "Current Gear" }
    local OutputTypes = { "NORMAL", "ENTITY", "NORMAL", "NORMAL" }
	
	GearboxManual.Inputs = Wire_CreateInputs( GearboxManual, Inputs )
	GearboxManual.Outputs = WireLib.CreateSpecialOutputs( GearboxManual, Outputs, OutputTypes )
	Wire_TriggerOutput(GearboxManual, "Entity", GearboxManual)
	
	GearboxManual.LClutch = GearboxManual.MaxTorque
	GearboxManual.RClutch = GearboxManual.MaxTorque

	GearboxManual:PhysicsInit( SOLID_VPHYSICS )      	
	GearboxManual:SetMoveType( MOVETYPE_VPHYSICS )     	
	GearboxManual:SetSolid( SOLID_VPHYSICS )

	local phys = GearboxManual:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( GearboxManual.Mass ) 
	end
	
	GearboxManual.In = GearboxManual:WorldToLocal(GearboxManual:GetAttachment(GearboxManual:LookupAttachment( "input" )).Pos)
	GearboxManual.OutL = GearboxManual:WorldToLocal(GearboxManual:GetAttachment(GearboxManual:LookupAttachment( "driveshaftL" )).Pos)
	GearboxManual.OutR = GearboxManual:WorldToLocal(GearboxManual:GetAttachment(GearboxManual:LookupAttachment( "driveshaftR" )).Pos)
	
	Owner:AddCount("_acf_gearbox_manual", GearboxManual)
	Owner:AddCleanup( "acfcustom", GearboxManual )
	
	GearboxManual.Gear = 1
	GearboxManual:ChangeGear(1)
	
	if GearboxManual.Dual then
		GearboxManual:SetBodygroup(1, 1)
	else
		GearboxManual:SetBodygroup(1, 0)
	end
	
	GearboxManual:SetNWString( "WireName", List.MobilityCustom[Id].name )
	GearboxManual:UpdateOverlayText()
		
	return GearboxManual
end
list.Set( "ACFCvars", "acf_gearbox_manual", {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"} )
duplicator.RegisterEntityClass("acf_gearbox_manual", MakeACF_GearboxManual, "Pos", "Angle", "Id", "Gear1", "Gear2", "Gear3", "Gear4", "Gear5", "Gear6", "Gear7", "Gear8", "Gear9", "Gear0" )

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that gearboxauto!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFCUSTOMEnts")
	
	if List.MobilityCustom[Id].model ~= self.Model then
		return false, "The new gearboxauto must have the same model!"
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
			table.insert(Inputs, "Left Clutch")
			table.insert(Inputs, "Right Clutch")
			table.insert(Inputs, "Left Brake")
			table.insert(Inputs, "Right Brake")
		else
			table.insert(Inputs, "Clutch")
			table.insert(Inputs, "Brake")
		end
		
		local Outputs = { "Ratio", "Entity", "Current Gear", "Gearbox RPM" }
		local OutputTypes = { "NORMAL", "ENTITY", "NORMAL", "NORMAL" }
		
		self.Inputs = Wire_CreateInputs( self, Inputs )
		self.Outputs = WireLib.CreateSpecialOutputs( self, Outputs, OutputTypes )
		Wire_TriggerOutput(self, "Entity", self)
		
		local phys = self:GetPhysicsObject()    
		if IsValid( phys ) then 
			phys:SetMass( self.Mass ) 
		end
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
	
	self.Gear = 1
	self:ChangeGear(1)
	
	if self.Dual then
		self:SetBodygroup(1, 1)
	else
		self:SetBodygroup(1, 0)
	end	
	
	self:SetNWString( "WireName", List.MobilityCustom[Id].name )
	self:UpdateOverlayText()
	
	return true, "GearboxManual updated successfully!"
end

function ENT:UpdateOverlayText()
	
	local text = ""
	for i = 1, self.Gears do
		text = text .. "Gear " .. i .. ": " .. math.Round( self.GearTable[ i ], 2 ) .. "\n"
	end
	text = text .. "Current Gear: " .. self.Gear .. "\n"
	text = text .. "Final Drive: " .. math.Round( self.Gear0, 2 ) .. "\n"
	text = text .. "Torque Rating: " .. self.MaxTorque .. " Nm / " .. math.Round( self.MaxTorque * 0.73 ) .. " ft-lb"
	
	self:SetOverlayText( text )
	
end

-- prevent people from changing bodygroup
function ENT:CanProperty( ply, property )
	return property ~= "bodygroups"
end

function ENT:TriggerInput( iname , value )
	if ( iname == "Gear" ) then
		self:ChangeGear(value)
	elseif ( iname == "Gear Up" ) and not (value == 0) then
		self:ChangeGear(self.Gear + 1)
	elseif ( iname == "Gear Down" ) and not (value == 0) then
		self:ChangeGear(self.Gear - 1)
	elseif ( iname == "Clutch" ) then
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
	self:NextThink( Time + math.random( 5, 10 ) )
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

function ENT:GetGear( )
	return self.Gear
end

function ENT:GetClutching( )
	return self.Clutching
end

function ENT:Calc( InputRPM, InputInertia )

	if self.LastActive == CurTime() then
		return math.min( self.TotalReqTq, self.MaxTorque )
	end
	
	if self.ChangeFinished < CurTime() then
		self.InGear = true
	else
		-- disable power while changing gear
		self.TotalReqTq = 0
		return self.TotalReqTq
	end
	
	self:CheckEnts()

	local BoxPhys = self:GetPhysicsObject()
	local SelfWorld = self:LocalToWorld( BoxPhys:GetAngleVelocity() ) - self:GetPos()
	
	self.TotalReqTq = 0
	
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
			Link.ReqTq = math.min( Clutch, math.abs( Link.Ent:Calc( InputRPM * self.GearRatio, Inertia ) * self.GearRatio ) )
		elseif self.DoubleDiff then
			local RPM = self:CalcWheel( Link, SelfWorld )
			if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
				local NTq = math.min( Clutch, ( InputRPM - RPM) * InputInertia)
			
				if( self.SteerRate ~= 0 ) then
					Sign = self.SteerRate / math.abs( self.SteerRate )
				else
					Sign = 0
				end
				if Link.Side == 0 then 
					local DTq = math.Clamp( ( self.SteerRate * ( ( InputRPM * ( math.abs( self.SteerRate ) + 1 ) ) - (RPM * Sign) ) ) * InputInertia, -self.MaxTorque, self.MaxTorque )
					Link.ReqTq = ( NTq + DTq )
				elseif Link.Side == 1 then
					local DTq = math.Clamp( ( self.SteerRate * ( ( InputRPM * ( math.abs( self.SteerRate ) + 1 ) ) + (RPM * Sign) ) ) * InputInertia, -self.MaxTorque, self.MaxTorque )
					Link.ReqTq = ( NTq - DTq )
				end
			end
		else
			local RPM = self:CalcWheel( Link, SelfWorld )
			if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
				Link.ReqTq = math.min( Clutch, ( InputRPM - RPM ) * InputInertia )
			end
		end
		self.TotalReqTq = self.TotalReqTq + math.abs( Link.ReqTq )
	end
			
	return math.min( self.TotalReqTq, self.MaxTorque )
end

function ENT:Calc2( InputRPM, InputInertia )
	if self.LastActive == CurTime() then
		return self.TotalReqTq2
	end

	local BoxPhys = self:GetPhysicsObject()
	local SelfWorld = self:LocalToWorld( BoxPhys:GetAngleVelocity() ) - self:GetPos()
	
	self.TotalReqTq2 = 0
	
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
	
		Link.ReqTq2 = 0
		if Link.Ent.IsGeartrain then
			if not Link.Ent.Legal then continue end
			
			-- ONLY if Calc2() is added on the linked gearbox ## NOT ADDED ON ANY GEARBOXES --> OVERRIDE MODE INSTEAD FOR COMPATIBILITY WITH ORIGINAL ACF
			/*if IsValid(Link.Ent.TotalReqTq2) then
				Link.ReqTq2 = math.min( Clutch, math.abs( Link.Ent:Calc2( InputRPM * self.GearRatio, Inertia ) * self.GearRatio ) )
			end*/
			
			//#### MORE THAN 4GEARBOXES ARE ALMOST IMPOSSIBLE, IT WOULD BE STUPID TO HAVE SOMETHING LIKE THIS : MANUAL-->CLUTCH-->TRANSFER-->TRANSFER-->DIFF
			
			-- Link up to 4x external gearboxes, and override the manual function to read the final wheel RPM
			for Key2, Link2 in pairs( Link.Ent.WheelLink ) do
				if Link2.Ent.IsGeartrain then
					for Key3, Link3 in pairs( Link2.Ent.WheelLink ) do
						if Link3.Ent.IsGeartrain then
							for Key4, Link4 in pairs( Link3.Ent.WheelLink ) do
								if Link4.Ent.IsGeartrain then
									for Key5, Link5 in pairs( Link4.Ent.WheelLink ) do
										if !Link5.Ent.IsGeartrain then
											if !Link4.Ent.DoubleDiff then
												Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, false, Link, Link2, Link3, Link4, Link5)
											else
												Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, true, Link, Link2, Link3, Link4, Link5)
											end
										end
									end
								else
									if !Link3.Ent.DoubleDiff then
										Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, false, Link, Link2, Link3, Link4)
									else
										Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, true, Link, Link2, Link3, Link4)
									end
								end
							end
						else
							if !Link2.Ent.DoubleDiff then
								Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, false, Link, Link2, Link3)
							else
								Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, true, Link, Link2, Link3)
							end
						end
					end
				else
					if !Link.Ent.DoubleDiff then
						Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, false, Link, Link2)
					else
						Link.ReqTq2 = self:RPMCheckup(InputRPM, InputInertia, true, Link, Link2)
					end
				end
			end
		elseif self.DoubleDiff then
			local RPM = self:CalcWheel( Link, SelfWorld )
			if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
				local NTq = math.min( Clutch, ( RPM - InputRPM) * InputInertia)
				-- Set Sign
				if( self.SteerRate ~= 0 ) then Sign = self.SteerRate / math.abs( self.SteerRate ) else Sign = 0 end
				-- Set Link Sides
				if Link.Side == 0 then 
					local DTq = math.Clamp( ( self.SteerRate * ( (RPM * Sign) - ( InputRPM * ( math.abs( self.SteerRate ) + 1 ) ) ) ) * InputInertia, -self.MaxTorque, self.MaxTorque )
				elseif Link.Side == 1 then
					local DTq = math.Clamp( ( self.SteerRate * ( (RPM * Sign) + ( InputRPM * ( math.abs( self.SteerRate ) + 1 ) ) ) ) * InputInertia, -self.MaxTorque, self.MaxTorque )
				end
				Link.ReqTq2 = ( NTq + DTq )
			end
		else
			local RPM = self:CalcWheel( Link, SelfWorld )
			if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM > InputRPM ) or ( InputRPM < 0 and RPM < InputRPM ) ) then
				Link.ReqTq2 = math.min( Clutch, ( RPM - InputRPM ) * InputInertia )
			end
		end
		self.TotalReqTq2 = self.TotalReqTq2 + math.abs( Link.ReqTq2 )
	end
	return self.TotalReqTq2
end

-- THIS IS AN 'OVERRIDE' FUNCTION FOR GEARBOX WITHOUT MANUAL MODE, IT RUN HERE INSTEAD OF COPYING IT IN ANY GEARBOXES FILES
function ENT:RPMCheckup (InputRPM, InputInertia, DoubleDiff, Link1, Link2, Link3, Link4, Link5)
	/*if LinkNumer == 2 then
	elseif LinkNumer == 3 then
	elseif LinkNumer == 4 then
	end*/
	-- Perform RPM Checkup on the next Gearbox
	-- Set Links Number (link up to 4x gearboxes)
	local LinkNumer = 2
	if (IsValid(Link3)) then LinkNumer = 3 end
	if (IsValid(Link4)) then LinkNumer = 4 end
	if (IsValid(Link5)) then LinkNumer = 5 end
	
	-- Set EngineRPM
	local InputRPM2 = InputRPM * self.GearRatio
	if LinkNumer > 2 then
		if LinkNumer == 3 then InputRPM2 = (InputRPM * self.GearRatio) * Link1.Ent.GearRatio end
		if LinkNumer == 4 then InputRPM2 = ((InputRPM * self.GearRatio) * Link1.Ent.GearRatio) * Link2.Ent.GearRatio end
		if LinkNumer == 5 then InputRPM2 = (((InputRPM * self.GearRatio) * Link1.Ent.GearRatio) * Link2.Ent.GearRatio) * Link3.Ent.GearRatio end
	end
	
	-- Set Inertia
	local Inertia = InputInertia / self.GearRatio
	if LinkNumer > 2 then
		if LinkNumer == 3 then Inertia = (InputInertia / self.GearRatio) / Link1.Ent.GearRatio end
		if LinkNumer == 4 then Inertia = ((InputInertia / self.GearRatio) / Link1.Ent.GearRatio) / Link2.Ent.GearRatio end
		if LinkNumer == 5 then Inertia = (((InputInertia / self.GearRatio) / Link1.Ent.GearRatio) / Link2.Ent.GearRatio) / Link3.Ent.GearRatio end
	end
	
	-- Set Pos, World, Phys Vars
	local BoxPhys
	local SelfWorld
	if LinkNumer == 2 then
		BoxPhys = Link1.Ent:GetPhysicsObject()
		SelfWorld = Link1.Ent:LocalToWorld( BoxPhys:GetAngleVelocity() ) - Link1.Ent:GetPos()
	elseif LinkNumer == 3 then
		BoxPhys = Link2.Ent:GetPhysicsObject()
		SelfWorld = Link2.Ent:LocalToWorld( BoxPhys:GetAngleVelocity() ) - Link2.Ent:GetPos()
	elseif LinkNumer == 4 then
		BoxPhys = Link3.Ent:GetPhysicsObject()
		SelfWorld = Link3.Ent:LocalToWorld( BoxPhys:GetAngleVelocity() ) - Link3.Ent:GetPos()
	elseif LinkNumer == 5 then
		BoxPhys = Link4.Ent:GetPhysicsObject()
		SelfWorld = Link4.Ent:LocalToWorld( BoxPhys:GetAngleVelocity() ) - Link4.Ent:GetPos()
	end
	
	-- Get RPM
	local RPM = 0
	if LinkNumer == 2 then RPM = Link1.Ent:CalcWheel(Link2, SelfWorld)
	elseif LinkNumer == 3 then RPM = Link2.Ent:CalcWheel(Link3, SelfWorld)
	elseif LinkNumer == 4 then RPM = Link3.Ent:CalcWheel(Link4, SelfWorld)
	elseif LinkNumer == 5 then RPM = Link4.Ent:CalcWheel(Link5, SelfWorld)
	end
	
	-- Set Clutch
	local Clutch = 0
	if LinkNumer == 2 then
		if Link2.Side == 0 then Clutch = Link1.Ent.LClutch
		elseif Link2.Side == 1 then Clutch = Link1.Ent.RClutch end
	elseif LinkNumer == 3 then
		if Link3.Side == 0 then Clutch = Link2.Ent.LClutch
		elseif Link3.Side == 1 then Clutch = Link2.Ent.RClutch end
	elseif LinkNumer == 4 then
		if Link4.Side == 0 then Clutch = Link3.Ent.LClutch
		elseif Link4.Side == 1 then Clutch = Link3.Ent.RClutch end
	elseif LinkNumer == 5 then
		if Link5.Side == 0 then Clutch = Link4.Ent.LClutch
		elseif Link5.Side == 1 then Clutch = Link4.Ent.RClutch end
	end
	
	-- Set RPM Torque to send
	if ((LinkNumer==2 and Link1.Ent.GearRatio~=0) or (LinkNumer==3 and Link2.Ent.GearRatio~=0) or (LinkNumer==4 and Link3.Ent.GearRatio~=0) or (LinkNumer==5 and Link4.Ent.GearRatio~=0))then
		if ((InputRPM2 > 0 and RPM > InputRPM2) or (InputRPM2 < 0 and RPM < InputRPM2)) then
			if DoubleDiff then
				-- DoubleDiff
				local NTq = math.min( Clutch, ( RPM - InputRPM2) * Inertia)
				-- Set Sign
				if LinkNumer == 2 then if( Link1.Ent.SteerRate ~= 0 ) then Sign = Link1.Ent.SteerRate / math.abs( Link1.Ent.SteerRate ) else Sign = 0 end end
				if LinkNumer == 3 then if( Link2.Ent.SteerRate ~= 0 ) then Sign = Link2.Ent.SteerRate / math.abs( Link2.Ent.SteerRate ) else Sign = 0 end end
				if LinkNumer == 4 then if( Link3.Ent.SteerRate ~= 0 ) then Sign = Link3.Ent.SteerRate / math.abs( Link3.Ent.SteerRate ) else Sign = 0 end end
				if LinkNumer == 5 then if( Link4.Ent.SteerRate ~= 0 ) then Sign = Link4.Ent.SteerRate / math.abs( Link4.Ent.SteerRate ) else Sign = 0 end end
				
				-- Set Link Sides
				if LinkNumer == 2 then
					if Link2.Side == 0 then 
						local DTq = math.Clamp((Link1.Ent.SteerRate*((RPM*Sign)-(InputRPM2*(math.abs(Link1.Ent.SteerRate)+1))))*Inertia, -Link1.Ent.MaxTorque, Link1.Ent.MaxTorque)
					elseif Link2.Side == 1 then
						local DTq = math.Clamp((Link1.Ent.SteerRate*((RPM*Sign)+(InputRPM2*(math.abs(Link1.Ent.SteerRate)+1))))*Inertia, -Link1.Ent.MaxTorque, Link1.Ent.MaxTorque)
					end
				elseif LinkNumer == 3 then
					if Link3.Side == 0 then 
						local DTq = math.Clamp((Link2.Ent.SteerRate*((RPM*Sign)-(InputRPM2*(math.abs(Link2.Ent.SteerRate)+1))))*Inertia, -Link2.Ent.MaxTorque, Link2.Ent.MaxTorque)
					elseif Link3.Side == 1 then
						local DTq = math.Clamp((Link2.Ent.SteerRate*((RPM*Sign)+(InputRPM2*(math.abs(Link2.Ent.SteerRate)+1))))*Inertia, -Link2.Ent.MaxTorque, Link2.Ent.MaxTorque)
					end
				elseif LinkNumer == 4 then
					if Link4.Side == 0 then 
						local DTq = math.Clamp((Link3.Ent.SteerRate*((RPM*Sign)-(InputRPM2*(math.abs(Link3.Ent.SteerRate)+1))))*Inertia, -Link3.Ent.MaxTorque, Link3.Ent.MaxTorque)
					elseif Link4.Side == 1 then
						local DTq = math.Clamp((Link3.Ent.SteerRate*((RPM*Sign)+(InputRPM2*(math.abs(Link3.Ent.SteerRate)+1))))*Inertia, -Link3.Ent.MaxTorque, Link3.Ent.MaxTorque)
					end
				elseif LinkNumer == 5 then
					if Link5.Side == 0 then 
						local DTq = math.Clamp((Link4.Ent.SteerRate*((RPM*Sign)-(InputRPM2*(math.abs(Link4.Ent.SteerRate)+1))))*Inertia, -Link4.Ent.MaxTorque, Link4.Ent.MaxTorque)
					elseif Link5.Side == 1 then
						local DTq = math.Clamp((Link4.Ent.SteerRate*((RPM*Sign)+(InputRPM2*(math.abs(Link4.Ent.SteerRate)+1))))*Inertia, -Link4.Ent.MaxTorque, Link4.Ent.MaxTorque)
					end
				end
				return (NTq + DTq)
			else
				-- Normal
				return math.min( Clutch, ( RPM - InputRPM2 ) * Inertia )
			end
		else
			return 0
		end
	else
		return 0
	end
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
	local ReactTq = 0	
	-- Calculate the ratio of total requested torque versus what's avaliable, and then multiply it but the current gearratio
	local AvailTq = 0
	if Torque ~= 0 then
		AvailTq = math.min( math.abs( Torque ) / self.TotalReqTq, 1 ) / self.GearRatio * -( -Torque / math.abs( Torque ) )
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
			return false, "That is already linked to this gearboxauto!"
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
		ReqTq2 = 0,
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
	
	return false, "That entity is not linked to this gearboxauto!"
	
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