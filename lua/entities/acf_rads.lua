AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Rads"
ENT.WireDebugName = "ACF Rads"

if CLIENT then
	
	function ACFRadsGUICreate( Table )
		
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
		acfmenupanel:CPanelText("Weight", "Weight : "..Table.weight)
		
		/*for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
			if ID == 1 then
				ACF_RadsSliders(ID, Value)
			end
		end*/
		
		acfmenupanel.CustomDisplay:PerformLayout()
		
	end

	/*function ACF_RadsSliders(ID, Value)
		--loading colors
		local Redcolor = 0
		local Greencolor = 0
		local Bluecolor = 200
		if file.Exists("acf/menucolor.txt", "DATA") then
			local MenuColor = file.Read("acf/menucolor.txt")
			local MenuColorTable = {}
			for w in string.gmatch(MenuColor, "([^,]+)") do
				table.insert(MenuColorTable, w)
			end
			Redcolor = tonumber(MenuColorTable[1])
			Greencolor = tonumber(MenuColorTable[2])
			Bluecolor = tonumber(MenuColorTable[3])
		end
		--loading values
		local RadsSize = Value
		local RadsWeight = math.Round(RadsSize*30,1)
		RunConsoleCommand( "acfmenu_data1", RadsSize )
		RunConsoleCommand( "acfmenu_data2", RadsWeight )
		acfmenupanel.ModData["V3_Rads"]["ModTable"][2] = RadsWeight
		
		
		SliderWide = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
		SliderWide:SetText( "Radiator Size" )
		SliderWide.Label:SizeToContents()
		SliderWide:SetMin( 0.2 )
		SliderWide:SetMax( 2 )
		SliderWide:SetDecimals( 2 )
		SliderWide:SetValue(RadsSize)
		SliderWide:SetDark( true )
		SliderWide.OnValueChanged = function( slider, val )
			acfmenupanel.ModData["V3_Rads"]["ModTable"][1] = val
			RunConsoleCommand( "acfmenu_data1", val )
			--Reset Weight
			RadsSize = val
			RadsWeight = math.Round(RadsSize*30,1)
			WeightText:SetText("Weight : "..RadsWeight.." Kg")
			RunConsoleCommand( "acfmenu_data2", RadsWeight )
			acfmenupanel.ModData["V3_Rads"]["ModTable"][2] = RadsWeight
		end
		acfmenupanel.CustomDisplay:AddItem( SliderWide )
		
		WeightText = vgui.Create( "DLabel", acfmenupanel.CustomDisplay )
		WeightText:SetText("Weight : "..RadsWeight.." Kg")
		WeightText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		acfmenupanel.CustomDisplay:AddItem(WeightText)

	end*/
	
	return
	
end

function ENT:Initialize()

	self.EngineLink = {}
	self.IsMaster = true
	self.CanUpdate = true
	self.Legal = true
	self.LastActive = 0
	
	self.LinkedEng = 0	--set linked
	self.TempRpmHighPercent = 0	--set the rpm fast increaser
	self.Temp = 0	--current temp
	self.TempEnd = 88 --while finished heating
	self.TempMax = 112 --while overheat
	self.TempBlow = 125 --Auto Blow overheat
	
	self.HeatSpeed = 25 --Set the Heat Speed
	self.HealthSpeed = 5 --Set the Health Descreaser Speed
	
	self.Inputs = Wire_CreateInputs( self, { } )
	self.Outputs = WireLib.CreateSpecialOutputs( self, {"Temperature", "Health"}, {"NORMAL", "NORMAL", "NORMAL"} )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Rads"

end 

--function MakeACF_Rads(Owner, Pos, Angle, Id, Data1, Data2)
function MakeACF_Rads(Owner, Pos, Angle, Id)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Rads = ents.Create("acf_rads")
	if not IsValid( Rads ) then return false end
	
	local EID
	local List = list.Get("ACFEnts")
	if List.Mobility[Id] then EID = Id else EID = "V3_Rads" end
	local Lookup = List.Mobility[EID]
	
	Rads:SetAngles(Angle)
	Rads:SetPos(Pos)
	Rads:Spawn()

	Rads:SetPlayer(Owner)
	Rads.Owner = Owner
	Rads.Id = EID
	Rads.Model = Lookup.model
	
	/*Rads.ModTable = Lookup.modtable
		Rads.ModTable[1] = Data1
		Rads.ModTable[2] = Data2
		--Set All Mods
		Rads.Mods1 = Data1	--size
		Rads.Mods2 = Data2	--weight
	--Set Mods Values
	Rads.SizeVal = math.Round(tonumber(Rads.Mods1),1)
	Rads.Weight = math.Round(tonumber(Rads.Mods2),0)*/
	
	Rads.Weight = Lookup.weight
	--Set Radiator Values
	Rads.HealthVal = 100 --Health
	
	Rads:SetModel( Rads.Model )
	--Rads:SetModelScale( Rads:GetModelScale()*Rads.SizeVal, 0)

	Rads:PhysicsInit( SOLID_VPHYSICS )      	
	Rads:SetMoveType( MOVETYPE_VPHYSICS )     	
	Rads:SetSolid( SOLID_VPHYSICS )

	local phys = Rads:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Rads.Weight ) 
	end
	
	Owner:AddCount("_acf_rads", Rads)
	Owner:AddCleanup( "acfmenu", Rads )
	
	Rads:SetNetworkedString( "WireName", Lookup.name )
	Rads:UpdateOverlayText()
		
	return Rads
