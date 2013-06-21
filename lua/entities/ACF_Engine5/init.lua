AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()

	self.Throttle = 0
	self.Active = false
	self.IsMaster = true
	self.GearLink = {}
	self.GearRope = {}

	self.LastCheck = 0
	self.LastThink = 0
	self.MassRatio = 1
	self.Legal = true
	self.CanUpdate = true
	
	--####################
	self.TqAdd = 0
	self.MaxRpmAdd = 0
	self.LimitRpmAdd = 0
	self.FlywheelMass = 0
	self.WeightKg = 0
	self.idle = 0
	self.DisableCut = 0
	self.CutMode = 0
	self.CutValue = 0
	self.CutRpm = 0
	--####################
	
	self.Inputs = Wire_CreateInputs( self, { "Active", "Throttle", "TqAdd", "MaxRpmAdd", "LimitRpmAdd", "FlywheelMass", "Idle", "DisableCut"} )
	self.Outputs = WireLib.CreateSpecialOutputs( self, { "RPM", "Torque", "Power", "Entity" , "Mass" , "Physical Mass" }, { "NORMAL" ,"NORMAL" ,"NORMAL" , "ENTITY" , "NORMAL" , "NORMAL" } )
	Wire_TriggerOutput(self, "Entity", self)
	self.WireDebugName = "ACF Engine5"

end  

