AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Turbo"
ENT.WireDebugName = "ACF Turbo"

if CLIENT then
	
	function ACFTurboGUICreate( Table )
		
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
				ACF_TurboSlider(1, Value, Table.id)
			elseif ID == 2 then
				ACF_TurboBOV(2, Value, Table.id)
			end
		end
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		
	end

	function ACF_TurboSlider(Mod, Value, ID)
	
		acfmenupanelcustom:CPanelText("Spool", "        <----   Spool Faster  /  Boost Bigger  ---->")

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
	
	function ACF_TurboBOV(Mod, Value, ID)
		RunConsoleCommand( "acfcustom_data"..Mod, Value )
		acfmenupanelcustom.ModData[ID]["ModTable"][Mod] = Value
		
		acfmenupanelcustom:CPanelText("BovText", "\n\nBOV(Blow Off Valve) SoundPath :")
		
		BOVTextEntry = vgui.Create("DTextEntry")
		BOVTextEntry:SetWide(100)
		BOVTextEntry:SetTall(30)
		BOVTextEntry:SetText(Value)
		BOVTextEntry.OnTextChanged = function()
			local BOVText = BOVTextEntry:GetValue()
			RunConsoleCommand( "acfcustom_data"..Mod, BOVText )
			acfmenupanelcustom.ModData[ID]["ModTable"][Mod] = BOVText
		end
		acfmenupanelcustom.CustomDisplay:AddItem( BOVTextEntry )
		
		acfmenupanelcustom:CPanelText("BovText2", "**Put nothing for No BOV sound**")
	
	end
	
	return
end

function ENT:Initialize()

	--Persist Values
	self.Boost = 0
	self.BoostRate = 0
	self.BoostRpmStart = 0
	self.BoostMax = 1
	self.TorqueAdd = 0
	self.TorqueAddMax = 1
	self.RPMAdd = 1000
	self.RPM = 0
	self.Throttle = 0
	--self.RPMThink = 0
	
	self.GetRpm = true

	--think
	self.Master = {}
	self.CanUpdate = true
	self.Legal = true
	self.LastActive = 0
	self.LegalThink = 0
	self.TurboThink = 0
	
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Turbo"

end 

function MakeACF_Turbo(Owner, Pos, Angle, Id, Data1, Data2)

	if not Owner:CheckLimit("_acf_extra") then return false end
	
	local Turbo = ents.Create("acf_turbo")
	if not IsValid( Turbo ) then return false end
	
	local EID
	local List = list.Get("ACFCUSTOMEnts")
	if List.MobilityCustom[Id] then EID = Id else EID = "V1_Turbo" end
	local Lookup = List.MobilityCustom[EID]
	
	Turbo:SetAngles(Angle)
	Turbo:SetPos(Pos)
	Turbo:Spawn()

	Turbo:SetPlayer(Owner)
	Turbo.Owner = Owner
	Turbo.Id = EID
	Turbo.Model = Lookup.model
	Turbo.SoundPath = Lookup.sound
	Turbo.Weight = 30 		--this is a basic weight value
	Turbo.ModTable = Lookup.modtable
		Turbo.ModTable[1] = Data1
		Turbo.ModTable[2] = Data2
		--Set All Mods
		Turbo.Mods1 = Data1	--Slider
		Turbo.Mods2 = Data2	--BOV Using
	
	--Turbo Settings
	Turbo.SliderVal = tonumber(Turbo.Mods1)
	Turbo.BOVSound = tostring(Turbo.Mods2)
	
	--Creating Wire Outputs
	local Outputs = {"Boost"}
	local OutputsTypes = {"NORMAL"}
	Turbo.Outputs = WireLib.CreateSpecialOutputs( Turbo, Outputs, OutputsTypes )
	
	Turbo:SetModel( Turbo.Model )	

	Turbo:PhysicsInit( SOLID_VPHYSICS )      	
	Turbo:SetMoveType( MOVETYPE_VPHYSICS )     	
	Turbo:SetSolid( SOLID_VPHYSICS )

	local phys = Turbo:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Turbo.Weight ) 
	end
	
	Owner:AddCount("_acf_turbo", Turbo)
	Owner:AddCleanup( "acfmenu", Turbo )
	
	Turbo:SetNWString( "WireName", Lookup.name )
	Turbo:UpdateOverlayText()
	Turbo:SetWireOutputs()
		
	return Turbo
end
list.Set( "ACFCvars", "acf_turbo" , {"id", "data1", "data2"} )
duplicator.RegisterEntityClass("acf_turbo", MakeACF_Turbo, "Pos", "Angle", "Id", "Mods1", "Mods2")