end
--list.Set( "ACFCvars", "acf_rads" , {"id", "data1", "data2"} )
--duplicator.RegisterEntityClass("acf_rads", MakeACF_Rads, "Pos", "Angle", "Id", "Mods1", "Mods2")
list.Set( "ACFCvars", "acf_rads" , {"id"} )
duplicator.RegisterEntityClass("acf_rads", MakeACF_Rads, "Pos", "Angle", "Id")

function ENT:Update( ArgsTable )
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine radiator!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local Lookup = list.Get("ACFEnts").Mobility[Id]
	
	if Lookup.model ~= self.Model then
		return false, "The new Engine Radiator must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
	end
	
	/*self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
	--Set Mods
	self.Mods1 = ArgsTable[5]	--Size
	self.Mods2 = ArgsTable[6]	--Weight
	--Set Mods Values
	self.SizeVal = math.Round(tonumber(self.Mods1),1)
	self.Weight = math.Round(tonumber(self.Mods2),0)*/
	
	self.Weight = Lookup.weight
	--Set Radiator Values
	self.HealthVal = 100 --Health
	--Reset Size
	--self:SetModelScale( self:GetModelScale()*self.SizeVal, 0)
	
	local phys = self:GetPhysicsObject()    
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end
	
	self:SetNetworkedString( "WireName", Lookup.name )
	self:UpdateOverlayText()
	
	return true, "Radiator updated successfully!"
end

function ENT:UpdateOverlayText()

	local text = ""
	if self.HealthVal <= 0 then
		text = text .. "ENGINE BLOWED\n"
	end
	text = text .. "Temperature: " .. math.Round(self.Temp,1).."C\n"
	text = text .. "Health: " .. math.Round(self.HealthVal,0) .. "%\n"
	text = text .. "Weight: " .. self.Weight .. "Kg"
	
	self:SetOverlayText( text )
	
	--Also update wire outputs
	Wire_TriggerOutput(self, "Temperature", math.Round(self.Temp,1))
	Wire_TriggerOutput(self, "Health", math.Round(self.HealthVal,0))
end

function ENT:Think()
	local Time = CurTime()
	
	if self.LastActive + 2 > Time then
		self:CheckRopes()
	end
	--Get Linked
	if self.LinkedEng > 0 then self:CalcTemp()
	else self:ResetValues() end
	
	self.Legal = self:CheckLegal()
	self:NextThink( Time + 0.1 )
	return true
end

function ENT:CheckLegal()
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Weight then return false end
	-- if it's not parented we're fine
	if not IsValid( self:GetParent() ) then return true end
	-- but not if it's parented to a parented prop
	if IsValid( self:GetParent():GetParent() ) then return false end
	-- parenting is only legal if it's also welded
	for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
		if v.Ent1 == self:GetParent() or v.Ent2 == self:GetParent() then return true end
	end
	
	return false
end

--RESET VALUES UNLINKED
function ENT:ResetValues()
	self.Temp = 0	--current temp
	self.HealthVal = 100 --Health
	self.LinkedEng = 0 --set unlinked
	self.TempRpmHighPercent = 0 --set rpm fast increaser
	self:UpdateOverlayText()
end

