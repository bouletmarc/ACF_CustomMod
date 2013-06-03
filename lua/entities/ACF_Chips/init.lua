AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()

	--input
	self.ActiveChips = false

	
	self.CanUpdate = true
	
	self.Inputs = Wire_CreateInputs( self, { "ActiveChips" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "TqAdd", "MaxRpmAdd", "LimitRpmAdd", "Active" }, { "NORMAL", "NORMAL", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Chips"

end  

function MakeACF_Chips(Owner, Pos, Angle, Id, Data1, Data2, Data3)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Chips = ents.Create("ACF_Chips")
	local List = list.Get("ACFEnts")
	local Classes = list.Get("ACFClasses")
	if not Chips:IsValid() then return false end
	Chips:SetAngles(Angle)
	Chips:SetPos(Pos)
	Chips:Spawn()
	
	Chips:SetPlayer(Owner)
	Chips.Owner = Owner
	Chips.Id = Id
	Chips.Model = List["Mobility2"][Id]["model"]
	Chips.Weight = List["Mobility2"][Id]["weight"]
	Chips.ModTable = List["Mobility2"][Id]["modtable"]
		Chips.ModTable[1] = Data1
		Chips.ModTable[2] = Data2
		Chips.ModTable[3] = Data3
		Chips.TorqueAdd2 = Data1
		Chips.MaxRPMAdd2 = Data2
		Chips.LimitRPMAdd2 = Data3
	
	Chips.TorqueAdd3 = 0
	Chips.MaxRPMAdd3 = 0
	Chips.LimitRPMAdd3 = 0
	
	Chips:SetModel( Chips.Model )
	
	Chips:PhysicsInit( SOLID_VPHYSICS )      	
	Chips:SetMoveType( MOVETYPE_VPHYSICS )     	
	Chips:SetSolid( SOLID_VPHYSICS )
	
	local phys = Chips:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( Chips.Weight ) 
	end
	
	Chips:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	Chips:SetNetworkedBeamInt("TorqueAdd",Chips.TorqueAdd2)
	Chips:SetNetworkedBeamInt("MaxRPMAdd",Chips.MaxRPMAdd2)
	Chips:SetNetworkedBeamInt("LimitRPMAdd",Chips.LimitRPMAdd2)
	Chips:SetNetworkedBeamInt("Weight",Chips.Weight)
	
	Owner:AddCount("_acf_chips", Chips)
	Owner:AddCleanup( "acfmenu", Chips )
	
	return Chips
end

list.Set( "ACFCvars", "acf_chips" , {"id", "data1", "data2", "data3"} )
duplicator.RegisterEntityClass("acf_chips", MakeACF_Chips, "Pos", "Angle", "Id", "TorqueAdd2", "MaxRPMAdd2", "LimitRPMAdd2")


--if updating
function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.ActiveChips then
		return false, "Please turn off the chip before updating it"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that chip!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")

	if List["Mobility2"][Id]["model"] ~= self.Model then
		return false, "The new chip must have the same model!"
	end
	
	if self.Id != Id then
		self.Id = Id
		self.Model = List["Mobility2"][Id]["model"]
		self.Weight = List["Mobility2"][Id]["weight"]
		self.TorqueAdd3 = 0
		self.MaxRPMAdd3 = 0
		self.LimitRPMAdd3 = 0
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
	self.ModTable[3] = ArgsTable[7]
	self.TorqueAdd2 = ArgsTable[5]
	self.MaxRPMAdd2 = ArgsTable[6]
	self.LimitRPMAdd2 = ArgsTable[7]
	
	self:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	self:SetNetworkedBeamInt("TorqueAdd",self.TorqueAdd2)
	self:SetNetworkedBeamInt("MaxRPMAdd",self.MaxRPMAdd2)
	self:SetNetworkedBeamInt("LimitRPMAdd",self.LimitRPMAdd2)
	self:SetNetworkedBeamInt("Weight",self.Weight)
	
	
	return true, "Chip updated successfully!"
end

function ENT:TriggerInput( iname , value )
	if (iname == "ActiveChips") then
		if (value > 0) then
			self.ActiveChips = true
			self.ActiveChips2 = 1
			self.TorqueAdd3 = self.TorqueAdd2
			self.MaxRPMAdd3 = self.MaxRPMAdd2
			self.LimitRPMAdd3 = self.LimitRPMAdd2
			Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd3)
			Wire_TriggerOutput(self, "MaxRpmAdd", self.MaxRPMAdd3)
			Wire_TriggerOutput(self, "LimitRpmAdd", self.LimitRPMAdd3)
			Wire_TriggerOutput(self, "Active", self.ActiveChips2)
		elseif (value <= 0) then
			self.ActiveChips = false
			self.ActiveChips2 = 0
			self.TorqueAdd3 = 0
			self.MaxRPMAdd3 = 0
			self.LimitRPMAdd3 = 0
			Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd3)
			Wire_TriggerOutput(self, "MaxRpmAdd", self.MaxRPMAdd3)
			Wire_TriggerOutput(self, "LimitRpmAdd", self.LimitRPMAdd3)
			Wire_TriggerOutput(self, "Active", self.ActiveChips2)
		end
	end

end


function ENT:OnRemove()
	Wire_Remove(self)
end

function ENT:OnRestore()
    Wire_Restored(self)
end
	
	
	