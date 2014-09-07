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
			acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250, 325, 250 ) )
			acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanel.CData.DisplayModel:SetFOV( 1 )
			acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
			acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
		
		acfmenupanel:CPanelText("Desc", "Desc : "..Table.desc)
		acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
		
		for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_ChipSlider1(1, Value, Table.id, "Torque Adding")
			elseif ID == 2 then
				ACF_ChipSlider2(2, Value, Table.id, "Rpm Max Adding")
			elseif ID == 3 then
				ACF_ChipSlider2(3, Value, Table.id, "Rpm Limit Adding")
			elseif ID == 4 then
				ACF_ChipVtecSlider(4, Value, Table.id)
			end
		end
		
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
				acfmenupanel.CData[Mod]:SetMax( 3000 )
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
	
	function ACF_ChipVtecSlider(Mod, Value, ID)

		local VtecUsing = 0
		local VtecKickRpm = 4500
		
		if VtecSlider then VtecSlider:Remove() end
		
		VtecButton = vgui.Create("DButton")
		VtecButton:SetWide(100)
		VtecButton:SetTall(60)
		VtecButton:SetText("Vtec Off")
		VtecButton:SetTextColor(Color(200,20,20,255))
		VtecButton:SetToolTip("Vtec On = Adding the Power like a Vtec\nVtec Off = Adding the Power instantly")
		VtecButton.DoClick = function()
			if VtecUsing == 0 then
				VtecUsing = 1
				VtecButton:SetText("Vtec On")
				VtecButton:SetTextColor(Color(20,200,20,255))
				acfmenupanel.ModData[ID]["ModTable"][Mod] = VtecKickRpm
				--Create The Slider
				VtecSlider = vgui.Create( "DNumSlider")
					VtecSlider:SetText( "Kick Rpm")
					VtecSlider.Label:SizeToContents()
					VtecSlider:SetMin( 3500 )
					VtecSlider:SetMax( 6000 )
					VtecSlider:SetDecimals( 0 )
					VtecSlider["Mod"] = Mod
					VtecSlider["ID"] = ID
					VtecSlider:SetValue(VtecKickRpm)
					VtecSlider:SetDark( true )
					RunConsoleCommand( "acfmenu_data"..Mod, VtecKickRpm )
					VtecSlider.OnValueChanged = function( slider, val )
						acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
						RunConsoleCommand( "acfmenu_data"..Mod, val )
						VtecKickRpm = val
					end
				acfmenupanel.CustomDisplay:AddItem( VtecSlider )
			elseif VtecUsing == 1 then
				VtecUsing = 0
				VtecButton:SetText("Vtec Off")
				VtecButton:SetTextColor(Color(200,20,20,255))
				if VtecSlider then VtecSlider:Remove() end
				RunConsoleCommand( "acfmenu_data"..Mod, 0 )
				acfmenupanel.ModData[ID]["ModTable"][Mod] = 0
			end
		end
		acfmenupanel.CustomDisplay:AddItem( VtecButton )
	
	end
	
	return
	
end

function ENT:Initialize()

	--think
	self.Master = {}
	self.CanUpdate = true
	self.Legal = true
	self.LastActive = 0
	self.LegalThink = 0
	
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Chips"

end 

