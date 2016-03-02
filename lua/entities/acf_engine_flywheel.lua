
AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Engine Flywheel"
ENT.WireDebugName = "ACF Engine Flywheel"

if CLIENT then
	
	local ACFCUSTOM_EngineFlyInfoWhileSeated = CreateClientConVar("ACFCUSTOM_EngineFlyInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACFCUSTOM_EngineFlyInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
	end
	
	function ACFEngineFlyGUICreate( Table )
	
		if not acfmenupanelcustom.ModData then
			acfmenupanelcustom.ModData = {}
		end
		if not acfmenupanelcustom.ModData[Table.id] then
			acfmenupanelcustom.ModData[Table.id] = {}
			acfmenupanelcustom.ModData[Table.id].ModTable = Table.modtable
		end
		
		acfmenupanelcustom:CPanelText("Name", Table.name)
		
		acfmenupanelcustom.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanelcustom.CustomDisplay )
			acfmenupanelcustom.CData.DisplayModel:SetModel( Table.model )
			acfmenupanelcustom.CData.DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
			acfmenupanelcustom.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanelcustom.CData.DisplayModel:SetFOV( 8 )
			acfmenupanelcustom.CData.DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
			acfmenupanelcustom.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData.DisplayModel )
		
		acfmenupanelcustom:CPanelText("Desc", Table.desc)
		
		for ID,Value in pairs(acfmenupanelcustom.ModData[Table.id]["ModTable"]) do
			ACF_FlySlider(ID, Value, Table.id)
		end
		
	acfmenupanelcustom.CustomDisplay:PerformLayout()	
	
	end
	
	function ACF_FlySlider(Mod, Value, ID)
		if Mod and not acfmenupanelcustom.CData[Mod] then	
			acfmenupanelcustom.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Mod]:SetWide(100)
				if Mod == 1 then
					acfmenupanelcustom.CData[Mod]:SetText("Idle RPM")
					acfmenupanelcustom.CData[Mod]:SetMin( 5 )
					acfmenupanelcustom.CData[Mod]:SetMax( 1200 )
					acfmenupanelcustom.CData[Mod]:SetDecimals( 0 )
				elseif Mod == 2 then
					acfmenupanelcustom.CData[Mod]:SetText("FlywheelMass")
					acfmenupanelcustom.CData[Mod]:SetMin( 0.001 )
					acfmenupanelcustom.CData[Mod]:SetMax( 5 )
					acfmenupanelcustom.CData[Mod]:SetDecimals( 3 )
				end
				acfmenupanelcustom.CData[Mod]["Mod"] = Mod
				acfmenupanelcustom.CData[Mod]["ID"] = ID
				acfmenupanelcustom.CData[Mod]:SetValue(Value)
				acfmenupanelcustom.CData[Mod]:SetDark( true )
				RunConsoleCommand( "acfcustom_data"..Mod, Value )
				acfmenupanelcustom.CData[Mod].OnValueChanged = function( slider, val )
					acfmenupanelcustom.ModData[slider.ID]["ModTable"][slider.Mod] = val
					RunConsoleCommand( "acfcustom_data"..Mod, val )
				end
			acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData[Mod] )
		end
	end
	
	return
end

--###################################################
--##### 			END CL_INIT					#####
--###################################################

function ENT:Initialize()
	self.IsMaster = true
	self.GearLink = {} 		-- a "Link" has these components: Ent, Rope, RopeLen, ReqTq, ReqTq2

	self.LastCheck = 0
	self.LastThink = 0
	self.MassRatio = 1
	self.Legal = true
	self.CanUpdate = true
	
	-- Manual Gearbox Vars
	self.ManualGearbox = false
	self.GearboxCurrentGear = 0
	
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Back Force", "Entity", "Mass", "Physical Mass" }, { "NORMAL", "NORMAL", "ENTITY", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput( self, "Entity", self )
	Wire_CreateInputs( self, { "Throttle", "RPM", "IdleRPM", "FlywheelMass" } )
	self.WireDebugName = "ACF Engine Flywheel"
end

--###################################################
--##### 			MAKE ENGINE					#####
--###################################################

