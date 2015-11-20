AddCSLuaFile()

DEFINE_BASECLASS( "base_wire_entity" )

ENT.PrintName = "ACF Rads"
ENT.WireDebugName = "ACF Rads"

if CLIENT then
	
	local ACF_ExtraRadsInfoWhileSeated = CreateClientConVar("ACF_ExtraRadsInfoWhileSeated", 0, true, false)
	
	-- copied from base_wire_entity: DoNormalDraw's notip arg isn't accessible from ENT:Draw defined there.
	function ENT:Draw()
	
		local lply = LocalPlayer()
		local hideBubble = not GetConVar("ACF_ExtraRadsInfoWhileSeated"):GetBool() and IsValid(lply) and lply:InVehicle()
		
		self.BaseClass.DoNormalDraw(self, false, hideBubble)
		Wire_Render(self)
		
		if self.GetBeamLength and (not self.GetShowBeam or self:GetShowBeam()) then 
			-- Every SENT that has GetBeamLength should draw a tracer. Some of them have the GetShowBeam boolean
			Wire_DrawTracerBeam( self, 1, self.GetBeamHighlight and self:GetBeamHighlight() or false ) 
		end
		
	end
	
	function ACFRadsGUICreate( Table )
		
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
			acfmenupanelcustom.CData.DisplayModel:SetFOV( 20 )
			acfmenupanelcustom.CData.DisplayModel:SetSize(acfmenupanelcustom:GetWide(),acfmenupanelcustom:GetWide())
			acfmenupanelcustom.CData.DisplayModel.LayoutEntity = function( panel, entity ) end
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom.CData.DisplayModel )
		
		acfmenupanelcustom:CPanelText("Desc", "Desc : "..Table.desc)
		acfmenupanelcustom:CPanelText("Weight", "Weight : "..Table.weight)
		
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		
	end
	
	return
	
end

function ENT:Initialize()

	self.Master = {}
	self.CanUpdate = true
	self.Legal = true
	self.LastActive = 0
	
	self.GetRpm = true --This extra need to get the Rpm
	
	self.LinkedEng = 0	--set linked
	self.TempRpmHighPercent = 0	--set the rpm fast increaser
	self.Temp = 0	--current temp
	self.TempEnd = 88 --while finished heating
	self.TempMax = 112 --while overheat
	self.TempBlow = 125 --Auto Blow overheat
	
	self.HeatSpeed = 5 --Set the Heat Speed
	self.HealthSpeed = 0.1 --Set the Health Descreaser Speed
	
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
	local List = list.Get("ACFCUSTOMEnts")
	if List.MobilityCustom[Id] then EID = Id else EID = "V3_Rads" end
	local Lookup = List.MobilityCustom[EID]
	
	Rads:SetAngles(Angle)
	Rads:SetPos(Pos)
	Rads:Spawn()

	Rads:SetPlayer(Owner)
	Rads.Owner = Owner
	Rads.Id = EID
	Rads.Model = Lookup.model
	
	Rads.Weight = Lookup.weight
	--Set Radiator Values
	Rads.HealthVal = 100 --Health
	
	Rads:SetModel( Rads.Model )

	Rads:PhysicsInit( SOLID_VPHYSICS )      	
	Rads:SetMoveType( MOVETYPE_VPHYSICS )     	
	Rads:SetSolid( SOLID_VPHYSICS )

	local phys = Rads:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Rads.Weight ) 
	end
	
	Owner:AddCount("_acf_rads", Rads)
	Owner:AddCleanup( "acfcustom", Rads )
	
	Rads:SetNWString( "WireName", Lookup.name )
	Rads:UpdateOverlayText()
		
	return Rads
end
list.Set( "ACFCvars", "acf_rads" , {"id"} )
duplicator.RegisterEntityClass("acf_rads", MakeACF_Rads, "Pos", "Angle", "Id")

function ENT:Update( ArgsTable )
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine radiator!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the rad ID
	local Lookup = list.Get("ACFCUSTOMEnts").MobilityCustom[Id]
	
	if Lookup.model ~= self.Model then
		return false, "The new Engine Radiator must have the same model!"
	end
		
	if self.Id != Id then
		self.Id = Id
		self.Model = Lookup.model
	end
	
	self.Weight = Lookup.weight
	--Set Radiator Values
	self.HealthVal = 100 --Health
	
	local phys = self:GetPhysicsObject()    
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end
	
	self:SetNWString( "WireName", Lookup.name )
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
	
	self.Legal = self:CheckLegal()
	self:NextThink( Time + 0.1 )
	return true
end

function ENT:CheckLegal()
	--make sure it's not invisible to traces
	if not self:IsSolid() then return false end
	-- make sure weight is not below stock
	if self:GetPhysicsObject():GetMass() < self.Weight then return false end
	local rootparent = self:GetParent()
	-- if it's not parented we're fine
	if not IsValid( rootparent ) then return true end
	--find the root parent
	local depth = 0
	while rootparent:GetParent():IsValid() and depth<5 do
		depth = depth + 1
		rootparent = rootparent:GetParent()
	end
	--if there's still more parents, it's not legal
	if rootparent:GetParent():IsValid() then return false end
	--make sure it's welded to root parent
	for k, v in pairs( constraint.FindConstraints( self, "Weld" ) ) do
		if v.Ent1 == rootparent or v.Ent2 == rootparent then return true end
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
function ENT:GetRPM(IntputRPM, LimitRPM, Active)
	--Get The RPM Teamperature fast increaser
	self.TempRpmHighPercent = LimitRPM * 0.9 --Getting 90% of the Rpm Band
	--set values
	local HealthDecreaser = self.HealthSpeed
	local increaser = 0
	if IntputRPM <= self.TempRpmHighPercent then
		increaser = (self.HeatSpeed/100)/1.5
	elseif IntputRPM > self.TempRpmHighPercent then
		increaser = self.HeatSpeed/100
	end
	--Set Temperature
	if Active then	--Get the engine running
		--increase
		if self.Temp <= self.TempEnd/2 then	--heating bit faster, too cold
			self.Temp = self.Temp+(increaser*1.5)
		elseif self.Temp > self.TempEnd/2 and self.Temp < self.TempEnd-1 then --heating regular
			self.Temp = self.Temp+increaser
		--Decrease while safe
		elseif self.Temp > (self.TempEnd + 1) and IntputRPM <= self.TempRpmHighPercent then
			self.Temp = self.Temp-increaser
		--Increase while not safe
		elseif IntputRPM > self.TempRpmHighPercent and self.Temp > self.TempEnd-1 then
			self.Temp = self.Temp+increaser
		end
		
		--Apply Damage if at Dangerous Temp--
		if self.Temp > self.TempMax and self.Temp < self.TempBlow then
			self.HealthVal = self.HealthVal-HealthDecreaser
		--Blowing Up By Temp
		elseif self.Temp >= self.TempBlow then
			self.HealthVal = 0
			self.Temp = self.TempBlow
		end
		--Blowing up By Health
		if self.HealthVal <= 0 then
			self.HealthVal = 0
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

end