function MakeACF_Chips(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4)

	if not Owner:CheckLimit("_acf_extra") then return false end
	
	local Chips = ents.Create("acf_chips")
	if not IsValid( Chips ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List.Mobility[Id] then EID = Id else EID = "V3_Chips" end
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
		Chips.ModTable[4] = Data4
		--Set All Mods
		Chips.Mods1 = Data1	--Torque
		Chips.Mods2 = Data2	--MaxRpm
		Chips.Mods3 = Data3	--LimitRpm
		Chips.Mods4 = Data4	--VtecRpm
		
		Chips.KickRpm = Chips.Mods4	--Check if its Vtec first
	
	--Vtec Settings
	Chips.KickActive = 0
	Chips.KickRpmNumber = tonumber(Chips.KickRpm)
	--Set Vtec Using
	if Chips.KickRpmNumber <= 0 then Chips.VtecUsing = 0
	elseif Chips.KickRpmNumber > 0 then Chips.VtecUsing = 1 end
	--Set Values
	if Chips.VtecUsing == 0 then
		Chips.TorqueAdd = 0
		Chips.MaxRPMAdd = 0
		Chips.LimitRPMAdd = 0
		Chips.TorqueAddVtec = Chips.Mods1
		Chips.MaxRPMAddVtec = Chips.Mods2
		Chips.LimitRPMAddVtec = Chips.Mods3
	elseif Chips.VtecUsing == 1 then
		Chips.TorqueAdd = 0
		Chips.MaxRPMAdd = 0
		Chips.LimitRPMAdd = 0
		Chips.TorqueAddVtec = Chips.Mods1
		Chips.MaxRPMAddVtec = Chips.Mods2
		Chips.LimitRPMAddVtec = Chips.Mods3
	end
	--Creating Wire Outputs
	local Inputs = {}
	local Outputs = {"TqAdd", "MaxRpmAdd", "LimitRpmAdd"}
	local OutputsTypes = {"NORMAL", "NORMAL", "NORMAL"}
	if Chips.VtecUsing == 1 then
		table.insert(Outputs, "Vtec On")
		table.insert(OutputsTypes, "NORMAL")
	else
		table.insert(Inputs, "Active")
	end
	Chips.Inputs = Wire_CreateInputs( Chips, Inputs )
	Chips.Outputs = WireLib.CreateSpecialOutputs( Chips, Outputs, OutputsTypes )
	
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
	Chips:SetWireOutputs()
		
	return Chips
end
list.Set( "ACFCvars", "acf_chips" , {"id", "data1", "data2", "data3", "data4"} )
duplicator.RegisterEntityClass("acf_chips", MakeACF_Chips, "Pos", "Angle", "Id", "Mods1", "Mods2", "Mods3", "Mods4")

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
	self.ModTable[4] = ArgsTable[8]
	--Set Mods
	self.Mods1 = ArgsTable[5]	--Torque
	self.Mods2 = ArgsTable[6]	--MaxRpm
	self.Mods3 = ArgsTable[7]	--LimitRpm
	self.Mods4 = ArgsTable[8]	--VtecRpm
	
	self.KickRpm = self.Mods4	--Check if its Vtec first
	
	--Vtec Settings
	self.KickActive = 0
	self.KickRpmNumber = tonumber(self.KickRpm)
	--Set Vtec Using
	if self.KickRpmNumber <= 0 then self.VtecUsing = 0
	elseif self.KickRpmNumber > 0 then self.VtecUsing = 1 end
	--Set Values
	if self.VtecUsing == 0 then
		self.TorqueAdd = 0
		self.MaxRPMAdd = 0
		self.LimitRPMAdd = 0
		self.TorqueAddVtec = self.Mods1
		self.MaxRPMAddVtec = self.Mods2
		self.LimitRPMAddVtec = self.Mods3
	elseif self.VtecUsing == 1 then
		self.TorqueAdd = 0
		self.MaxRPMAdd = 0
		self.LimitRPMAdd = 0
		self.TorqueAddVtec = self.Mods1
		self.MaxRPMAddVtec = self.Mods2
		self.LimitRPMAddVtec = self.Mods3
	end
	--Creating Wire Outputs
	local Inputs = {}
	local Outputs = {"TqAdd", "MaxRpmAdd", "LimitRpmAdd"}
	local OutputsTypes = {"NORMAL", "NORMAL", "NORMAL"}
	if self.VtecUsing == 1 then
		table.insert(Outputs, "Vtec On")
		table.insert(OutputsTypes, "NORMAL")
	else
		table.insert(Inputs, "Active")
	end
	self.Inputs = Wire_CreateInputs( self, Inputs )
	self.Outputs = WireLib.CreateSpecialOutputs( self, Outputs, OutputsTypes )
	
	self:SetNetworkedString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	self:SetWireOutputs()
	
	return true, "Chips updated successfully!"
end

function ENT:SetWireOutputs()
	Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd)
	Wire_TriggerOutput(self, "MaxRpmAdd", self.MaxRPMAdd)
	Wire_TriggerOutput(self, "LimitRpmAdd", self.LimitRPMAdd)
	if self.VtecUsing == 1 then
		Wire_TriggerOutput(self, "Vtec On", self.KickActive)
	end
end

function ENT:UpdateOverlayText()
	local text = ""
	if self.VtecUsing == 0 then
		text = text .. "Torque Add: " .. math.Round(self.TorqueAddVtec,0) .. "Tq\n"
		text = text .. "Max Rpm Add: " .. math.Round(self.MaxRPMAddVtec,0) .. "Rpm\n"
		text = text .. "Limit Rpm Add: " .. math.Round(self.LimitRPMAddVtec,0) .. "Rpm\n"
		text = text .. "Active: " .. self.KickActive .. "\n"
		text = text .. "Weight: " .. self.Weight .. "Kg"
	elseif self.VtecUsing == 1 then
		text = text .. "Torque Add: " .. math.Round(self.TorqueAddVtec,0) .. "Tq\n"
		text = text .. "Max Rpm Add: " .. math.Round(self.MaxRPMAddVtec,0) .. "Rpm\n"
		text = text .. "Limit Rpm Add: " .. math.Round(self.LimitRPMAddVtec,0) .. "Rpm\n"
		text = text .. "Kick Rpm: " .. math.Round(self.KickRpm,0) .. "Rpm\n"
		text = text .. "Vtec On: " .. self.KickActive .. "\n"
		text = text .. "Weight: " .. self.Weight .. "Kg"
	end
	
	self:SetOverlayText( text )
end

function ENT:TriggerInput( iname , value )
	if (iname == "Active") then
		if self.VtecUsing == 0 then
			if (value > 0) then
				self.TorqueAdd = self.TorqueAddVtec
				self.MaxRPMAdd = self.MaxRPMAddVtec
				self.LimitRPMAdd = self.LimitRPMAddVtec
				self.KickActive = 1
			elseif (value == 0) then
				self.TorqueAdd = 0
				self.MaxRPMAdd = 0
				self.LimitRPMAdd = 0
				self.KickActive = 0
			end
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
	
	self:NextThink(Time+1)
	return true
	
end

--Get RPM for Vtec Chips ONLY
function ENT:GetRPM(IntputRPM)
	if IntputRPM < self.KickRpmNumber then
		self.TorqueAdd = 0
		self.MaxRPMAdd = 0
		self.LimitRPMAdd = 0
		self.KickActive = 0
	elseif IntputRPM >= self.KickRpmNumber then
		self.TorqueAdd = self.TorqueAddVtec
		self.MaxRPMAdd = self.MaxRPMAddVtec
		self.LimitRPMAdd = self.LimitRPMAddVtec
		self.KickActive = 1
	end
	self:UpdateOverlayText()
	self:SetWireOutputs()
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
	for Key,Value in pairs(self.Master) do		--Let's unlink ourselves from the engines properly
		if IsValid( self.Master[Key] ) then
			self.Master[Key]:Unlink( self )
		end
	end
end

