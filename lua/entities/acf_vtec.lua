AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Vtec"
ENT.WireDebugName = "ACF Vtec"

if CLIENT then
	
	function ACFVtecGUICreate( Table )
		
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
				ACF_VtecSlider(1, Value, Table.id, "Kick Rpm")
			end
		end
		
		acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
		
		acfmenupanel.CustomDisplay:PerformLayout()
		
	end

	function ACF_VtecSlider(Mod, Value, ID, Desc)

		if Mod and not acfmenupanel.CData[Mod] then	
			acfmenupanel.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
				acfmenupanel.CData[Mod]:SetText( Desc or "Kick Rpm "..Mod )
				acfmenupanel.CData[Mod].Label:SizeToContents()
				acfmenupanel.CData[Mod]:SetMin( 1500 )
				acfmenupanel.CData[Mod]:SetMax( 8000 )
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
	self.RPM = false

	
	self.CanUpdate = true
	
	self.Inputs = Wire_CreateInputs( self, { "RPM" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "ActiveChips" }, { "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Vtec"

end  

function MakeACF_Vtec(Owner, Pos, Angle, Id, Data1)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Vtec = ents.Create("acf_vtec")
	if not IsValid( Vtec ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List.Mobility[Id] then EID = Id else EID = "5.7-V8" end
	local Lookup = List.Mobility[EID]
	
	Vtec:SetAngles(Angle)
	Vtec:SetPos(Pos)
	Vtec:Spawn()

	Vtec:SetPlayer(Owner)
	Vtec.Owner = Owner
	Vtec.Id = EID
	Vtec.Model = Lookup.model
	Vtec.Weight = Lookup.weight
	Vtec.ModTable = Lookup.modtable
		Vtec.ModTable[1] = Data1
		Vtec.KickRpm = Data1
		
	Vtec.KickActive = 0
	Vtec.Kickv = tonumber(Vtec.KickRpm)
				
	Vtec:SetModel( Vtec.Model )	

	Vtec:PhysicsInit( SOLID_VPHYSICS )      	
	Vtec:SetMoveType( MOVETYPE_VPHYSICS )     	
	Vtec:SetSolid( SOLID_VPHYSICS )

	local phys = Vtec:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Vtec.Weight ) 
	end
	
	Owner:AddCount("_acf_vtec", Vtec)
	Owner:AddCleanup( "acfmenu", Vtec )
	
	Vtec:SetNetworkedString( "WireName", Lookup.name )
	Vtec:UpdateOverlayText()
		
	return Vtec
end
list.Set( "ACFCvars", "acf_vtec" , {"id", "data1"} )
duplicator.RegisterEntityClass("acf_vtec", MakeACF_Vtec, "Pos", "Angle", "Id", "KickRpm")

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that vtec chip!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFEnts").Mobility[Id]
	
	if List.Mobility[Id].model ~= self.Model then
		return false, "The new Vtec chip must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
		self.Weight = Lookup.weight
		self.KickActive = 0
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.KickRpm = ArgsTable[5]
	self.Kickv = tonumber(self.KickRpm)
	
	self:SetNetworkedString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	
	return true, "Vtec updated successfully!"
end

function ENT:UpdateOverlayText()
	
	local text = "Kick Rpm: " .. self.KickRpm .. "Rpm\n"
	text = text .. "Weight: " .. self.Weight .. "Kg"
	
	self:SetOverlayText( text )
	
end


-- prevent people from changing bodygroup
function ENT:CanProperty( ply, property )

	return property ~= "bodygroups"

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