function MakeACF_EngineFly(Owner, Pos, Angle, Id, Data1, Data2)

	if not Owner:CheckLimit("_acf_misc") then return false end

	local Engine = ents.Create( "acf_engine_flywheel" )
	if not IsValid( Engine ) then return false end
	
	local EID
	local List = list.Get("ACFCUSTOMEnts")
	if List.MobilityCustom[Id] then EID = Id else EID = "Fly-Small" end
	local Lookup = List.MobilityCustom[EID]
	
	Engine:SetAngles(Angle)
	Engine:SetPos(Pos)
	Engine:Spawn()
	Engine:SetPlayer(Owner)
	Engine.Owner = Owner
	Engine.Id = EID
	
	Engine.Model = Lookup.model
	Engine.Weight = Lookup.weight
	
	Engine.ModTable = Lookup.modtable
		Engine.ModTable[1] = Data1
		Engine.ModTable[2] = Data2
		
		--Set Mods Table (Used for Duplicator)
		Engine.Mod1 = Data1
		Engine.Mod2 = Data2
		
		if(tonumber(Data1) != nil and tonumber(Data1) >= 10) then Engine.IdleRPM = tonumber(Data1) else Engine.IdleRPM = 10 end
		if(tonumber(Data2) != nil and tonumber(Data2) >= 0.001) then Engine.FlywheelMass = tonumber(Data2) else Engine.FlywheelMass = 0.001 end
		
		Engine.Inertia = Engine.FlywheelMass*(3.1416)^2
		
	--Create Normal Vars
	Engine.FlywheelMassNormal = Engine.FlywheelMass
	Engine.IdleRPMNormal = Engine.IdleRPM

	Engine.FlyRPM = 0
	Engine:SetModel( Engine.Model )
	Engine.RPM = {}

	Engine:PhysicsInit( SOLID_VPHYSICS )      	
	Engine:SetMoveType( MOVETYPE_VPHYSICS )     	
	Engine:SetSolid( SOLID_VPHYSICS )

	Engine.Out = Engine:WorldToLocal(Engine:GetPos())

	local phys = Engine:GetPhysicsObject()  	
	if IsValid( phys ) then
		phys:SetMass( Engine.Weight ) 
	end

	Engine:SetNWString( "WireName", Lookup.name )
	------ GUI ---------
	Engine:UpdateOverlayText()
	
	Owner:AddCount("_acf_engine_flywheel", Engine)
	Owner:AddCleanup( "acfcustom", Engine )
	
	Engine:ACFInit()

	return Engine
end
list.Set( "ACFCvars", "acf_engine_flywheel", {"id", "data1", "data2"} )
duplicator.RegisterEntityClass("acf_engine_flywheel", MakeACF_EngineFly, "Pos", "Angle", "Id", "Mod1", "Mod2")

--###################################################
--##### 		UPDATE ENGINE					#####
--###################################################

function ENT:Update( ArgsTable )	
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFCUSTOMEnts").MobilityCustom[Id]

	if Lookup.model ~= self.Model then
		return false, "The flywheel must have the same model!"
	end

	self.Id = Id
	self.Weight = Lookup.weight
	
	self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
		
	--Set Mods Table (Used for Duplicator)
	self.Mod1 = ArgsTable[5]
	self.Mod2 = ArgsTable[6]
		
	if(tonumber(ArgsTable[5]) != nil and tonumber(ArgsTable[5]) >= 10) then self.IdleRPM = tonumber(ArgsTable[5]) else self.IdleRPM = 10 end
	if(tonumber(ArgsTable[6]) != nil and tonumber(ArgsTable[6]) >= 0.001) then self.FlywheelMass = tonumber(ArgsTable[6]) else self.FlywheelMass = 0.001 end
		
	self.Inertia = self.FlywheelMass*(3.1416)^2
	
	--Create Normal Vars
	self.FlywheelMassNormal = self.FlywheelMass
	self.IdleRPMNormal = self.IdleRPM

	self:SetModel( self.Model )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Out = self:WorldToLocal(self:GetPos())

	local phys = self:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end
	
	self:SetNWString( "WireName", Lookup.name )
	------ GUI ---------
	self:UpdateOverlayText()
	
	self:ACFInit()
	
	return true, "Flywheel updated successfully!"
end

--###################################################
--##### 			FUNCTIONS					#####
--###################################################

function ENT:UpdateOverlayText()
	local text = "Idle: " .. math.Round(self.IdleRPM) .. " RPM\n"
	text = text .. "FlywheelMass: " .. math.Round(self.FlywheelMass,3) .. " Kg\n"
	text = text .. "Inertia: " .. math.Round(self.Inertia,3) .. "\n"
	text = text .. "RPM: " .. math.Round(self.FlyRPM) .. " RPM\n"
	text = text .. "Weight: " .. math.Round(self.Weight) .. "Kg"
	
	self:SetOverlayText( text )