function ENT:Update( ArgsTable )
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine chip!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the turbo ID
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
	self.ModTable[2] = ArgsTable[6]
	--Set Mods
	self.Mods1 = ArgsTable[5]	--Slider
	self.Mods2 = ArgsTable[6]	--BOV Using
	
	--Turbo Settings
	self.SliderVal = tonumber(self.Mods1)
	self.BOVSound = tostring(self.Mods2)
	
	--Creating Wire Outputs
	local Outputs = {"Boost"}
	local OutputsTypes = {"NORMAL"}
	self.Outputs = WireLib.CreateSpecialOutputs( self, Outputs, OutputsTypes )
	
	self:SetNWString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	self:SetWireOutputs()
	
	return true, "Turbo updated successfully!"
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
	if self.BOVSound == "" then
		text = text .. "Weight: "..self.Weight.."Kg"
	else
		text = text .. "Weight: "..self.Weight.."Kg\n"
		text = text .. "Using BOV"
	end
	
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
	
	if self.TurboThink < Time then
		/*if self.RPM - self.RPMThink <= -1000 then
			--Delete and Create the BOV Sound
			if self.BOVSound != "" then
				self.SoundBov = CreateSound(self, self.BOVSound)
				self.SoundBov:PlayEx((self.Boost/self.BoostMax),100)
			end
			self.BoostRate = 0
			self.Boost = 0
		else*/
			--Turbo Boost Increasing
			if self.Throttle >= 0.5 then
				--increase full throttle
				if self.RPM >= self.BoostRpmStart then
					self.BoostRate = self.Boost+(((self.Boost/4)+0.1)*self.Throttle)	--boost rate
					
					if self.Boost < self.BoostMax then
						self.Boost = self.BoostRate
					else
						self.Boost = self.BoostMax
					end
				end
				--Decrease under full throttle
				if self.RPM <= self.BoostRpmStart-((self.BoostRpmStart*15)/100) then
					self.BoostRate = self.Boost-(((self.Boost/8)-0.1)*self.Throttle)	--boost rate
					
					if self.Boost > 0 then
						self.Boost = self.BoostRate
					elseif self.Boost <= 0 then
						self.Boost = 0
					end
				end
			--Turbo Boost Decreasing
			elseif self.Throttle > 0 and self.Throttle < 0.5 then
				self.BoostRate = self.Boost-(((self.Boost/8)-0.1)*self.Throttle)		--boost rate
				
				if self.Boost > 0 then
					self.Boost = self.BoostRate
				elseif self.Boost <= 0 then
					self.Boost = 0
				end
			--Turbo Boost Stop
			else
				--Delete and Create the BOV Sound
				if self.BOVSound != "" then
					self.SoundBov = CreateSound(self, self.BOVSound)
					self.SoundBov:PlayEx((self.Boost/self.BoostMax),100)
				end
				self.BoostRate = 0
				self.Boost = 0
			end
		--end
		--Add Torque
		self.TorqueAdd = (((self.Boost/self.BoostMax)*100)*self.TorqueAddMax)/100
		
		--Create Turbo Noise Sound
		if not self.Sound then
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.1,10)
		end
		--Change the Turbo Noise Pitch
		if self.Sound then
			self.Sound:ChangePitch(math.min(((((self.Boost/self.BoostMax)*100)*255)/100), 255), 0)
			self.Sound:ChangeVolume(self.Boost/self.BoostMax, 0)
		end
		
		--Set Overlay & Wire Output
		self:UpdateOverlayText()
		self:SetWireOutputs()
		
		--self.RPMThink = self.RPM
		
		self.TurboThink = Time + 0.1
	end
	
	
	self:NextThink(Time+0.1)
	return true
	
end

--Get RPM for Turbo
function ENT:GetRPM(IntputRPM, LimitRpm, EngWeight, EngThrottle, Class, Torque, IdleRpm)
	--Reset the turbo Weight
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
		--self.BoostRpmStart = (LimitRpm*((self.SliderVal*30)+40))/100	--will vary between 40-70% of the limit rpm range on gazoline
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*130)+150))/100)	--will vary between 150-280% of the idle rpm range on gazoline
	elseif Class == "GenericDiesel" or Class == "Wankel" then
		--self.BoostRpmStart = (LimitRpm*((self.SliderVal*20)+40))/100	--will vary between 40-60% of the limit rpm range on diesel
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*110)+90))/100)	--will vary between 90-200% of the idle rpm range on diesel
	else
		--self.BoostRpmStart = (LimitRpm*((self.SliderVal*25)+40))/100	--will vary between 40-65% of the limit rpm range on others
		self.BoostRpmStart = IdleRpm+((IdleRpm*((self.SliderVal*120)+120))/100)	--will vary between 120-240% of the idle rpm range on others
	end
	self.TorqueAddMax = (Torque*((self.SliderVal*35)+50))/100		--will add between 50-85% of the max engine torque
	--Set Boost Max (Minimum 7psi)
	if self.TorqueAddMax/10 > 7 then self.BoostMax = self.TorqueAddMax/10
	else self.BoostMax = 7 end
	self.RPM = IntputRPM
	self.Throttle = EngThrottle
	
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

