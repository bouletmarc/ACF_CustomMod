AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()

	--input
	self.RPM = false

	
	self.CanUpdate = true
	
	self.Inputs = Wire_CreateInputs( self, { "RPM" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "ActiveChips" }, { "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Vtec"

end  

function MakeACF_Vtec(Owner, Pos, Angle, Id, Data1)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Vtec = ents.Create("ACF_Vtec")
	local List = list.Get("ACFEnts")
	local Classes = list.Get("ACFClasses")
	if not Vtec:IsValid() then return false end
	Vtec:SetAngles(Angle)
	Vtec:SetPos(Pos)
	Vtec:Spawn()
	
	Vtec:SetPlayer(Owner)
	Vtec.Owner = Owner
	Vtec.Id = Id
	Vtec.Model = List["Mobility2"][Id]["model"]
	Vtec.Weight = List["Mobility2"][Id]["weight"]
	Vtec.ModTable = List["Mobility2"][Id]["modtable"]
		Vtec.ModTable[1] = Data1
		Vtec.KickRpm = Data1
	
	Vtec.KickActive = 0
	Vtec.Kickv = tonumber(Vtec.KickRpm)
	
	Vtec:SetModel( Vtec.Model )
	
	Vtec:PhysicsInit( SOLID_VPHYSICS )      	
	Vtec:SetMoveType( MOVETYPE_VPHYSICS )     	
	Vtec:SetSolid( SOLID_VPHYSICS )
	
	local phys = Vtec:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( Vtec.Weight ) 
	end
	
	Vtec:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	Vtec:SetNetworkedBeamInt("Kicking",Vtec.KickRpm)
	Vtec:SetNetworkedBeamInt("Weight",Vtec.Weight)
	
	Owner:AddCount("_acf_vtec", Vtec)
	Owner:AddCleanup( "acfmenu", Vtec )
	
	return Vtec
end

list.Set( "ACFCvars", "acf_vtec" , {"id", "data1"} )
duplicator.RegisterEntityClass("acf_vtec", MakeACF_Vtec, "Pos", "Angle", "Id", "KickRpm")


--if updating
function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
		
	local Feedback = "Chip updated successfully"
	if ( ArgsTable[1] != self.Owner ) then --Argtable[1] is the player that shot the tool
		Feedback = "You don't own that chip !"
	return Feedback end
	
	local Id = ArgsTable[4]	--Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")
	
	if ( List["Mobility2"][Id]["model"] != self.Model ) then --Make sure the models are the sames before doing a changeover
		Feedback = "The new chip needs to have the same model as the old one !"
	return Feedback end
	
	if self.Id != Id then
		self.Id = Id
		self.Model = List["Mobility2"][Id]["model"]
		self.Weight = List["Mobility2"][Id]["weight"]
		self.KickActive = 0
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.KickRpm = ArgsTable[5]
	self.Kickv = tonumber(self.KickRpm)
	
	self:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	self:SetNetworkedBeamInt("Kicking",self.KickRpm)
	self:SetNetworkedBeamInt("Weight",self.Weight)
	
	
	return Feedback
end

function ENT:TriggerInput( iname , value )
	if (iname == "RPM") then
		if (value > self.Kickv) then
			self.RPM = true
			self.KickActive = 1
			Wire_TriggerOutput(self, "ActiveChips", self.KickActive)
		elseif (value <= self.Kickv) then
			self.RPM = false
			self.KickActive = 0
			Wire_TriggerOutput(self, "ActiveChips", self.KickActive)
		end
	end

end


function ENT:OnRemove()
	Wire_Remove(self)
end

function ENT:OnRestore()
    Wire_Restored(self)
end
	