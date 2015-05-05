
local cat = ((ACFCUSTOM.CustomToolCategory and ACFCUSTOM.CustomToolCategory:GetBool()) and "ACF" or "Construction");

TOOL.Category		= cat
TOOL.Name			= "#Tool.acfcustom.listname"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "type" ] = "MobilityCustom"
TOOL.ClientConVar[ "id" ] = "1.0L-I4"

TOOL.ClientConVar[ "data1" ] = "1.0L-I4"
TOOL.ClientConVar[ "data2" ] = 0
TOOL.ClientConVar[ "data3" ] = 0
TOOL.ClientConVar[ "data4" ] = 0
TOOL.ClientConVar[ "data5" ] = 0
TOOL.ClientConVar[ "data6" ] = 0
TOOL.ClientConVar[ "data7" ] = 0
TOOL.ClientConVar[ "data8" ] = 0
TOOL.ClientConVar[ "data9" ] = 0
TOOL.ClientConVar[ "data10" ] = 0
TOOL.ClientConVar[ "data11" ] = 0
TOOL.ClientConVar[ "data12" ] = 0
TOOL.ClientConVar[ "data13" ] = 0
TOOL.ClientConVar[ "data14" ] = 0
TOOL.ClientConVar[ "data15" ] = 0
TOOL.ClientConVar[ "red" ] = 0
TOOL.ClientConVar[ "green" ] = 0
TOOL.ClientConVar[ "blue" ] = 0

cleanup.Register( "acfcustom" )

if CLIENT then	
	language.Add( "Tool.acfcustom.listname", "ACF Custom" )
	language.Add( "Tool.acfcustom.name", "ACF Custom V4" )
	language.Add( "Tool.acfcustom.desc", "Spawn the ACF Custom Entity" )
	language.Add( "Tool.acfcustom.0", "Left click to spawn the entity, Right click to link an entity to another (+Use to unlink)" )
	language.Add( "Tool.acfcustom.1", "Right click to link the selected sensor to a pod" )
	
	language.Add( "Undone_ACF Entity", "Undone ACF Entity" )
	language.Add( "Undone_acf_engine", "Undone ACF Engine" )
	language.Add( "Undone_acf_enginemaker", "Undone ACF Engine Maker" )
	language.Add( "Undone_acf_gearboxcvt", "Undone ACF Gearbox CVT" )
	language.Add( "Undone_acf_gearboxauto", "Undone ACF Gearbox Automatic" )
	language.Add( "Undone_acf_chips", "Undone ACF Engine Chips" )
	language.Add( "Undone_acf_vtec", "Undone ACF Vtec Chip" )
	language.Add( "Undone_acf_nos", "Undone ACF Nos Bottle" )

	/*------------------------------------
		BuildCPanel
	------------------------------------*/
	function TOOL.BuildCPanel( CPanel )
	
		local pnldef_ACFcustom = vgui.RegisterFile( "acf/client/cl_acfcustom_gui.lua" )
		
		// create
		local DPanel = vgui.CreateFromTable( pnldef_ACFcustom )
		CPanel:AddPanel( DPanel )
	
	end
end