end

--###################################################
--##### 		TRIGGER INPUTS					#####
--###################################################

function ENT:TriggerInput( iname, value )
	if (iname == "Throttle") then
		if (value > 0 and self.Throttle != value) then
			self.Throttle = value
			if self.Throttle > 1 then self.Throttle = 1 end
		elseif (value <= 0 and self.Throttle != 0) then
			self.Throttle = 0
		end
	elseif (iname == "RPM") then
		if (value > 0 and self.FlyRPM != value) then
			self.FlyRPM = value
		elseif (value <= 0 and self.FlyRPM != 0) then
			self.FlyRPM = 0
		end
	elseif (iname == "IdleRPM") then
		if (value > 0 and self.IdleRPM != value) then
			self.IdleRPM = value
		elseif (value <= 0 and self.IdleRPM != self.IdleRPMNormal) then
			self.IdleRPM = self.IdleRPMNormal
		end
	elseif (iname == "FlywheelMass") then
		if (value > 0 and self.FlywheelMass != value) then
			self.FlywheelMass = value
			self.Inertia = self.FlywheelMass*(3.1416)^2
		elseif (value <= 0 and self.FlywheelMass != self.FlywheelMassNormal) then
			self.FlywheelMass = self.FlywheelMassNormal
			self.Inertia = self.FlywheelMass*(3.1416)^2
		end
	end
end

function ENT:Think()
	local Time = CurTime()

	if self.Legal then
		self:CalcRPM()
	end

	if self.LastCheck < CurTime() then
		self:CheckRopes()
		self:CalcMassRatio()
		self.Legal = self:CheckLegal()

		self.LastCheck = Time + math.Rand(5, 10)
	end

	self.LastThink = Time
	self:NextThink( Time )
	return true
end

function ENT:CheckLegal()
	--make sure it's not invisible to traces
	if not self:IsSolid() then return false end
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Weight then return false end
	
	local rootparent = self:GetParent()
	
	-- if it's not parented we're fine
	if not IsValid( rootparent ) then return true end
	--find the root parent
	local depth = 0
	while rootparent:GetParent():IsValid() and depth<5 do
		depth = depth + 1
		rootparent = rootparent:GetParent()
	end
	
	--if there's still more parents, it's not legal
	if rootparent:GetParent():IsValid() then return false end
	--make sure it's welded to root parent
	for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
		if v.Ent1 == rootparent or v.Ent2 == rootparent then return true end
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
	self.FlyRPM = 0
end

function ENT:CalcRPM()
	local DeltaTime = CurTime() - self.LastThink
	
	--Set FlyRPM by object rotation
	/*local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		self.FlyRPM = math.floor(((phys:GetAngleVelocity().z)/10)*1.6)
	end
	
	--Reset Negative RPM
	self.inverted = false
	if self.FlyRPM < 0 then
		self.FlyRPM = -self.FlyRPM
		self.inverted = true
	end*/
	
	--Set TorqueDiff
	local TorqueDiff = math.max( self.FlyRPM - self.IdleRPM, 0 ) * self.Inertia
	--Reset TorqueDiff for Manual Gearbox
	if (self.ManualGearbox) then
		TorqueDiff = math.max(self.FlyRPM + self.IdleRPM, 0) * self.Inertia
	end
	
	-- The gearboxes don't think on their own, it's the engine that calls them, to ensure consistent execution order
	local Boxes = table.Count( self.GearLink )
	local TotalReqTq = 0
	local TotalReqTq2 = 0	--Used for Manual Gearbox (Aka Engine Back-Force)
	
	-- Get the requirements for torque for the gearboxes (Max clutch rating minus any wheels currently spinning faster than the Flywheel)
	for Key, Link in pairs( self.GearLink ) do
		if not Link.Ent.Legal then continue end
		-- Set accelerating engine gearbox Back-Force
		Link.ReqTq = Link.Ent:Calc( self.FlyRPM, self.Inertia )
		TotalReqTq = TotalReqTq + Link.ReqTq
		if self.ManualGearbox then
			-- Set deccelerating engine gearbox Back-Force (Manual Gearbox)
			Link.ReqTq2 = Link.Ent:Calc2( self.FlyRPM, self.Inertia )
			TotalReqTq2 = TotalReqTq2 + Link.ReqTq2
		end
	end
	
	-- Split the torque fairly between the gearboxes who need it
	for Key, Link in pairs( self.GearLink ) do
		if not Link.Ent.Legal then continue end
		-- Calculate the ratio of total requested torque versus what's avaliable
		local AvailRatio = math.min( TorqueDiff / TotalReqTq / Boxes, 1 )
		self.GearboxCurrentGear = Link.Ent.Gear
		-- Reset AvailRatio (Manual Gearbox)
		if (self.ManualGearbox and self.Throttle == 0 and self.GearboxCurrentGear != 0 and self.FlyRPM > self.IdleRPM) then
			AvailRatio = 0
		end
		-- Set the Torque On Gearboxes
		Link.Ent:Act( Link.ReqTq * AvailRatio * self.MassRatio, DeltaTime, self.MassRatio )
	end

	-- Remove RPM with Gearbox Velocity (Engine Back Force)
	//self:ApplyTorque(math.min(TorqueDiff, TotalReqTq)/self.Inertia, true, DeltaTime)
	Wire_TriggerOutput(self, "Back Force", -(math.min(TorqueDiff, TotalReqTq)/self.Inertia))
	
	-- Add RPM (Manual Gearbox)(Engine Back Force)
	if self.ManualGearbox then
		if self.Throttle == 0 and self.GearboxCurrentGear != 0 then
			//self:ApplyTorque(TotalReqTq2/self.Inertia, false, DeltaTime)
			Wire_TriggerOutput(self, "Back Force", (TotalReqTq2/self.Inertia))
		end
	end
	
	self:UpdateOverlayText()
	Wire_TriggerOutput(self, "RPM", self.FlyRPM)
	
	return
