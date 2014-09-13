AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Nos"
ENT.WireDebugName = "ACF Nos"

if CLIENT then
	
	function ACFNosGUICreate( Table )
		
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
			acfmenupanelcustom.CData.DisplayModel:SetColor(Color(0,0,255))
			acfmenupanelcustom.CData.DisplayModel:SetFOV( 4 )
			acfmenupanelcustom.CData.DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
			acfmenupanelcustom.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData.DisplayModel )
		
		acfmenupanelcustom:CPanelText("Desc", "Desc : "..Table.desc)
		acfmenupanelcustom:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
		
		for ID,Value in pairs(acfmenupanelcustom.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_NosSlider1(1, Value, Table.id, "Torque Adding")
			end
		end
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
	end

	function ACF_NosSlider1(Mod, Value, ID, Desc)
		if Mod and not acfmenupanelcustom.CData[Mod] then	
			acfmenupanelcustom.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Mod]:SetText( Desc or "Torque Adding "..Mod )
				acfmenupanelcustom.CData[Mod].Label:SizeToContents()
				acfmenupanelcustom.CData[Mod]:SetMin( 20 )
				acfmenupanelcustom.CData[Mod]:SetMax( 200 )
				acfmenupanelcustom.CData[Mod]:SetDecimals( 0 )
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

function ENT:Initialize()
	--input
	self.UsableNos = 1
	
	--Timer setup
	self.StopNos = 0
	self.AllowNos = 0
	
	--think
	self.Legal = true
	self.CanUpdate = true
	self.LegalThink = 0
	self.LastActive = 0
	self.Master = {}
	
	self.Inputs = Wire_CreateInputs( self, { "Active" } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "TqAdd", "Active", "Usable" }, { "NORMAL", "NORMAL", "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Nos"
end  

function MakeACF_Nos(Owner, Pos, Angle, Id, Data1)

	if not Owner:CheckLimit("_acf_extra") then return false end
	
	local Nos = ents.Create("acf_nos")
	if not IsValid( Nos ) then return false end
	
	local EID
	local List = list.Get("ACFCUSTOMEnts")
	if List.MobilityCustom[Id] then EID = Id else EID = "NosBottle" end
	local Lookup = List.MobilityCustom[EID]
	
	Nos:SetAngles(Angle)
	Nos:SetPos(Pos)
	Nos:Spawn()

	Nos:SetPlayer(Owner)
	Nos.Owner = Owner
	Nos.Id = EID
	Nos.Model = Lookup.model
	Nos.Weight = Lookup.weight
	Nos.SoundPath = Lookup.sound
	Nos.RPMAdd = Lookup.rpmadd
	Nos.ModTable = Lookup.modtable
		Nos.ModTable[1] = Data1
		Nos.TorqueAdd2 = Data1
		
	Nos.TorqueAdd = 0
	Nos.UsableNos = 1
	--Getting Time
	Nos.SwitchTime = Nos.TorqueAdd2 / 1.6
	Nos.BoostTime = 10
	
	Nos.KickRpmNumber = 0
				
	Nos:SetModel( Nos.Model )

	--Color/Material
	Nos:SetColor( Color( 0, 0, 255, 255 ) )
	Nos:SetMaterial( "models/debug/debugwhite" )

	Nos:PhysicsInit( SOLID_VPHYSICS )      	
	Nos:SetMoveType( MOVETYPE_VPHYSICS )     	
	Nos:SetSolid( SOLID_VPHYSICS )

	local phys = Nos:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Nos.Weight ) 
	end
	
	Owner:AddCount("_acf_nos", Nos)
	Owner:AddCleanup( "acfmenu", Nos )
	
	--send Wire Outputs
	Wire_TriggerOutput(Nos.Entity, "TqAdd", Nos.TorqueAdd)
	Wire_TriggerOutput(Nos.Entity, "Usable", Nos.UsableNos)
	Wire_TriggerOutput(Nos.Entity, "Active", Nos.ActiveChips2)
	
	Nos:SetNetworkedString( "WireName", Lookup.name )
	Nos:UpdateOverlayText()
		
	return Nos
end
list.Set( "ACFCvars", "acf_nos" , {"id", "data1"} )
duplicator.RegisterEntityClass("acf_nos", MakeACF_Nos, "Pos", "Angle", "Id", "TorqueAdd2")

function ENT:Update( ArgsTable )
	if self.ActiveChips then
		return false, "Please turn off the nos bottle before updating it"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that nos bottle!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFCUSTOMEnts").MobilityCustom[Id]
	
	if Lookup.model ~= self.Model then
		return false, "The new Nos bottle must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
		self.Weight = Lookup.weight
		self.SoundPath = Lookup.sound
		self.RPMAdd = Lookup.rpmadd
		self.TorqueAdd = 0
		self.UsableNos = 1
		self.KickRpmNumber = 0
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.TorqueAdd2 = ArgsTable[5]
	
	--Getting Time
	self.SwitchTime = self.TorqueAdd2
	self.BoostTime = 10
	
	--send Wire Outputs
	Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd)
	Wire_TriggerOutput(self, "Usable", self.UsableNos)
	Wire_TriggerOutput(self, "Active", self.ActiveChips2)
	
	self:SetNetworkedString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	
	return true, "Nos updated successfully!"
end

function ENT:UpdateOverlayText()
	
	local text = "Torque Add: " .. math.Round(self.TorqueAdd2,0) .. "Tq\n"
	text = text .. "Usable: " .. self.UsableNos .. "\n"
	text = text .. "Weight: " .. self.Weight .. "Kg"
	
	self:SetOverlayText( text )
	
end

function ENT:TriggerInput( iname , value )
	if (iname == "Active") then
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
			self.TorqueAdd = 0		--Stop giving Torque
			--Stop sound
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			--Send Wire Outputs
			Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd)
			Wire_TriggerOutput(self, "Active", self.ActiveChips2)
		end
		--Reactive Button
		if self.AllowNos < CurTime() and self.UsableNos == 0 then
			self.UsableNos = 1 --usable
			--send wire
			Wire_TriggerOutput(self, "Usable", self.UsableNos)
			self:UpdateOverlayText()
		end
	end
	
	
	self:NextThink(Time+1)
	return true
	
end

--Timer
function ENT:PowerUp(value)
	self.ActiveChips2 = 1	--Nos are active
	self.UsableNos = 0 		--Unusable
	self.TorqueAdd = self.TorqueAdd2	--Get Torque
	--Send Wire Outputs
	Wire_TriggerOutput(self, "TqAdd", self.TorqueAdd)
	Wire_TriggerOutput(self, "Usable", self.UsableNos)
	Wire_TriggerOutput(self, "Active", self.ActiveChips2)
	self:UpdateOverlayText()
	
	self.StopNos = CurTime() + self.BoostTime
	self.AllowNos = CurTime() + self.SwitchTime
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