function MakeACF_Engine5(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10)

	if not Owner:CheckLimit("_acf_misc") then return false end

	local Engine5 = ents.Create( "acf_engine5" )
	if not IsValid( Engine5 ) then return false end
	
	local List = list.Get("ACFEnts")
	
	Engine5:SetAngles(Angle)
	Engine5:SetPos(Pos)
	Engine5:Spawn()

	Engine5:SetPlayer(Owner)
	Engine5.Owner = Owner
	Engine5.Id = Id
	--##################################################################################
	Engine5.iselec = List["Mobility2"][Id]["iselec"]
	Engine5.elecpower = List["Mobility2"][Id]["elecpower"]
	Engine5.FlywheelOverride = List["Mobility2"][Id]["flywheeloverride"]
	Engine5.IsTrans = List["Mobility2"][Id]["istrans"] -- driveshaft outputs to the side
	
	Engine5.ModTable = List["Mobility2"][Id]["modtable"]
		Engine5.ModTable[1] = Data1
		Engine5.ModTable[2] = Data2
		Engine5.ModTable[3] = Data3
		Engine5.ModTable[4] = Data4
		Engine5.ModTable[5] = Data5
		Engine5.ModTable[6] = Data6
		Engine5.ModTable[7] = Data7
		Engine5.ModTable[8] = Data8
		Engine5.ModTable[9] = Data9
		Engine5.ModTable[10] = Data10
			
			
		Engine5.SoundPath = Data1
		Engine5.Model = Data2
		--##########
		if(tonumber(Data3) >= 1) then
			Engine5.PeakTorque = Data3
		elseif(tonumber(Data3) < 1) then
			Engine5.PeakTorque = 1
		end
		--##########
		if(tonumber(Data4) >= 100) then
			Engine5.IdleRPM = Data4
		elseif(tonumber(Data4) < 100) then
			Engine5.IdleRPM = 100
		end
		--##########
		if(tonumber(Data5) >= 100) then
			Engine5.PeakMinRPM = Data5
		elseif(tonumber(Data5) < 100) then
			Engine5.PeakMinRPM = 100
		end
		--##########
		if(tonumber(Data7) >= 100) then
			Engine5.LimitRPM = Data7
		elseif(tonumber(Data7) < 100) then
			Engine5.LimitRPM = 100
		end
		--##########
		if(Data6 <= Data7 and tonumber(Data6) >= 100 ) then 
			Engine5.PeakMaxRPM = Data6
		elseif(Data6 > Data7 ) then
			Engine5.PeakMaxRPM = Data7
		elseif(tonumber(Data6) < 100) then
			Engine5.PeakMaxRPM = 100
		end
		--##########
		if(tonumber(Data8) >= 0.001) then
			Engine5.FlywheelMass2 = Data8
		elseif(tonumber(Data8) < 0.001) then
			Engine5.FlywheelMass2 = 0.001
		end
		--##########
		if(tonumber(Data9) >= 1) then
			Engine5.Weight = Data9
		elseif(tonumber(Data9) < 1) then
			Engine5.Weight = 1
		end
		--##########
		Engine5.EngineName = Data10
		Engine5.CutValue = Engine5.LimitRPM / 40
		Engine5.CutRpm = Engine5.LimitRPM - 100
			
		Engine5.PeakTorque2 = Data3
		Engine5.PeakTorque3 = Data3
		Engine5.Idling = Data4
		Engine5.PeakMaxRPM2 = Data6
		Engine5.LimitRPM2 = Data7
		Engine5.FlywheelMass3 = Data8
			
		Engine5.Inertia = Engine5.FlywheelMass2*(3.1416)^2
	--##################################################################################
	
	Engine5.FlyRPM = 0
	Engine5:SetModel( Engine5.Model )	
	Engine5.Sound = nil
	Engine5.SoundPitch = 1
	Engine5.RPM = {}

	Engine5:PhysicsInit( SOLID_VPHYSICS )      	
	Engine5:SetMoveType( MOVETYPE_VPHYSICS )     	
	Engine5:SetSolid( SOLID_VPHYSICS )

	Engine5.Out = Engine5:WorldToLocal(Engine5:GetAttachment(Engine5:LookupAttachment( "driveshaft" )).Pos)

	local phys = Engine5:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass( Engine5.Weight ) 
	end

	Engine5:SetNetworkedBeamString("Type",Engine5.EngineName)
	Engine5:SetNetworkedBeamInt("Torque",Engine5.PeakTorque)	
	-- add in the variable to check if its an electric motor
	if (Engine5.iselec == true )then
		Engine5:SetNetworkedBeamInt("Power",math.floor(Engine.PeakTorque * Engine.LimitRPM / (4*9548.8))) --elecs and turbines peak power is at limitrpm/2, and has peaktorque/2 nm at that rpm
	else
		Engine5:SetNetworkedBeamInt("Power",math.floor(Engine5.PeakTorque * Engine5.PeakMaxRPM / 9548.8))
	end
	Engine5:SetNetworkedBeamInt("MinRPM",Engine5.PeakMinRPM)
	Engine5:SetNetworkedBeamInt("MaxRPM",Engine5.PeakMaxRPM)
	Engine5:SetNetworkedBeamInt("LimitRPM",Engine5.LimitRPM)
	--####################################################
	Engine5:SetNetworkedBeamInt("FlywheelMass2",Engine5.FlywheelMass3*1000)
	Engine5:SetNetworkedBeamInt("Idle",Engine5.IdleRPM)
	Engine5:SetNetworkedBeamInt("Weight",Engine5.Weight)
	Engine5:SetNetworkedBeamInt("Rpm",Engine5.FlyRPM)
	--####################################################

	Owner:AddCount("_acf_engine5", Engine5)
	Owner:AddCleanup( "acfmenu", Engine5 )

	return Engine5
