AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Gearbox AIR"
ENT.WireDebugName = "ACF Gearbox AIR"

if CLIENT then

	local ACF_GearboxAirInfoWhileSeated = CreateClientConVar("ACF_GearboxAirInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
	
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACF_GearboxAirInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
		
	end
	
	function ACFGearboxAirGUICreate( Table )
			
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
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		maxtorque = Table.maxtq
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

	self.Gear = 0
	self.GearRatio = 1
	self.PropellerRpm = 0
	
	self.LegalThink = 0
	
	self.RPM = {}
	self.CurRPM = 0
	self.CanUpdate = true
	self.LastActive = 0
	self.Legal = true
	
	self.Inputs = Wire_CreateInputs( self, {"Clutch", "Brake"} )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "Entity" , "Gearbox RPM" }, { "ENTITY" , "NORMAL" } )
    Wire_TriggerOutput( self, "Entity", self )
	
end  

function MakeACF_GearboxAIR(Owner, Pos, Angle, Id)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local GearboxAIR = ents.Create("acf_gearbox_air")
	local List = list.Get("ACFCUSTOMEnts")
	local Classes = list.Get("ACFClasses")
	if not IsValid( GearboxAIR ) then return false end
	GearboxAIR:SetAngles(Angle)
	GearboxAIR:SetPos(Pos)
	GearboxAIR:Spawn()

	GearboxAIR:SetPlayer(Owner)
	GearboxAIR.Owner = Owner
	GearboxAIR.Id = Id
	GearboxAIR.Model = List.MobilityCustom[Id].model
	GearboxAIR.Mass = List.MobilityCustom[Id].weight
	GearboxAIR.MaxTorque = List.MobilityCustom[Id].maxtq
	
	GearboxAIR:SetModel( GearboxAIR.Model )
	
	GearboxAIR.LClutch = GearboxAIR.MaxTorque
	GearboxAIR.RClutch = GearboxAIR.MaxTorque

	GearboxAIR:PhysicsInit( SOLID_VPHYSICS )      	
	GearboxAIR:SetMoveType( MOVETYPE_VPHYSICS )     	
	GearboxAIR:SetSolid( SOLID_VPHYSICS )

	local phys = GearboxAIR:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( GearboxAIR.Mass ) 
	end
	
	GearboxAIR.In = GearboxAIR:WorldToLocal(GearboxAIR:GetAttachment(GearboxAIR:LookupAttachment( "input" )).Pos)
	GearboxAIR.OutL = GearboxAIR:WorldToLocal(GearboxAIR:GetAttachment(GearboxAIR:LookupAttachment( "driveshaftL" )).Pos)
	GearboxAIR.OutR = GearboxAIR:WorldToLocal(GearboxAIR:GetAttachment(GearboxAIR:LookupAttachment( "driveshaftR" )).Pos)
	
	Owner:AddCount("_acf_gearboxair", GearboxAIR)
	Owner:AddCleanup( "acfcustom", GearboxAIR )
	
	GearboxAIR:SetBodygroup(1, 0)
	
	GearboxAIR:SetNWString( "WireName", List.MobilityCustom[Id].name )
	GearboxAIR:UpdateOverlayText()
	--GearboxAIR:SetModelScaling()
		
	return GearboxAIR
end
list.Set( "ACFCvars", "acf_gearbox_air" , {"id"} )
duplicator.RegisterEntityClass("acf_gearbox_air", MakeACF_GearboxAIR, "Pos", "Angle", "Id" )

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that gearbox!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFCUSTOMEnts")
	
	if List.Mobility[Id].model ~= self.Model then
		return false, "The new gearbox must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Mass = List.MobilityCustom[Id].weight
		self.MaxTorque = List.MobilityCustom[Id].maxtq
		
		local phys = self:GetPhysicsObject()    
		if IsValid( phys ) then 
			phys:SetMass( self.Mass ) 
		end
	end
	
	self:SetBodygroup(1, 0)
	
	self:SetNWString( "WireName", List.MobilityCustom[Id].name )
	self:UpdateOverlayText()
	
	return true, "AIR Gearbox updated successfully!"
