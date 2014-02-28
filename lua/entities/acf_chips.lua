AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Chips"
ENT.WireDebugName = "ACF Chips"

if CLIENT then
	
	function ACFChipsGUICreate( Table )
		
		if not acfmenupanel.ModData then
			acfmenupanel.ModData = {}
		end
		if not acfmenupanel.ModData[Table.id] then
			acfmenupanel.ModData[Table.id] = {}
			acfmenupanel.ModData[Table.id].ModTable = Table.modtable
		end
			
		acfmenupanel:CPanelText("Name", Table.name)
		
		acfmenupanel.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
			acfmenupanel.CData.DisplayModel:SetModel( Table.model )
			acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
			acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanel.CData.DisplayModel:SetFOV( 20 )
			acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
			acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
		
		acfmenupanel:CPanelText("Desc", "Desc : "..Table.desc)
		
		for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_ChipSlider1(1, Value, Table.id, "Torque Adding")
			elseif ID == 2 then
				ACF_ChipSlider2(2, Value, Table.id, "Rpm Max Adding")
			elseif ID == 3 then
				ACF_ChipSlider2(3, Value, Table.id, "Rpm Limit Adding")
			end
		end
		
		acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
		
		acfmenupanel.CustomDisplay:PerformLayout()
		
	end

	function ACF_ChipSlider1(Mod, Value, ID, Desc)

		if Mod and not acfmenupanel.CData[Mod] then	
			acfmenupanel.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
				acfmenupanel.CData[Mod]:SetText( Desc or "Torque Adding "..Mod )
				acfmenupanel.CData[Mod].Label:SizeToContents()
				acfmenupanel.CData[Mod]:SetMin( 10 )
				acfmenupanel.CData[Mod]:SetMax( 1000 )
				acfmenupanel.CData[Mod]:SetDecimals( 0 )
				acfmenupanel.CData[Mod]["Mod"] = Mod
				acfmenupanel.CData[Mod]["ID"] = ID
				acfmenupanel.CData[Mod]:SetValue(Value)
				acfmenupanel.CData[Mod]:SetDark( true )
				RunConsoleCommand( "acfmenu_data"..Mod, Value )
				acfmenupanel.CData[Mod].OnValueChanged = function( slider, val )
					acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
					RunConsoleCommand( "acfmenu_data"..Mod, val )
				end
			acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData[Mod] )
		end

	end

	function ACF_ChipSlider2(Mod, Value, ID, Desc)

		if Mod and not acfmenupanel.CData[Mod] then	
			acfmenupanel.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
				acfmenupanel.CData[Mod]:SetText( Desc or "Adding "..Mod )
				acfmenupanel.CData[Mod].Label:SizeToContents()
				acfmenupanel.CData[Mod]:SetMin( 100 )
				acfmenupanel.CData[Mod]:SetMax( 5000 )
				acfmenupanel.CData[Mod]:SetDecimals( 0 )
				acfmenupanel.CData[Mod]["Mod"] = Mod
				acfmenupanel.CData[Mod]["ID"] = ID
				acfmenupanel.CData[Mod]:SetValue(Value)
				acfmenupanel.CData[Mod]:SetDark( true )
				RunConsoleCommand( "acfmenu_data"..Mod, Value )
				acfmenupanel.CData[Mod].OnValueChanged = function( slider, val )
					acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
					RunConsoleCommand( "acfmenu_data"..Mod, val )
				end
			acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData[Mod] )
		end

	end
	
	return
	
end

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
	
	local Chips = ents.Create("acf_chips")
	if not IsValid( Chips ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List.Mobility[Id] then EID = Id else EID = "5.7-V8" end
	local Lookup = List.Mobility[EID]
	
	Chips:SetAngles(Angle)
	Chips:SetPos(Pos)
	Chips:Spawn()

	Chips:SetPlayer(Owner)
	Chips.Owner = Owner
	Chips.Id = EID
	Chips.Model = Lookup.model
	Chips.Weight = Lookup.weight
	Chips.ModTable = Lookup.modtable
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
	if IsValid( phys ) then 
		phys:SetMass( Chips.Weight ) 
	end
	
	Owner:AddCount("_acf_chips", Chips)
	Owner:AddCleanup( "acfmenu", Chips )
	
	Chips:SetNetworkedString( "WireName", Lookup.name )
	Chips:UpdateOverlayText()
		
	return Chips
end
list.Set( "ACFCvars", "acf_chips" , {"id", "data1", "data2", "data3"} )
duplicator.RegisterEntityClass("acf_chips", MakeACF_Chips, "Pos", "Angle", "Id", "TorqueAdd2", "MaxRPMAdd2", "LimitRPMAdd2")

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine chip!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFEnts").Mobility[Id]
	
	if Lookup.model ~= self.Model then
		return false, "The new Engine Chip must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
		self.Weight = Lookup.weight
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
	
	self:SetNetworkedString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	
	return true, "Chips updated successfully!"
end

function ENT:UpdateOverlayText()
	
	local text = "Torque Add: " .. self.TorqueAdd2 .. "Tq\n"
	text = text .. "Max Rpm Add: " .. self.MaxRPMAdd2 .. "Rpm\n"
	text = text .. "Limit Rpm Add: " .. self.LimitRPMAdd2 .. "Rpm\n"
	text = text .. "Weight: " .. self.Weight .. "Kg"
	
	self:SetOverlayText( text )
	
end


-- prevent people from changing bodygroup
function ENT:CanProperty( ply, property )

	return property ~= "bodygroups"

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

function ENT:PreEntityCopy()
	
	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )

end

function ENT:OnRemove()

	Wire_Remove(self)
	
end

