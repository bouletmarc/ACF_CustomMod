AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()

	--input
	self.ActiveNos = false

	self.UsableNos = 1
	self.RpmAddFinal = 0
	
	--Timer setup
	self.StopNos = 0
	self.AllowNos = 0
	
	--think
	self.Legal = true
	self.CanUpdate = true
	self.LegalThink = 0
	self.LastActive = 0
	
	self.Inputs = Wire_CreateInputs( self, { "ActiveNos" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "TqAdd", "MaxRpmAdd", "LimitRpmAdd", "Active", "Usable" }, { "NORMAL", "NORMAL", "NORMAL", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Nos"
end  

function MakeACF_Nos(Owner, Pos, Angle, Id, Data1)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Nos = ents.Create("acf_nos")
	local List = list.Get("ACFEnts")
	local Classes = list.Get("ACFClasses")
	if not Nos:IsValid() then return false end
	Nos:SetAngles(Angle)
	Nos:SetPos(Pos)
	Nos:Spawn()
	
	Nos:SetPlayer(Owner)
	Nos.Owner = Owner
	Nos.Id = Id
	Nos.Model = List["Mobility"][Id]["model"]
	Nos.Weight = List["Mobility"][Id]["weight"]
	Nos.SoundPath = List["Mobility"][Id]["sound"]
	Nos.RpmAdd = List["Mobility"][Id]["rpmadd"]
	Nos.ModTable = List["Mobility"][Id]["modtable"]
		Nos.ModTable[1] = Data1
		Nos.TorqueAdd2 = Data1
	
	Nos.TorqueAdd3 = 0
	Nos.UsableNos = 1
	Nos.RpmAddFinal = 0
	
	--Getting Time
	Nos.SwitchTime = Nos.TorqueAdd2 / 1.6
	Nos.BoostTime = 10
	
	Nos:SetModel( Nos.Model )
	
	--Color/Material
	Nos:SetColor( Color( 0, 0, 255, 255 ) )
	Nos:SetMaterial( "models/debug/debugwhite" )
	
	Nos:PhysicsInit( SOLID_VPHYSICS )      	
	Nos:SetMoveType( MOVETYPE_VPHYSICS )     	
	Nos:SetSolid( SOLID_VPHYSICS )
	
	local phys = Nos:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( Nos.Weight ) 
	end
	
	--send Wire Outputs
	Wire_TriggerOutput(Nos.Entity, "TqAdd", Nos.TorqueAdd3)
	Wire_TriggerOutput(Nos.Entity, "MaxRpmAdd", Nos.RpmAddFinal)
	Wire_TriggerOutput(Nos.Entity, "LimitRpmAdd", Nos.RpmAddFinal)
	Wire_TriggerOutput(Nos.Entity, "Usable", Nos.UsableNos)
	Wire_TriggerOutput(Nos.Entity, "Active", Nos.ActiveChips2)
	--Send to GUI
	Nos:SetNetworkedBeamString("Type",List["Mobility"][Id]["name"])
	Nos:SetNetworkedBeamInt("TorqueAdd",Nos.TorqueAdd2)
	Nos:SetNetworkedBeamInt("Usable",Nos.UsableNos)
	Nos:SetNetworkedBeamInt("Weight",Nos.Weight)
	
	Owner:AddCount("_acf_nos", Nos)
	Owner:AddCleanup( "acfmenu", Nos )
	
	return Nos
end

list.Set( "ACFCvars", "acf_nos" , {"id", "data1"} )
duplicator.RegisterEntityClass("acf_nos", MakeACF_Nos, "Pos", "Angle", "Id", "TorqueAdd2")


--if updating
function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.ActiveChips then
		return false, "Please turn off the nos bottle before updating it"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that nos bottle!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")

	if List["Mobility"][Id]["model"] ~= self.Model then
		return false, "The new nos bottle must have the same model!"
	end
	
	if self.Id != Id then
		self.Id = Id
		self.Model = List["Mobility"][Id]["model"]
		self.Weight = List["Mobility"][Id]["weight"]
		self.SoundPath = List["Mobility"][Id]["sound"]
		self.RpmAdd = List["Mobility"][Id]["rpmadd"]
		self.TorqueAdd3 = 0
		self.UsableNos = 1
		self.RpmAddFinal = 0
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.TorqueAdd2 = ArgsTable[5]
	
	--Getting Time
	self.SwitchTime = self.TorqueAdd2
	self.BoostTime = 10
	
	--send Wire Outputs
	Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd3)
	Wire_TriggerOutput(self, "MaxRpmAdd", self.RpmAddFinal)
	Wire_TriggerOutput(self, "LimitRpmAdd", self.RpmAddFinal)
	Wire_TriggerOutput(self, "Usable", self.UsableNos)
	Wire_TriggerOutput(self, "Active", self.ActiveChips2)
	--Send to GUI
	self:SetNetworkedBeamString("Type",List["Mobility"][Id]["name"])
	self:SetNetworkedBeamInt("TorqueAdd",self.TorqueAdd2)
	self:SetNetworkedBeamInt("Usable",self.UsableNos)
	self:SetNetworkedBeamInt("Weight",self.Weight)
	
	
	return true, "Nos updated successfully!"
end

function ENT:TriggerInput( iname , value )
	if (iname == "ActiveNos") then
		if (value > 0 and self.UsableNos == 1) then
			--calling the timer
			self:PowerUp(math.floor(1))
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(1,200)
		end
	end
end

--think
function ENT:Think()
	local Time = CurTime()
	
	if self.LegalThink < Time and self.LastActive+2 > Time then
		if self:GetPhysicsObject():GetMass() < self.Mass or self:GetParent():IsValid() then
			self.Legal = false
		else 
			self.Legal = true
		end
		self.LegalThink = Time + (math.floor(1))
	end
	
	if self.LegalThink < Time then
		--Stop Nos
		if self.StopNos < CurTime() and self.ActiveChips2 == 1 then
			self.ActiveChips2 = 0	--Nos are not active
			self.TorqueAdd3 = 0		--Stop giving Torque
			self.RpmAddFinal = 0	--Stop giving Rpm
			--Stop sound
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			--Send Wire Outputs
			Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd3)
			Wire_TriggerOutput(self, "MaxRpmAdd", self.RpmAddFinal)
			Wire_TriggerOutput(self, "LimitRpmAdd", self.RpmAddFinal)
			Wire_TriggerOutput(self, "Active", self.ActiveChips2)
			--send GUI
			self:SetNetworkedBeamInt("TorqueAdd",self.TorqueAdd2)
			self:SetNetworkedBeamInt("Usable",self.UsableNos)
		end
		--Reactive Button
		if self.AllowNos < CurTime() and self.UsableNos == 0 then
			self.UsableNos = 1 --usable
			--send wire
			Wire_TriggerOutput(self, "Usable", self.UsableNos)
			--send GUI
			self:SetNetworkedBeamInt("TorqueAdd",self.TorqueAdd2)
			self:SetNetworkedBeamInt("Usable",self.UsableNos)
		end
	end
	
	
	self:NextThink(Time+1)
	return true
	