end

function ENT:UpdateOverlayText()
	local text = ""
	text = text .. "Propeller RPM: " .. math.Round(self.PropellerRpm,0) .. " Rpm\n"
	text = text .. "Torque Rating: " .. self.MaxTorque .. " Nm / " .. math.Round( self.MaxTorque * 0.73 ) .. " ft-lb"
	
	self:SetOverlayText( text )
end

-- prevent people from changing bodygroup
function ENT:CanProperty( ply, property )
	return property ~= "bodygroups"
end

function ENT:TriggerInput( iname, value )
	if ( iname == "Clutch" ) then
		self.LClutch = math.Clamp(1-value,0,1)*self.MaxTorque
		self.RClutch = math.Clamp(1-value,0,1)*self.MaxTorque
	elseif ( iname == "Brake" ) then
		self.LBrake = math.Clamp(value,0,100)
		self.RBrake = math.Clamp(value,0,100)
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

function ENT:Calc( InputRPM, InputInertia, GetRatio )
	if self.LastActive == CurTime() then
		return math.min( self.TotalReqTq, self.MaxTorque )
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
		
		--Set Rpm, Convert Speed to Rpm
		local RPM = 0
		if GetRatio >= 0 then RPM = self:GetVelocity():Length()*1.5
		else RPM = self:GetVelocity():Length()*-1.5 end
		if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
			Link.ReqTq = math.min( Clutch, ( InputRPM - RPM ) * InputInertia )
		end
		--Calling RPM Ouputs Value's
		if Clutch == 0 then
			Wire_TriggerOutput(self, "Gearbox RPM", 0)
		elseif Clutch > 0 then
			Wire_TriggerOutput(self, "Gearbox RPM", RPM)
		end
		self.PropellerRpm = RPM
		self:UpdateOverlayText()
		
		self.TotalReqTq = self.TotalReqTq + math.abs( Link.ReqTq )
	end
			
	return math.min( self.TotalReqTq, self.MaxTorque )
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
	/*local BrakeMult = 0
	if Brake > 0 then
		BrakeMult = Link.Vel * Phys:GetInertia() * Brake / 10
	end*/
	--Get Rpm
	local BoxPhys = self:GetPhysicsObject()
	local SelfWorld = self:LocalToWorld( BoxPhys:GetAngleVelocity() ) - self:GetPos()
	local Wheel = Link.Ent
	local WheelPhys = Wheel:GetPhysicsObject()
	local VelDiff = ( Wheel:LocalToWorld( WheelPhys:GetAngleVelocity() ) - Wheel:GetPos() ) - SelfWorld
	local BaseRPM = VelDiff:Dot( Wheel:LocalToWorld( Link.Axis ) - Wheel:GetPos() )
	local RealRpm = BaseRPM/-6
	--set force1
	local Force = 0
	if RealRpm <= self:GetVelocity():Length()/2.5 then
		Force = 5
	elseif RealRpm > self:GetVelocity():Length()/2.5 then
		Force = -5
	end
	--set force2
	local Force2 = Torque*3
	/*if Brake == 0 then
		Force2 = Torque*3
	else
		Force2 = 0
	end*/
	Phys:AddAngleVelocity(Vector(0,0,Force*-39.37*DeltaTime))
	Phys:ApplyForceCenter(  Link.Ent:GetUp()*Force2 )
end

function ENT:Link( Target )
	if not IsValid( Target ) or not table.HasValue( { "prop_physics" }, Target:GetClass() ) then
		return false, "Can only link props, like propeller!"
	end
	-- Check if target is already linked
	for Key, Link in pairs( self.WheelLink ) do
		if Link.Ent == Target then 
			return false, "That is already linked to this gearbox!"
		end
	end
	-- make sure the angle is not excessive
	local InPos = Vector( 0, 0, 0 )
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

