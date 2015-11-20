AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Supercharger"
ENT.WireDebugName = "ACF Supercharger"

if CLIENT then
	
	local ACF_ExtraSuperChargersInfoWhileSeated = CreateClientConVar("ACF_ExtraSuperChargersInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
	
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACF_ExtraSuperChargersInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
		
	end
	
	function ACFSuperchargerGUICreate( Table )
		
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
			acfmenupanelcustom.CData.DisplayModel:SetCamPos( Vector( 250, 325, 250 ) )
			acfmenupanelcustom.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
			acfmenupanelcustom.CData.DisplayModel:SetFOV( 3 )
			acfmenupanelcustom.CData.DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
			acfmenupanelcustom.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData.DisplayModel )
		
		acfmenupanelcustom:CPanelText("Desc", "Desc : "..Table.desc.."\n\n")
		
		for ID,Value in pairs(acfmenupanelcustom.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_SuperchargerSlider(1, Value, Table.id)
			end
		end
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		
	end

	function ACF_SuperchargerSlider(Mod, Value, ID)
	
		acfmenupanelcustom:CPanelText("Pulley", "        <----   Smaller // Pulley Size // Bigger  ---->")

		if Mod and not acfmenupanelcustom.CData[Mod] then	
			acfmenupanelcustom.CData[Mod] = vgui.Create( "DNumSlider", acfmenupanelcustom.CustomDisplay )
				acfmenupanelcustom.CData[Mod]:SetWide(100)
				acfmenupanelcustom.CData[Mod]:SetMin(0.01)
				acfmenupanelcustom.CData[Mod]:SetMax(1)
				acfmenupanelcustom.CData[Mod]:SetDecimals(2)
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

	--Persist Values
	self.Boost = 0
	self.BoostRpmStart = 1
	self.BoostMax = 1
	self.TorqueAdd = 0
	self.TorqueAddMax = 1
	self.RPMAdd = 1000
	self.RPM = 0
	self.LimitRPM = 2
	
	self.GetRpm = true

	--think
	self.Master = {}
	self.CanUpdate = true
	self.Legal = true
	self.LastActive = 0
	self.LegalThink = 0
	self.SuperchargerThink = 0
	
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Supercharger"

end 

function MakeACF_Supercharger(Owner, Pos, Angle, Id, Data1)

	if not Owner:CheckLimit("_acf_extra") then return false end
	
	local Supercharger = ents.Create("acf_supercharger")
	if not IsValid( Supercharger ) then return false end
	
	local EID
	local List = list.Get("ACFCUSTOMEnts")
	if List.MobilityCustom[Id] then EID = Id else EID = "V1_Supercharger" end
	local Lookup = List.MobilityCustom[EID]
	
	Supercharger:SetAngles(Angle)
	Supercharger:SetPos(Pos)
	Supercharger:Spawn()

	Supercharger:SetPlayer(Owner)
	Supercharger.Owner = Owner
	Supercharger.Id = EID
	Supercharger.Model = Lookup.model
	Supercharger.SoundPath = Lookup.sound
	Supercharger.Weight = 30 		--this is a basic weight value
	Supercharger.ModTable = Lookup.modtable
		Supercharger.ModTable[1] = Data1
		--Set All Mods
		Supercharger.Mods1 = Data1	--Slider
	
	--Supercharger Settings
	Supercharger.SliderVal = tonumber(Supercharger.Mods1)
	
	--Creating Wire Outputs
	local Outputs = {"Boost"}
	local OutputsTypes = {"NORMAL"}
	Supercharger.Outputs = WireLib.CreateSpecialOutputs( Supercharger, Outputs, OutputsTypes )
	
	Supercharger:SetModel( Supercharger.Model )	

	Supercharger:PhysicsInit( SOLID_VPHYSICS )      	
	Supercharger:SetMoveType( MOVETYPE_VPHYSICS )     	
	Supercharger:SetSolid( SOLID_VPHYSICS )

	local phys = Supercharger:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Supercharger.Weight ) 
	end
	
	Owner:AddCount("_acf_supercharger", Supercharger)
	Owner:AddCleanup( "acfmenu", Supercharger )
	
	Supercharger:SetNWString( "WireName", Lookup.name )
	Supercharger:UpdateOverlayText()
	Supercharger:SetWireOutputs()
		
	return Supercharger