-- Spawn/update functions
function TOOL:LeftClick( trace )

	if CLIENT then return true end
	if not IsValid( trace.Entity ) and not trace.Entity:IsWorld() then return false end
	
	local ply = self:GetOwner()
	local Type = self:GetClientInfo( "type" )
	local Id = self:GetClientInfo( "id" )
	
	local DupeClass = duplicator.FindEntityClass( ACFCUSTOM.Weapons[Type][Id]["ent"] ) 
	
	if DupeClass then
		local ArgTable = {}
			ArgTable[2] = trace.HitNormal:Angle():Up():Angle()
			ArgTable[1] = trace.HitPos + trace.HitNormal*32
			
		local ArgList = list.Get("ACFCvars")
		
		-- Reading the list packaged with the ent to see what client CVar it needs
		for Number, Key in pairs( ArgList[ACFCUSTOM.Weapons[Type][Id]["ent"]] ) do
			ArgTable[ Number+2 ] = self:GetClientInfo( Key )
		end
		
		--Set Allowed Custom Update
		local Class = trace.Entity:GetClass()
		local ClassMenu = ACFCUSTOM.Weapons[Type][Id]["ent"]
		local Allowed = false
		if Class == "acf_engine" and ClassMenu != "acf_chips" then Allowed = true end
		if Class == "acf_gearbox" and ClassMenu != "acf_chips" then Allowed = true end
		if Class == "acf_engine_custom" and ClassMenu == "acf_enginemaker" then Allowed = true end
		if Class == "acf_enginemaker" and ClassMenu == "acf_engine_custom" then Allowed = true end
		if Class == "acf_gearboxcvt" and ClassMenu == "acf_gearboxair" then Allowed = true end
		if Class == "acf_gearboxcvt" and ClassMenu == "acf_gearboxauto" then Allowed = true end
		if Class == "acf_gearboxair" and ClassMenu == "acf_gearboxcvt" then Allowed = true end
		if Class == "acf_gearboxair" and ClassMenu == "acf_gearboxauto" then Allowed = true end
		if Class == "acf_gearboxauto" and ClassMenu == "acf_gearboxcvt" then Allowed = true end
		if Class == "acf_gearboxauto" and ClassMenu == "acf_gearboxair" then Allowed = true end
		
		--Set Welding Chips to Trace.Entity
		local Welding = false
		if ClassMenu == "acf_chips" and Class == "prop_physics" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_engine" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_engine_custom" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_enginemaker" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_gearbox" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_gearboxcvt" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_gearboxair" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_gearboxauto" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_fueltank" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_rads" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_turbo" then Welding = true end
		if ClassMenu == "acf_chips" and Class == "acf_supercharger" then Welding = true end
		
		local bone = trace.PhysicsBone
		
		if trace.Entity:GetClass() == ACFCUSTOM.Weapons[Type][Id]["ent"] and trace.Entity.CanUpdate then
			table.insert( ArgTable, 1, ply )
			local success, msg = trace.Entity:Update( ArgTable )
			ACFCUSTOM_SendNotify( ply, success, msg )
		elseif Allowed then
			--Not the same Model
			if trace.Entity:GetModel() != ACFCUSTOM.Weapons[Type][Id]["model"] then
				local success = false
				local msg = "Not the same Model"
				ACFCUSTOM_SendNotify( ply, success, msg )
			return end
			
			--Not the same Owner
			if trace.Entity.Owner != ply then
				local success = false
				local msg = "You don't own this Engine"
				ACFCUSTOM_SendNotify( ply, success, msg )
			return end
			
			--Make ArgTable
			local ArgTable2 = {}
			ArgTable2[1] = trace.Entity:GetPos()
			ArgTable2[2] = trace.Entity:GetAngles()
			for Number2, Key2 in pairs( ArgList[ACFCUSTOM.Weapons[Type][Id]["ent"]] ) do
				ArgTable2[ Number2+2 ] = self:GetClientInfo( Key2 )
			end
			
			--check if welded
			local constr = {}
			table.Add(constr,constraint.FindConstraints(trace.Entity, "Weld"))
			
			--Remove the entity and replace it
			trace.Entity:Remove()
			
			--spawn it back
			local Ent = DupeClass.Func( ply, unpack( ArgTable2 ) )
			Ent:Activate()
			Ent:GetPhysicsObject():Sleep()
			Ent:GetPhysicsObject():EnableMotion(false)
			
			--Weld it, must be welded before
			if constr then
				for Key,Const in pairs(constr) do
					constraint.Weld(Ent,Const.Ent2,bone,0,0,true,false)
					if Const.Ent3 then constraint.Weld(Ent,Const.Ent3,bone,0,0,true,false) end
				end
			end
			
			
			undo.Create( ACFCUSTOM.Weapons[Type][Id]["ent"] )
				undo.AddEntity( Ent )
				undo.SetPlayer( ply )
			undo.Finish()
			
			local success = true
			local msg = "Custom update done - Wire and link entities again"
			ACFCUSTOM_SendNotify( ply, success, msg )
		elseif Welding then
			--Make ArgTable
			local ArgTable2 = {}
			ArgTable2[1] = trace.HitPos + trace.HitNormal
			ArgTable2[2] = trace.HitNormal:Angle() + Angle(90,0,0)
			for Number2, Key2 in pairs( ArgList[ACFCUSTOM.Weapons[Type][Id]["ent"]] ) do
				ArgTable2[ Number2+2 ] = self:GetClientInfo( Key2 )
			end
			
			--spawn it back
			local Ent = DupeClass.Func( ply, unpack( ArgTable2 ) )
			Ent:Activate()
			Ent:GetPhysicsObject():Sleep()
			Ent:GetPhysicsObject():EnableMotion(false)
			
			--Weld it
			constraint.Weld(Ent,trace.Entity,bone,0,0,true,false)
			
			undo.Create( ACFCUSTOM.Weapons[Type][Id]["ent"] )
				undo.AddEntity( Ent )
				undo.SetPlayer( ply )
			undo.Finish()
		else
			-- Using the Duplicator entity register to find the right factory function
			local Ent = DupeClass.Func( ply, unpack( ArgTable ) )
			Ent:Activate()
			Ent:GetPhysicsObject():Wake()
			
			undo.Create( ACFCUSTOM.Weapons[Type][Id]["ent"] )
				undo.AddEntity( Ent )
				undo.SetPlayer( ply )
			undo.Finish()
		end
			
		return true
	else
		print("Didn't find entity duplicator records")
	end

end

-- Link/unlink functions
function TOOL:RightClick( trace )

	if not IsValid( trace.Entity ) then return false end
	if CLIENT then return true end
	
	local ply = self:GetOwner()
	
	if self:GetStage() == 0 and trace.Entity.IsMaster then
		self.Master = trace.Entity
		self:SetStage( 1 )
		return true
	elseif self:GetStage() == 1 then
		local success, msg
		
		if ply:KeyDown( IN_USE ) or ply:KeyDown( IN_SPEED ) then
			success, msg = self.Master:Unlink( trace.Entity )
		else
			success, msg = self.Master:Link( trace.Entity )
		end
		
		ACFCUSTOM_SendNotify( ply, success, msg )
		
		self:SetStage( 0 )
		self.Master = nil
		return true
	else
		return false
	end
	
end