end

/*function ENT:ApplyTorque(Torque, Removal, DeltaTime)
	local Phys = self:GetPhysicsObject()
	local Force = self:GetForward() * Torque - self:GetForward()
	if Removal then
		if self.inverted then Phys:ApplyForceOffset( Force * -39.37 * DeltaTime, self:GetPos() + self:GetRight() * 39.37 )
		else Phys:ApplyForceOffset( Force * 39.37 * DeltaTime, self:GetPos() + self:GetRight() * -39.37 ) end
	else
		if self.inverted then Phys:ApplyForceOffset( Force * 39.37 * DeltaTime, self:GetPos() + self:GetRight() * 39.37 )
		else Phys:ApplyForceOffset( Force * -39.37 * DeltaTime, self:GetPos() + self:GetRight() * -39.37 ) end
	end
end*/

function ENT:CheckRopes()
	for Key, Link in pairs( self.GearLink ) do
		local Ent = Link.Ent
		
		local OutPos = self:LocalToWorld( self.Out )
		local InPos = Ent:LocalToWorld( Ent.In )
		
		-- make sure it is not stretched too far
		if OutPos:Distance( InPos ) > Link.RopeLen * 1.5 then
			self:Unlink( Ent )
		end
		
		-- make sure the angle is not excessive
		local Direction = -self:GetUp()
		
		local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
		if DrvAngle < 0.7 then
			self:Unlink( Ent )
		end
	end
end

function ENT:Link( Target )
	--Allowable Target
	if not IsValid( Target ) or not table.HasValue( { "acf_gearbox", "acf_gearbox_cvt", "acf_gearbox_auto", "acf_gearbox_air", "acf_gearbox_manual" }, Target:GetClass() ) then
		return false, "Can only link to gearboxes!"
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
	
	local Direction = -self:GetUp()
	
	local DrvAngle = ( OutPos - InPos ):GetNormalized():DotProduct( Direction )
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end
	
	local Rope = nil
	if self.Owner:GetInfoNum( "ACF_MobilityRopeLinks", 1) == 1 then
		Rope = constraint.CreateKeyframeRope( OutPos, 1, "cable/cable2", nil, self, self.Out, 0, Target, Target.In, 0 )
	end
	
	local Link = {
		Ent = Target,
		Rope = Rope,
		RopeLen = ( OutPos - InPos ):Length(),
		ReqTq = 0,
		ReqTq2 = 0	--used for manual gearbox, engine back-force torque
	}
	
	table.insert( self.GearLink, Link )
	table.insert( Target.Master, self )
	
	//Perform Manual Gearbox Checkup
	if Target.isManual then
		self.ManualGearbox = true
	end
	
	return true, "Link successful!"
end

function ENT:Unlink( Target )
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
			
			-- Make Sure Manual Gearbox are disabled
			self.ManualGearbox = false
			
			return true, "Unlink successful!"
		end
	end
	return false, "That gearbox is not linked to this engine!"
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
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )
end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
end