end
list.Set( "ACFCvars", "acf_supercharger" , {"id", "data1"} )
duplicator.RegisterEntityClass("acf_supercharger", MakeACF_Supercharger, "Pos", "Angle", "Id", "Mods1")

function ENT:Update( ArgsTable )
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine chip!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the supercharger ID
	local Lookup = list.Get("ACFCUSTOMEnts").MobilityCustom[Id]
	
	if Lookup.model ~= self.Model then
		return false, "The new Engine Chip must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
		self.SoundPath = Lookup.sound
		self.Weight = 30	--this is a basic weight value
	end
	
	self.ModTable[1] = ArgsTable[5]
	--Set Mods
	self.Mods1 = ArgsTable[5]	--Slider
	
	--Supercharger Settings
	self.SliderVal = tonumber(self.Mods1)
	
	--Creating Wire Outputs
	local Outputs = {"Boost"}
	local OutputsTypes = {"NORMAL"}
	self.Outputs = WireLib.CreateSpecialOutputs( self, Outputs, OutputsTypes )
	
	self:SetNWString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	self:SetWireOutputs()
	
	return true, "Supercharger updated successfully!"
end
--Set the wire Output
function ENT:SetWireOutputs()
	Wire_TriggerOutput(self, "Boost", math.Round(self.Boost,1))
end
--Set the Overlay Text
function ENT:UpdateOverlayText()
	local text = ""
	text = text .. "Boost: "..math.Round(self.Boost,1).." Psi\n"
	text = text .. "Torque Add: "..math.Round(self.TorqueAdd,0).."Tq\n"
	text = text .. "Weight: "..self.Weight.."Kg"
	
	self:SetOverlayText( text )
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
	
	if self.SuperchargerThink < Time then
		--Supercharger Boosting
		if self.RPM >= self.BoostRpmStart then
			self.Boost = (self.RPM-self.BoostRpmStart)/800
		else
			self.Boost = 0
		end
		self.BoostMax = (self.LimitRPM-self.BoostRpmStart)/800
		
		--Add Torque
		self.TorqueAdd = (((self.Boost/self.BoostMax)*100)*self.TorqueAddMax)/100
		
		--Create Supercharger Noise Sound
		if not self.Sound then
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.1,10)
		end
		--Change the Supercharger Noise Pitch
		if self.Sound then
			self.Sound:ChangePitch(math.min(((((self.Boost/self.BoostMax)*100)*255)/100), 255), 0)
			self.Sound:ChangeVolume(self.Boost/self.BoostMax, 0)
		end
		
		--Set Overlay & Wire Output
		self:UpdateOverlayText()
		self:SetWireOutputs()
		
		self.RPMThink = self.RPM
		
		self.SuperchargerThink = Time + 0.1
	end
	
	
	self:NextThink(Time+0.1)
	return true
	
end

--Get RPM for Supercharger
function ENT:GetRPM(IntputRPM, EngLimitRpm, EngWeight, EngThrottle, Class, Torque, IdleRpm)
	--Reset the supercharger Weight
	if EngWeight/20-(self.SliderVal*10) >= 10 then
		if self.Weight != EngWeight/20-(self.SliderVal*10) then
			self.Weight = EngWeight/20-(self.SliderVal*10)
			local phys = self:GetPhysicsObject()  	
			if IsValid( phys ) then 
				phys:SetMass( self.Weight ) 
			end
		end
	else
		if self.Weight > 10 or self.Weight < 10 then
			self.Weight = 10	--Set the minimum weight
			local phys = self:GetPhysicsObject()  	
			if IsValid( phys ) then 
				phys:SetMass( self.Weight ) 
			end
		end
	end
	--Set Persist Values
	if Class == "GenericPetrol" or Class == "Radial" then
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*130)+70))/100)	--will vary between 70-200% of the idle rpm range on gazoline
	elseif Class == "GenericDiesel" or Class == "Wankel" then
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*110)+50))/100)	--will vary between 50-160% of the idle rpm range on diesel
	else
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*130)+60))/100)	--will vary between 60-190% of the idle rpm range on others
	end
	self.TorqueAddMax = (Torque*((self.SliderVal*35)+40))/100		--will add between 40-75% of the max engine torque
	self.RPM = IntputRPM
	self.LimitRPM = EngLimitRpm
	
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