end

--Timer
function ENT:PowerUp(value)

	self.ActiveChips2 = 1	--Nos are active
	self.UsableNos = 0 		--Unusable
	self.TorqueAdd3 = self.TorqueAdd2	--Get Torque
	self.RpmAddFinal = self.RpmAdd		--Get RPM
	--Send Wire Outputs
	Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd3)
	Wire_TriggerOutput(self, "MaxRpmAdd", self.RpmAddFinal)
	Wire_TriggerOutput(self, "LimitRpmAdd", self.RpmAddFinal)
	Wire_TriggerOutput(self, "Usable", self.UsableNos)
	Wire_TriggerOutput(self, "Active", self.ActiveChips2)
	--send GUI
	self:SetNetworkedBeamInt("TorqueAdd",self.TorqueAdd2)
	self:SetNetworkedBeamInt("Usable",self.UsableNos)
	
	self.StopNos = CurTime() + self.BoostTime
	self.AllowNos = CurTime() + self.SwitchTime
end

function ENT:PreEntityCopy()
	//Wire dupe info
	local DupeInfo = WireLib.BuildDupeInfo( self )
	if DupeInfo then
		duplicator.StoreEntityModifier( self, "WireDupeInfo", DupeInfo )
	end

end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	//Wire dupe info
	if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end
end

function ENT:OnRemove()
	Wire_Remove(self)
end

function ENT:OnRestore()
    Wire_Restored(self)
end
	
	
	