end
list.Set( "ACFCvars", "acf_engine5" , {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"} )
duplicator.RegisterEntityClass("acf_engine5", MakeACF_Engine5, "Pos", "Angle", "Id", "SoundPatch", "Model", "PeakTorque", "IdleRPM", "PeakMinRPM", "PeakMaxRPM", "LimitRPM", "FlywheelMass2", "Weight", "EngineName", "FlywheelMass3")

function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start

	if self.Active then
		return false, "Turn off the engine before updating it!"
	end
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that engine!"
	end

	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")

	if List["Mobility2"][Id]["model"] ~= self.Model then
		return false, "The new engine must have the same model!"
	end


	/*if ( List["Mobility2"][Id]["model"] != self.Model ) then --Make sure the models are the sames before doing a changeover
		Feedback = "The new engine needs to have the same model as the old one !"
	return Feedback end*/
	
	if self.Id != Id then
		self.Id = Id
		self.Weight = List["Mobility2"][Id]["weight"]
		self.iselec = List["Mobility2"][Id]["iselec"] -- is the engine electric?
		self.elecpower = List["Mobility2"][Id]["elecpower"] -- how much power does it output
		self.FlywheelOverride = List["Mobility2"][Id]["flywheeloverride"] -- how much power does it output
		self.IsTrans = List["Mobility2"][Id]["istrans"]
	end
	
	self.ModTable[1] = ArgsTable[5]
	self.ModTable[2] = ArgsTable[6]
	self.ModTable[3] = ArgsTable[7]
	self.ModTable[4] = ArgsTable[8]
	self.ModTable[5] = ArgsTable[9]
	self.ModTable[6] = ArgsTable[10]
	self.ModTable[7] = ArgsTable[11]
	self.ModTable[8] = ArgsTable[12]
	self.ModTable[9] = ArgsTable[13]
	self.ModTable[10] = ArgsTable[14]
		
		
	self.SoundPath = ArgsTable[5]
	self.Model = ArgsTable[6]
	--##########
	if(tonumber(ArgsTable[7]) >= 1) then
		self.PeakTorque = ArgsTable[7]
	elseif(tonumber(ArgsTable[7]) < 1) then
		self.PeakTorque = 1
	end
	--##########
	if(tonumber(ArgsTable[8]) >= 100) then
		self.IdleRPM = ArgsTable[8]
	elseif(tonumber(ArgsTable[8]) < 100) then
		self.IdleRPM = 100
	end
	--##########
	if(tonumber(ArgsTable[9]) >= 100) then
		self.PeakMinRPM = ArgsTable[9]
	elseif(tonumber(ArgsTable[9]) < 100) then
		self.PeakMinRPM = 100
	end
	--##########
	if(tonumber(ArgsTable[11]) >= 100) then
		self.LimitRPM = ArgsTable[11]
	elseif(tonumber(ArgsTable[11]) < 100) then
		self.LimitRPM = 100
	end
	--##########
	if(ArgsTable[10] <= ArgsTable[11] and tonumber(ArgsTable[10]) >= 100 ) then 
		self.PeakMaxRPM = ArgsTable[10]
	elseif(ArgsTable[10] > ArgsTable[11] ) then
		self.PeakMaxRPM = ArgsTable[11]
	elseif(tonumber(ArgsTable[10]) < 100) then
		self.PeakMaxRPM = 100
	end
	--##########
	if(tonumber(ArgsTable[12]) >= 0.001) then
		self.FlywheelMass2 = ArgsTable[12]
	elseif(tonumber(ArgsTable[12]) < 0.001) then
		self.FlywheelMass2 = 0.001
	end
	--##########
	if(tonumber(ArgsTable[13]) >= 1) then
		self.Weight = ArgsTable[13]
	elseif(tonumber(ArgsTable[13]) < 1) then
		self.Weight = 1
	end
	--##########
	self.EngineName = ArgsTable[14]
	
		
	self.PeakTorque2 = ArgsTable[7]
	self.PeakTorque3 = ArgsTable[7]
	self.Idling = ArgsTable[8]
	self.PeakMaxRPM2 = ArgsTable[10]
	self.LimitRPM2 = ArgsTable[11]
	self.FlywheelMass3 = ArgsTable[12]
	self.CutValue = self.LimitRPM / 40
	self.CutRpm = self.LimitRPM - 100

	self.Inertia = self.FlywheelMass2*(3.1416)^2
	--##################################################################################
	
	self:SetModel( self.Model )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Out = self:WorldToLocal(self:GetAttachment(self:LookupAttachment( "driveshaft" )).Pos)

	local phys = self:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( self.Weight ) 
	end

	self:SetNetworkedBeamString("Type",self.EngineName)
	self:SetNetworkedBeamInt("Torque",self.PeakTorque)
	-- add in the variable to check if its an electric motor
	if (self.iselec == true)  then
		self:SetNetworkedBeamInt("Power",math.floor(self.PeakTorque * self.LimitRPM / (4*9548.8))) --elecs and turbines peak power is at limitrpm/2, and has peak torque/2 at that rpm
	else
		self:SetNetworkedBeamInt("Power",math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
	end

	self:SetNetworkedBeamInt("MinRPM",self.PeakMinRPM)
	self:SetNetworkedBeamInt("MaxRPM",self.PeakMaxRPM)
	self:SetNetworkedBeamInt("LimitRPM",self.LimitRPM)
	--################################################
	self:SetNetworkedBeamInt("FlywheelMass2",self.FlywheelMass3*1000)
	self:SetNetworkedBeamInt("Idle",self.IdleRPM)
	self:SetNetworkedBeamInt("Weight",self.Weight)
	self:SetNetworkedBeamInt("Rpm",self.FlyRPM)
	--################################################


	return true, "Engine updated successfully!"
end

function ENT:TriggerInput( iname , value )

	if (iname == "Throttle") then
		self.Throttle = math.Clamp(value,0,100)/100
	elseif (iname == "Active") then
		if (value > 0 and not self.Active) then
			self.RPM = {}
			self.RPM[1] = self.IdleRPM
			self.Active = true
			self.Active2 = true
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
			self:ACFInit()
		elseif (value <= 0 and self.Active) then
			self.Active = false
			Wire_TriggerOutput( self, "RPM", 0 )
			Wire_TriggerOutput( self, "Torque", 0 )
			Wire_TriggerOutput( self, "Power", 0 )
		end
	--##################################################
	elseif (iname == "TqAdd") then
		if (value ~= 0 ) then
			self.TqAdd = true
			self.PeakTorque = self.PeakTorque2+value
			--self.PeakTorque3 = self.PeakTorque2+value
			self:SetNetworkedBeamInt("Torque",self.PeakTorque)
			self:SetNetworkedBeamInt("Power", math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
		elseif (value == 0 ) then
			self.TqAdd = false
			self.PeakTorque = self.PeakTorque2
			--self.PeakTorque3 = self.PeakTorque2
			self:SetNetworkedBeamInt("Torque",self.PeakTorque)
			self:SetNetworkedBeamInt("Power", math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
		end
	elseif (iname == "MaxRpmAdd") then
		if (value ~= 0 ) then
			self.MaxRpmAdd = true
			--self.PeakMaxRPM = self.PeakMaxRPM2+value
			if( self.PeakMaxRPM2+value <= self.LimitRPM ) then
				self.PeakMaxRPM = self.PeakMaxRPM2+value
			elseif( self.PeakMaxRPM2+value > self.LimitRPM ) then
				self.PeakMaxRPM = self.LimitRPM
			end
			self:SetNetworkedBeamInt("MaxRPM",self.PeakMaxRPM)
			self:SetNetworkedBeamInt("Power", math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
		elseif (value == 0 ) then
			self.MaxRpmAdd = false
			self.PeakMaxRPM = self.PeakMaxRPM2
			self:SetNetworkedBeamInt("MaxRPM",self.PeakMaxRPM)
			self:SetNetworkedBeamInt("Power", math.floor(self.PeakTorque * self.PeakMaxRPM / 9548.8))
		end
	elseif (iname == "LimitRpmAdd") then
		if (value ~= 0 ) then
			self.LimitRpmAdd = true
			self.LimitRPM = self.LimitRPM2+value
			self:SetNetworkedBeamInt("LimitRPM",self.LimitRPM)
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
		elseif (value == 0 ) then
			self.LimitRpmAdd = false
			self.LimitRPM = self.LimitRPM2
			self:SetNetworkedBeamInt("LimitRPM",self.LimitRPM)
			self.CutValue = self.LimitRPM / 40
			self.CutRpm = self.LimitRPM - 100
		end
	elseif (iname == "FlywheelMass") then
		if (value > 0 ) then
			self.FlywheelMass = true
			self.Inertia = value*(3.1416)^2
			self:SetNetworkedBeamInt("FlywheelMass2",value*1000)
		elseif (value <= 0 ) then
			self.FlywheelMass = false
			self.Inertia = self.FlywheelMass3*(3.1416)^2
			self:SetNetworkedBeamInt("FlywheelMass2",self.FlywheelMass3*1000)
		end
	elseif (iname == "Idle") then
		if (value > 0 ) then
			self.Idle = true
			self.IdleRPM = value
			self:SetNetworkedBeamInt("Idle",self.IdleRPM)
		elseif (value <= 0 ) then
			self.Idle = false
			self.IdleRPM = self.Idling
			self:SetNetworkedBeamInt("Idle",self.IdleRPM)
		end
	elseif (iname == "DisableCut") then
		if (value > 0 ) then
			self.DisableCut = 1
		elseif (value <= 0 ) then
			self.DisableCut = 0
		end
	end

end
--######################################################

function ENT:Think()

	local Time = CurTime()

	if self.Active2 then
		if self.Legal then
			self:CalcRPM()
		end

		if self.LastCheck < CurTime() then
			self:CheckRopes()
			self:CalcMassRatio()
			if tonumber(self:GetPhysicsObject():GetMass()) < tonumber(self.Weight) or tonumber(self:GetParent():IsValid()) then
				self.Legal = false
			else 
				self.Legal = true
			end

			self.LastCheck = Time + math.Rand(5, 10)
		end

	end

	self.LastThink = Time
	self:NextThink( Time )
	return true

end

function ENT:CalcMassRatio()
	
	local Mass = 0
	local PhysMass = 0
	
	-- get the shit that is physically attached to the vehicle
	local PhysEnts = ACF_GetAllPhysicalConstraints( self )
	
	-- add any parented but not constrained props you sneaky bastards
	local AllEnts = table.Copy( PhysEnts )
	for k, v in pairs( PhysEnts ) do
		
		-- gotta make sure the parenting addon is installed...
		if v.GetChildren then table.Merge( AllEnts, v:GetChildren() ) end
	
	end
	
	for k, v in pairs( AllEnts ) do
		
		if not IsValid( v ) then continue end
		
		local phys = v:GetPhysicsObject()
		if not IsValid( phys ) then continue end
		
		Mass = Mass + phys:GetMass()
		
		if PhysEnts[ v ] then
			PhysMass = PhysMass + phys:GetMass()
		end
		
	end

	self.MassRatio = PhysMass / Mass
	
	Wire_TriggerOutput( self, "Mass", math.Round( Mass, 2 ) )
	Wire_TriggerOutput( self, "Physical Mass", math.Round( PhysMass, 2 ) )
	
end

function ENT:ACFInit()
	
	self:CalcMassRatio()

	self.LastThink = CurTime()
	self.Torque = self.PeakTorque
	self.FlyRPM = self.IdleRPM * 1.5

end

function ENT:CalcRPM()

	local DeltaTime = CurTime() - self.LastThink
	-- local AutoClutch = math.min(math.max(self.FlyRPM-self.IdleRPM,0)/(self.IdleRPM+self.LimitRPM/10),1)

	//local ClutchRatio = math.min(Clutch/math.max(TorqueDiff,0.05),1)
	
	-- Calculate the current torque from flywheel RPM
	--#################
	local Drag
	local TorqueDiff
	if self.Active then
	if( self.CutMode == 0 ) then
		self.Torque = self.Throttle * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - self.Throttle) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - self.Throttle) / self.Inertia
		end
	
	elseif( self.CutMode == 1 ) then
		self.Torque = 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - self.IdleRPM, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
		
	end 
	
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	-- This is the presently avaliable torque from the engine
	TorqueDiff = math.max( self.FlyRPM - self.IdleRPM, 0 ) * self.Inertia

	end
	
	if( self.Active == false ) then
		self.Torque = 0 * math.max( self.PeakTorque * math.min( self.FlyRPM / self.PeakMinRPM , (self.LimitRPM - self.FlyRPM) / (self.LimitRPM - self.PeakMaxRPM), 1 ), 0 )
		if self.iselec == true then
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.FlywheelOverride) * (1 - 0) / self.Inertia
		else
			Drag = self.PeakTorque * (math.max( self.FlyRPM - 0, 0) / self.PeakMaxRPM) * ( 1 - 0) / self.Inertia
		end
	
	-- Let's accelerate the flywheel based on that torque
	self.FlyRPM = math.max( self.FlyRPM + self.Torque / self.Inertia - Drag, 1 )
	-- This is the presently avaliable torque from the engine
	TorqueDiff = math.max( self.FlyRPM - 0, 0 ) * self.Inertia
	
	end
	--##############
	
	-- The gearboxes don't think on their own, it's the engine that calls them, to ensure consistent execution order
	local Boxes = table.Count( self.GearLink )
	
	local MaxTqTable = {}
	local MaxTq = 0
	for Key, Gearbox in pairs(self.GearLink) do
		-- Get the requirements for torque for the gearboxes (Max clutch rating minus any wheels currently spinning faster than the Flywheel)
		MaxTqTable[Key] = Gearbox:Calc( self.FlyRPM, self.Inertia )
		MaxTq = MaxTq + MaxTqTable[Key]
	end
	
	-- Calculate the ratio of total requested torque versus what's avaliable
	local AvailTq = math.min( TorqueDiff / MaxTq / Boxes, 1 )

	for Key, Gearbox in pairs(self.GearLink) do
		-- Split the torque fairly between the gearboxes who need it
		Gearbox:Act( MaxTqTable[Key] * AvailTq * self.MassRatio, DeltaTime )
	end

	self.FlyRPM = self.FlyRPM - (math.min(TorqueDiff,MaxTq)/self.Inertia)
	
	--#######################################
	--if( self.CutOn == 1 ) then
	if( self.DisableCut == 0 ) then
		if( self.FlyRPM >= self.CutRpm and self.CutMode == 0 ) then
			self.CutMode = 1
			if self.Sound then
				self.Sound:Stop()
			end
			self.Sound = nil
			self.Sound2 = CreateSound(self, "acf_other/penetratingshots/00000293.wav")
			self.Sound2:PlayEx(0.5,100)
		end
		if( self.FlyRPM <= self.CutRpm - self.CutValue and self.CutMode == 1 ) then
			self.CutMode = 0
			self.Sound = CreateSound(self, self.SoundPath)
			self.Sound:PlayEx(0.5,100)
			if self.Sound2 then
				self.Sound2:Stop()
			end
		end
	--elseif( self.CutOn == 0 ) then
	elseif( self.DisableCut == 1 ) then
		self.CutMode = 0
	end
	if( self.FlyRPM <= 50 and self.Active == false ) then
		self.Active2 = false
		self.FlyRPM = 0
		if self.Sound then
			self.Sound:Stop()
		end
		self.Sound = nil
	end
	--#######################################

	-- Then we calc a smoothed RPM value for the sound effects
	table.remove( self.RPM, 10 )
	table.insert( self.RPM, 1, self.FlyRPM )
	local SmoothRPM = 0
	for Key, RPM in pairs( self.RPM ) do
		SmoothRPM = SmoothRPM + (RPM or 0)
	end
	SmoothRPM = SmoothRPM / 10

	local Power = self.Torque * SmoothRPM / 9548.8
	Wire_TriggerOutput(self, "Torque", math.floor(self.Torque))
	Wire_TriggerOutput(self, "Power", math.floor(Power))
	Wire_TriggerOutput(self, "RPM", self.FlyRPM)
	--##############################################################################################
	self:SetNetworkedBeamInt("Rpm",self.FlyRPM)
	--##############################################################################################
	
	if self.Sound then
		self.Sound:ChangePitch( math.min( 20 + (SmoothRPM * self.SoundPitch) / 50, 255 ), 0 )
		self.Sound:ChangeVolume( 0.25 + self.Throttle / 1.5, 0 )
	end
	
	return RPM
end

function ENT:CheckRopes()

	for GearboxKey,Ent in pairs(self.GearLink) do
		local Constraints = constraint.FindConstraints(Ent, "Rope")
		if Constraints then

			local Clean = false
			for Key,Rope in pairs(Constraints) do
				if Rope.Ent1 == self or Rope.Ent2 == self then
					if Rope.length + Rope.addlength < self.GearRope[GearboxKey]*1.5 then
						Clean = true
					end
				end
			end

			if not Clean then
				self:Unlink( Ent )
			end

		else
			self:Unlink( Ent )
		end

		local Direction
		if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
		local DrvAngle = (self:LocalToWorld(self.Out) - Ent:LocalToWorld(Ent.In)):GetNormalized():DotProduct((Direction))
		if ( DrvAngle < 0.7 ) then
			self:Unlink( Ent )
		end

	end

end

function ENT:Link( Target )

	if not IsValid( Target ) or Target:GetClass() ~= "acf_gearbox" and Target:GetClass() ~= "acf_gearbox2" and Target:GetClass() ~= "acf_gearbox3" then
		return false, "Can only link to gearboxes!"
	end
	
	-- Check if target is already linked
	for Key, Value in pairs( self.GearLink ) do
		if Value == Target then
			return false, "That is already linked to this engine!"
		end
	end

	local InPos = Target:LocalToWorld(Target.In)
	local OutPos = self:LocalToWorld(self.Out)
	local Direction
	if self.IsTrans then Direction = -self:GetRight() else Direction = self:GetForward() end
	local DrvAngle = (OutPos - InPos):GetNormalized():DotProduct((Direction))
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end

	table.insert( self.GearLink, Target )
	table.insert( Target.Master, self )
	local RopeL = ( OutPos-InPos ):Length()
	constraint.Rope( self, Target, 0, 0, self.Out, Target.In, RopeL, RopeL * 0.2, 0, 1, "cable/cable2", false )
	table.insert( self.GearRope, RopeL )
	
	return true, "Link successful!"
	
end

function ENT:Unlink( Target )

	local Success = false
	for Key,Value in pairs(self.GearLink) do
		if Value == Target then

			local Constraints = constraint.FindConstraints(Value, "Rope")
			if Constraints then
				for Key,Rope in pairs(Constraints) do
					if Rope.Ent1 == self or Rope.Ent2 == self then
						Rope.Constraint:Remove()
					end
				end
			end

			table.remove(self.GearLink,Key)
			table.remove(self.GearRope,Key)
			Success = true
		end
	end

	if Success then
		return true, "Unlink successful!"
	else
		return false, "That gearbox is not linked to this engine!"
	end

end

function ENT:PreEntityCopy()

	//Link Saving
	local info = {}
	local entids = {}
	for Key, Value in pairs(self.GearLink) do					--First clean the table of any invalid entities
		if not Value:IsValid() then
			table.remove(self.GearLink, Value)
		end
	end
	for Key, Value in pairs(self.GearLink) do					--Then save it
		table.insert(entids, Value:EntIndex())
	end

	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self, "GearLink", info )
	end

	//Wire dupe info
	local DupeInfo = WireLib.BuildDupeInfo( self )
	if DupeInfo then
		duplicator.StoreEntityModifier( self, "WireDupeInfo", DupeInfo )
	end

end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	//Link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.GearLink) and (Ent.EntityMods.GearLink.entities) then
		local GearLink = Ent.EntityMods.GearLink
		if GearLink.entities and table.Count(GearLink.entities) > 0 then
			for _,ID in pairs(GearLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if Linked and Linked:IsValid() then
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.GearLink = nil
	end

	//Wire dupe info
	if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end

end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
	end
	Wire_Remove( self )
end

function ENT:OnRestore()
	Wire_Restored( self )
end