--THE RADIATOR CALCUL FUNCTION
function ENT:CalcTemp()
	for Key, Engine in pairs(self.EngineLink) do
		if IsValid( Engine ) then
			--Get The RPM Teamperature fast increaser
			self.TempRpmHighPercent = Engine.LimitRPM * 0.9 --Getting 90% of the Rpm Band
			if self.TempRpmHighPercent <= Engine.PeakMaxRPM then
				self.TempRpmHigh = Engine.PeakMaxRPM
			end
			--set values
			local HealthDecreaser = self.HealthSpeed/10
			local increaser = 0
			if Engine.FlyRPM <= self.TempRpmHigh then
				increaser = (self.HeatSpeed/100)/1.5
			elseif Engine.FlyRPM > self.TempRpmHigh then
				increaser = self.HeatSpeed/100
			end
			--Set Temperature
			if Engine.Active2 then	--Get the engine running
				--increase
				if self.Temp <= self.TempEnd/2 then	--heating bit faster, too cold
					self.Temp = self.Temp+(increaser*1.5)
				elseif self.Temp > self.TempEnd/2 and self.Temp < self.TempEnd-1 then --heating regular
					self.Temp = self.Temp+increaser
				--Decrease while safe
				elseif self.Temp > (self.TempEnd + 1) and Engine.FlyRPM <= self.TempRpmHigh then
					self.Temp = self.Temp-increaser
				--Increase while not safe
				elseif Engine.FlyRPM > self.TempRpmHigh and self.Temp > self.TempEnd-1 then
					self.Temp = self.Temp+increaser
				end
					
				-------------------------------------	
				--Apply Damage if at Dangerous Temp--
				if self.Temp > self.TempMax and self.Temp < self.TempBlow then
					self.HealthVal = self.HealthVal-HealthDecreaser
				--AUTO Blowing Up
				elseif self.Temp >= self.TempBlow then
					self.HealthVal = 0
					self.Temp = self.TempBlow
					Engine:SetBlow()
				end
				--Apply Damage at Dangerous RPM without autoclutch
				if Engine.DisableAutoClutch == 1 and Engine.FlyRPM > Engine.LimitRPM then
					self.HealthVal = self.HealthVal-HealthDecreaser
				end
				--Blowing up
				if self.HealthVal <= 0 then
					self.HealthVal = 0
					Engine:SetBlow()	--Set the Engine Blowed
				else
					Engine:SetEngineHealth(self.HealthVal) --Set the Engine Health
				end
			else	--Decreasing its not running
				if self.Temp > 0 then	--heating bit faster, too cold
					self.Temp = self.Temp-increaser
				elseif self.Temp <= 0 then
					self.Temp = 0
				end
			end
			--Reset GUI
			self:UpdateOverlayText()
		else continue end
	end
end

function ENT:Link( Target )
	--Allowable Target
	if not IsValid( Target ) or not table.HasValue( { "acf_engine", "acf_enginemaker" }, Target:GetClass() ) then
		return false, "Can only link to engines!"
	end
	
	for Key,Value in pairs(self.EngineLink) do
		if Value == Target then 
			return false, "It's already linked to this radiator!"
		end
	end
	
	if self:GetPos():Distance( Target:GetPos() ) > 512 then
		return false, "The engine is too far away."
	end
	
	table.insert( self.EngineLink, Target )
	table.insert( Target.Master, self )
	
	self.LinkedEng = 1
	
	return true, "Link successful!"
end

function ENT:Unlink( Target )

	if Target:GetClass() == "acf_engine" or Target:GetClass() == "acf_enginemaker" then
		for Key, Value in pairs( self.EngineLink ) do
			if Value == Target then
				self:ResetValues()
				table.remove( self.EngineLink, Key )
				return true, "Unlink successful!"
			end
		end
		
		return false, "That's not linked to this radiator!"
	end
	
	return false, "That's not linked to this radiator!"
	
end

function ENT:PreEntityCopy()
	--extra link saving
	local rads_info = {}
	local rads_entids = {}
	for Key, Value in pairs(self.EngineLink) do	--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.EngineLink, Value)
		end
	end
	for Key, Value in pairs(self.EngineLink) do	--Then save it
		table.insert(rads_entids, Value:EntIndex())
	end
	
	rads_info.entities = rads_entids
	if rads_info.entities then
		duplicator.StoreEntityModifier( self, "EngineLink", rads_info )
	end
	//Wire dupe info
	self.BaseClass.PreEntityCopy( self )
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )
	--Extra link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.EngineLink) and (Ent.EntityMods.EngineLink.entities) then
		local EngineLink = Ent.EntityMods.EngineLink
		if EngineLink.entities and table.Count(EngineLink.entities) > 0 then
			for _,ID in pairs(EngineLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then
					self:Link( Linked )
					self.LinkedEng = 1
				end
			end
		end
		Ent.EntityMods.EngineLink = nil
	end
	//Wire dupe info
	self.BaseClass.PostEntityPaste( self, Player, Ent, CreatedEntities )
end

function ENT:OnRemove()

end

