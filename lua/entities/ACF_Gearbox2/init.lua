AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

function ENT:Initialize()
	
	self.IsGeartrain = true
	self.Master = {}
	
	self.IsMaster = {}
	self.WheelLink = {}
	self.WheelSide = {}
	self.WheelCount = {}
	self.WheelAxis = {}
	self.WheelRopeL = {}
	self.WheelOutput = {}
	self.WheelReqTq = {}
	self.WheelVel = {}
	
	--################
	self.GearFinal = 0
	self.CurrentRPM = 0
	self.RatioMin = 0
	self.RatioMax = 0
	self.RpmLimit = 0
	self.RpmLimit2 = 0
	self.DeclutchRpm = 0
	self.ClutchMode = 0
	
	self.TotalReqTq = 0
	self.RClutch = 0
	self.LClutch = 0
	self.LBrake = 0
	self.RBrake = 0

	self.Gear = 1
	self.GearRatio = 0
	self.ChangeFinished = 0
	
	self.LegalThink = 0
	
	self.RPM = {}
	self.CurRPM = 0
	self.InGear = false
	self.CanUpdate = true
	self.LastActive = 0
	self.Legal = true
	
end  

function MakeACF_Gearbox2(Owner, Pos, Angle, Id, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Data11)

	if not Owner:CheckLimit("_acf_misc") then return false end
	
	local Gearbox2 = ents.Create("ACF_Gearbox2")
	local List = list.Get("ACFEnts")
	local Classes = list.Get("ACFClasses")
	if not IsValid( Gearbox2 ) then return false end
	Gearbox2:SetAngles(Angle)
	Gearbox2:SetPos(Pos)
	Gearbox2:Spawn()

	Gearbox2:SetPlayer(Owner)
	Gearbox2.Owner = Owner
	Gearbox2.Id = Id
	Gearbox2.Model = List["Mobility2"][Id]["model"]
	Gearbox2.Mass = List["Mobility2"][Id]["weight"]
	Gearbox2.SwitchTime = List["Mobility2"][Id]["switch"]
	Gearbox2.MaxTorque = List["Mobility2"][Id]["maxtq"]
	Gearbox2.Gears = List["Mobility2"][Id]["gears"]
	Gearbox2.Dual = List["Mobility2"][Id]["doubleclutch"]
	Gearbox2.GearTable = List["Mobility2"][Id]["geartable"]
		Gearbox2.GearTable["Final"] = Data10
		Gearbox2.GearTable[1] = Data1
		Gearbox2.GearTable[2] = Data2
		Gearbox2.GearTable[3] = Data3
		Gearbox2.GearTable[4] = Data4
		Gearbox2.GearTable[5] = Data5
		Gearbox2.GearTable[6] = Data6
		Gearbox2.GearTable[7] = Data7
		Gearbox2.GearTable[8] = Data8
		Gearbox2.GearTable[9] = Data9
		Gearbox2.GearTable[0] = 0
		
		Gearbox2.Gear0 = Data10
		Gearbox2.Gear1 = Data1
		Gearbox2.Gear2 = Data2
		Gearbox2.Gear3 = Data3
		Gearbox2.Gear4 = Data4
		Gearbox2.Gear5 = Data5
		Gearbox2.Gear6 = Data6
		Gearbox2.Gear7 = Data7
		Gearbox2.Gear8 = Data8
		Gearbox2.Gear9 = Data9
	
				
	Gearbox2:SetModel( Gearbox2.Model )	
	
	Gearbox2.GearFinal = tonumber(Gearbox2.Gear3)
	Gearbox2.RatioMin = tonumber(Gearbox2.Gear3)
	Gearbox2.RatioMax = tonumber(Gearbox2.Gear4)
	Gearbox2.RpmLimit = tonumber(Gearbox2.Gear5)
	Gearbox2.RpmLimit2 = tonumber(Gearbox2.Gear6)
	Gearbox2.DeclutchRpm = tonumber(Gearbox2.Gear7)
	Gearbox2.GearFinal2 = tonumber(Gearbox2.GearFinal)
	Gearbox2.ClutchMode = 0
		
	local Inputs = {"Gear","Gear Up","Gear Down"}
	if Gearbox2.Dual then
		table.insert(Inputs,"Left Clutch")
		table.insert(Inputs,"Right Clutch")
		table.insert(Inputs,"Left Brake")
		table.insert(Inputs,"Right Brake")
	else
		table.insert(Inputs, "Clutch")
		table.insert(Inputs, "Brake")
	end
	
	Gearbox2.Inputs = Wire_CreateInputs( Gearbox2.Entity, Inputs )
	Gearbox2.Outputs = WireLib.CreateSpecialOutputs( Gearbox2.Entity, { "Ratio", "Entity" , "Current Gear" }, { "NORMAL" , "ENTITY" , "NORMAL" , "NORMAL" } )
	Wire_TriggerOutput(Gearbox2.Entity, "Entity", Gearbox2.Entity)
	Gearbox2.WireDebugName = "ACF Gearbox2"
	
	Gearbox2.LClutch = Gearbox2.MaxTorque
	Gearbox2.RClutch = Gearbox2.MaxTorque

	Gearbox2:PhysicsInit( SOLID_VPHYSICS )      	
	Gearbox2:SetMoveType( MOVETYPE_VPHYSICS )     	
	Gearbox2:SetSolid( SOLID_VPHYSICS )

	local phys = Gearbox2:GetPhysicsObject()  	
	if IsValid( phys ) then 
		phys:SetMass( Gearbox2.Mass ) 
	end
	
	Gearbox2.In = Gearbox2:WorldToLocal(Gearbox2:GetAttachment(Gearbox2:LookupAttachment( "input" )).Pos)
	Gearbox2.OutL = Gearbox2:WorldToLocal(Gearbox2:GetAttachment(Gearbox2:LookupAttachment( "driveshaftL" )).Pos)
	Gearbox2.OutR = Gearbox2:WorldToLocal(Gearbox2:GetAttachment(Gearbox2:LookupAttachment( "driveshaftR" )).Pos)
		
	Owner:AddCount("_acf_Gearbox2", Gearbox2)
	Owner:AddCleanup( "acfmenu", Gearbox2 )
	
	Gearbox2:ChangeGear(1)
	
	--timer.Simple(0.5, function() Gearbox:UpdateHUD() end ) 
	
	--##############################################
	Gearbox2:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	Gearbox2:SetNetworkedBeamInt("Final",Gearbox2.GearFinal*1000)
	Gearbox2:SetNetworkedBeamInt("Weight",Gearbox2.Mass)
	Gearbox2:SetNetworkedBeamInt("Gear1Over",Gearbox2.Gear1*1000)
	Gearbox2:SetNetworkedBeamInt("Gear2Over",Gearbox2.Gear2*1000)
	Gearbox2:SetNetworkedBeamInt("RpmMax",Gearbox2.Gear5)
	Gearbox2:SetNetworkedBeamInt("RpmMin",Gearbox2.Gear6)
	Gearbox2:SetNetworkedBeamInt("Declutch",Gearbox2.Gear7)
	Gearbox2:SetNetworkedBeamInt("Current",Gearbox2.Gear)
	Gearbox2:SetNetworkedBeamInt("Ratio",Gearbox2.GearRatio*1000)
		
	return Gearbox2
end
list.Set( "ACFCvars", "acf_gearbox2" , {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10"} )
duplicator.RegisterEntityClass("acf_gearbox2", MakeACF_Gearbox2, "Pos", "Angle", "Id", "Gear1", "Gear2", "Gear3", "Gear4", "Gear5", "Gear6", "Gear7", "Gear8", "Gear9", "Gear0" )

function ENT:Update( ArgsTable )	--That table is the player data, as sorted in the ACFCvars above, with player who shot, and pos and angle of the tool trace inserted at the start
	-- That table is the player data, as sorted in the ACFCvars above, with player who shot, 
	-- and pos and angle of the tool trace inserted at the start
	
	if ArgsTable[1] ~= self.Owner then -- Argtable[1] is the player that shot the tool
		return false, "You don't own that gearbox!"
	end
	
	local Id = ArgsTable[4]	-- Argtable[4] is the engine ID
	local List = list.Get("ACFEnts")
	
	if List["Mobility2"][Id]["model"] ~= self.Model then
		return false, "The new gearbox must have the same model!"
	end
		
	if self.Id != Id then
		local Inputs = {"Gear","Gear Up","Gear Down"}
		if self.Dual then
			table.insert(Inputs,"Left Clutch")
			table.insert(Inputs,"Right Clutch")
			table.insert(Inputs,"Left Brake")
			table.insert(Inputs,"Right Brake")
		else
			table.insert(Inputs, "Clutch")
			table.insert(Inputs, "Brake")
		end
		
		self.Id = Id
		self.Mass = List["Mobility2"][Id]["weight"]
		self.SwitchTime = List["Mobility2"][Id]["switch"]
		self.MaxTorque = List["Mobility2"][Id]["maxtq"]
		self.Gears = List["Mobility2"][Id]["gears"]
		self.Dual = List["Mobility2"][Id]["doubleclutch"]
		
		self.Inputs = Wire_CreateInputs( self.Entity, Inputs )
		
	end
	
	self.GearTable["Final"] = ArgsTable[14]
	self.GearTable[1] = ArgsTable[5]
	self.GearTable[2] = ArgsTable[6]
	self.GearTable[3] = ArgsTable[7]
	self.GearTable[4] = ArgsTable[8]
	self.GearTable[5] = ArgsTable[9]
	self.GearTable[6] = ArgsTable[10]
	self.GearTable[7] = ArgsTable[11]
	self.GearTable[8] = ArgsTable[12]
	self.GearTable[9] = ArgsTable[13]
	self.GearTable[0] = 0
	
	self.Gear0 = ArgsTable[14]
	self.Gear1 = ArgsTable[5]
	self.Gear2 = ArgsTable[6]
	self.Gear3 = ArgsTable[7]
	self.Gear4 = ArgsTable[8]
	self.Gear5 = ArgsTable[9]
	self.Gear6 = ArgsTable[10]
	self.Gear7 = ArgsTable[11]
	self.Gear8 = ArgsTable[12]
	self.Gear9 = ArgsTable[13]
		
	self:ChangeGear(1)
	
	self.GearFinal = tonumber(self.Gear3)
	self.RatioMin = tonumber(self.Gear3)
	self.RatioMax = tonumber(self.Gear4)
	self.RpmLimit = tonumber(self.Gear5)
	self.RpmLimit2 = tonumber(self.Gear6)
	self.DeclutchRpm = tonumber(self.Gear7)
	self.GearFinal2 = tonumber(self.GearFinal)
	self.ClutchMode = 0
		
	--self:UpdateHUD()
	
	--##############################################
	self:SetNetworkedBeamString("Type",List["Mobility2"][Id]["name"])
	self:SetNetworkedBeamInt("Final",self.GearFinal*1000)
	self:SetNetworkedBeamInt("Weight",self.Mass)
	self:SetNetworkedBeamInt("Gear1Over",self.Gear1*1000)
	self:SetNetworkedBeamInt("Gear2Over",self.Gear2*1000)
	self:SetNetworkedBeamInt("RpmMax",self.Gear5)
	self:SetNetworkedBeamInt("RpmMin",self.Gear6)
	self:SetNetworkedBeamInt("Declutch",self.Gear7)
	self:SetNetworkedBeamInt("Current",self.Gear)
	self:SetNetworkedBeamInt("Ratio",self.GearRatio*1000)
	
	return true, "Gearbox updated successfully!"
end

function ENT:TriggerInput( iname , value )

	if ( iname == "Gear" and self.Gear != math.floor(value) ) then
		self:ChangeGear(math.floor(value))
	elseif ( iname == "Gear Up" ) then
		if ( self.Gear < self.Gears and value > 0 ) then
			self:ChangeGear(math.floor(self.Gear + 1))
		end
	elseif ( iname == "Gear Down" ) then
		if ( self.Gear > 1 and value > 0 ) then
			self:ChangeGear(math.floor(self.Gear - 1))
		end
	elseif ( iname == "Clutch" ) then
		if(self.ClutchMode == 0 ) then
			self.LClutch = math.Clamp(1-value,0,1)*self.MaxTorque
			self.RClutch = math.Clamp(1-value,0,1)*self.MaxTorque
		end
	elseif ( iname == "Brake" ) then
		self.LBrake = math.Clamp(value,0,100)
		self.RBrake = math.Clamp(value,0,100)
	elseif ( iname == "Left Brake" ) then
		self.LBrake = math.Clamp(value,0,100)
	elseif ( iname == "Right Brake" ) then
		self.RBrake = math.Clamp(value,0,100)
	elseif ( iname == "Left Clutch" ) then
		if(self.ClutchMode == 0 ) then
			self.LClutch = math.Clamp(1-value,0,1)*self.MaxTorque
		end
	elseif ( iname == "Right Clutch" ) then
		if(self.ClutchMode == 0 ) then
			self.RClutch = math.Clamp(1-value,0,1)*self.MaxTorque
		end
	end
	
end

function ENT:Think()

	local Time = CurTime()
	
	if self.LegalThink < Time and self.LastActive+2 > Time then
		self:CheckRopes()
		if self:GetPhysicsObject():GetMass() < self.Mass or IsValid( self:GetParent() ) then
			self.Legal = false
		else 
			self.Legal = true
		end
		self.LegalThink = Time + (math.random(5,10))
	end
	
	self:NextThink(Time+0.2)
	return true
	
end

function ENT:CheckRopes()
	
	for WheelKey,Ent in pairs(self.WheelLink) do
		local Constraints = constraint.FindConstraints(Ent, "Rope")
		if Constraints then
		
			local Clean = false
			for Key,Rope in pairs(Constraints) do
				if Rope.Ent1 == self or Rope.Ent2 == self then
					if Rope.length + Rope.addlength < self.WheelRopeL[WheelKey]*1.5 then
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
		
		local DrvAngle = (self:LocalToWorld(self.WheelOutput[WheelKey]) - Ent:GetPos()):GetNormalized():DotProduct( (self:GetRight()*self.WheelOutput[WheelKey].y):GetNormalized() )
		if ( DrvAngle < 0.7 ) then
			self:Unlink( Ent )
		end
	end
	
end

function ENT:CheckEnts()		--Check if every entity we are linked to still actually exists
	
	for Key, WheelEnt in pairs(self.WheelLink) do
		if not IsValid(WheelEnt) then
			table.remove(self.WheelAxis,Key)
			table.remove(self.WheelSide,Key)
		else
			local WheelPhys = WheelEnt:GetPhysicsObject()
			if not IsValid(WheelPhys) then
				WheelEnt:Remove()
				table.remove(self.WheelAxis,Key)
				table.remove(self.WheelSide,Key)
			end
		end
	end
	
end

function ENT:Calc( InputRPM, InputInertia )

	if self.LastActive == CurTime() then
		return math.min(self.TotalReqTq, self.MaxTorque)
	end
	
	if self.ChangeFinished < CurTime() then
		self.InGear = true
	end

	self:CheckEnts()

	local BoxPhys = self:GetPhysicsObject()
	local SelfWorld = self:LocalToWorld( BoxPhys:GetAngleVelocity() ) - self:GetPos()
	self.WheelReqTq = {}
	self.TotalReqTq = 0
	
	--Clutching
	if (InputRPM < self.DeclutchRpm ) then
		self.ClutchMode = 1
		self.LClutch = math.Clamp(1-1,0,1)*self.MaxTorque
		self.RClutch = math.Clamp(1-1,0,1)*self.MaxTorque
	elseif (InputRPM >= self.DeclutchRpm ) then
		self.ClutchMode = 0
		self.LClutch = math.Clamp(1-0,0,1)*self.MaxTorque
		self.RClutch = math.Clamp(1-0,0,1)*self.MaxTorque
	end
	
	for Key, WheelEnt in pairs(self.WheelLink) do
		if IsValid( WheelEnt ) then
			local Clutch = 0
			if self.WheelSide[Key] == 0 then
				Clutch = self.LClutch
			elseif self.WheelSide[Key] == 1 then
				Clutch = self.RClutch
			end
		
			self.WheelReqTq[Key] = 0
			if WheelEnt.IsGeartrain then
				local Inertia = 0
				if self.GearRatio ~= 0 then Inertia = InputInertia / self.GearRatio end
				self.WheelReqTq[Key] = math.abs( WheelEnt:Calc( InputRPM * self.GearRatio, Inertia ) * self.GearRatio )
			else
				local RPM = self:CalcWheel( Key, WheelEnt, SelfWorld )
				if self.GearRatio ~= 0 and ( ( InputRPM > 0 and RPM < InputRPM ) or ( InputRPM < 0 and RPM > InputRPM ) ) then
                    self.WheelReqTq[Key] = math.min( Clutch, ( InputRPM - RPM ) * InputInertia )
                end
			end
			self.TotalReqTq = self.TotalReqTq + self.WheelReqTq[Key]
		else
			table.remove(self.WheelLink, Key)
		end
	end
	--####################
	/*if(RPM>=MaxRpm){Reducer= ((RPM-MaxRpm)+((RPM-MaxRpm)/3000))-(RPM-MaxRpm)}
	if(RPM<=MinRPM){Reducer= ((MinRPM-RPM)+((MinRPM-RPM)/3000))-(MinRPM-RPM)}
	FinalNumber=0.01+Reducer*/
	if(self.LClutch > 0 and self.RClutch > 0) then
	if (InputRPM >= self.RpmLimit) then
			self.Reducer = ((InputRPM-self.RpmLimit)+((InputRPM-self.RpmLimit)/3000))-(InputRPM-self.RpmLimit)
			if(self.GearFinal2 < self.RatioMax) then
				self.GearFinal = self.GearFinal+(0.001+self.Reducer)
				self.GearFinal2 = tonumber(self.GearFinal)
			elseif(self.GearFinal2 >= self.RatioMax) then
				self.GearFinal = self.RatioMax
				self.GearFinal2 = tonumber(self.GearFinal)
			end
			self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
			self:SetNetworkedBeamInt("Final",self.GearFinal*1000)
			self:SetNetworkedBeamInt("Ratio",self.GearRatio*1000)
			Wire_TriggerOutput(self, "Ratio", self.GearRatio)
		--decrease
		elseif (InputRPM <= self.RpmLimit2) then
			self.Reducer = ((self.RpmLimit2-InputRPM)+((self.RpmLimit2-InputRPM)/3000))-(self.RpmLimit2-InputRPM)
			if(self.GearFinal2 > self.RatioMin) then
				self.GearFinal = self.GearFinal-(0.001+self.Reducer)
				self.GearFinal2 = tonumber(self.GearFinal)
			elseif(self.GearFinal2 <= self.RatioMin) then
				self.GearFinal = self.RatioMin
				self.GearFinal2 = tonumber(self.GearFinal)
			end
			self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
			self:SetNetworkedBeamInt("Final",self.GearFinal*1000)
			self:SetNetworkedBeamInt("Ratio",self.GearRatio*1000)
			Wire_TriggerOutput(self, "Ratio", self.GearRatio)
		end
	end
	--####################
	return math.min(self.TotalReqTq, self.MaxTorque)

end

function ENT:CalcWheel( Key, WheelEnt, SelfWorld )
	if IsValid( WheelEnt ) then
		local WheelPhys = WheelEnt:GetPhysicsObject()
		local VelDiff = (WheelEnt:LocalToWorld(WheelPhys:GetAngleVelocity())-WheelEnt:GetPos()) - SelfWorld
		local BaseRPM = VelDiff:Dot(WheelEnt:LocalToWorld(self.WheelAxis[Key])-WheelEnt:GetPos())
		self.WheelVel[Key] = BaseRPM
		
		if self.GearRatio == 0 then return 0 end
		
		-- Reported BaseRPM is in angle per second and in the wrong direction, so we convert and add the gearratio
		return BaseRPM / self.GearRatio / -6
		
	else
	
		return 0
		
	end
	
end

function ENT:Act( Torque, DeltaTime )
	
	local ReactTq = 0
	--local AvailTq = math.min(math.abs(Torque)/self.TotalReqTq,1)/self.GearRatio*-(-Torque/math.abs(Torque))		--Calculate the ratio of total requested torque versus what's avaliable, and then multiply it but the current gearratio
	local AvailTq = 0
	if Torque != 0 then
		AvailTq = math.min(math.abs(Torque)/self.TotalReqTq,1)/self.GearRatio*-(-Torque/math.abs(Torque))
	end


	for Key, OutputEnt in pairs(self.WheelLink) do
		if self.WheelSide[Key] == 0 then
			Brake = self.LBrake
		elseif self.WheelSide[Key] == 1 then
			Brake = self.RBrake
		end
		
		self.WheelReqTq[Key] = self.WheelReqTq[Key] or 0
		
		if OutputEnt.IsGeartrain then
			OutputEnt:Act( self.WheelReqTq[Key]*AvailTq , DeltaTime )
		else
			self:ActWheel( Key, OutputEnt, self.WheelReqTq[Key]*AvailTq, Brake , DeltaTime )
			ReactTq = ReactTq + self.WheelReqTq[Key]*AvailTq
		end
	end
	
	local BoxPhys = self:GetPhysicsObject()
	if IsValid( BoxPhys ) and ReactTq != 0 then	
		local Force = self:GetForward() * ReactTq - self:GetForward()
		BoxPhys:ApplyForceOffset( Force * 39.37 * DeltaTime, self:GetPos() + self:GetUp()*-39.37 )
		BoxPhys:ApplyForceOffset( Force * -39.37 * DeltaTime, self:GetPos() + self:GetUp()*39.37 )
	end
	
	self.LastActive = CurTime()
	
end

function ENT:ActWheel( Key, OutputEnt, Tq, Brake, DeltaTime )

	local OutPhys = OutputEnt:GetPhysicsObject()
	local OutPos = OutputEnt:GetPos()
	local TorqueAxis = OutputEnt:LocalToWorld(self.WheelAxis[Key]) - OutPos
	local Cross = TorqueAxis:Cross( Vector(TorqueAxis.y,TorqueAxis.z,TorqueAxis.x) )
	local Inertia = OutPhys:GetInertia()
	local BrakeMult = 0
	if Brake > 0 then
		BrakeMult = self.WheelVel[Key] * Inertia * Brake / 10
	end
	local TorqueVec = TorqueAxis:Cross(Cross):GetNormalized() 
	local Force = TorqueVec * Tq + TorqueVec * BrakeMult
	OutPhys:ApplyForceOffset( Force * -39.37 * DeltaTime, OutPos + Cross*39.37)
	OutPhys:ApplyForceOffset( Force * 39.37 * DeltaTime, OutPos + Cross*-39.37 )
	
end

function ENT:ChangeGear(value)

	self.Gear = math.Clamp(value,0,self.Gears)
	self.GearRatio = (self.GearTable[self.Gear] or 0)*self.GearFinal
	self.ChangeFinished = CurTime() + self.SwitchTime
	self.InGear = false
	
	Wire_TriggerOutput(self, "Current Gear", self.Gear)
	
	--############################################################################################
	self:SetNetworkedBeamInt("Ratio",self.GearRatio*1000)
	self:SetNetworkedBeamInt("Current",self.Gear)
	
	self:EmitSound("buttons/lever7.wav",250,100)
	Wire_TriggerOutput(self, "Ratio", self.GearRatio)
	
end

function ENT:Link( Target )

	if not IsValid( Target ) or ( Target:GetClass() ~= "prop_physics" and Target:GetClass() ~= "acf_gearbox2" and Target:GetClass() ~= "acf_gearbox" ) then
		return false, "Can only link props or gearboxes!"
	end
	
	-- Check if target is already linked
	for Key, Value in pairs( self.WheelLink ) do
		if Value == Target then 
			return false, "That is already linked to this gearbox!"
		end
	end
		
	local TargetPos = Target:GetPos()
	if Target.IsGeartrain then
		TargetPos = Target:LocalToWorld( Target.In )
	end
	
	local LinkPos = Vector( 0, 0, 0 )
	local Side = 0
	if self:WorldToLocal( TargetPos ).y < 0 then
		LinkPos = self.OutL
		Side = 0
	else
		LinkPos = self.OutR
		Side = 1
	end
	
	local DrvAngle = ( self:LocalToWorld( LinkPos ) - TargetPos ):GetNormalized():DotProduct( ( self:GetRight() * LinkPos.y ):GetNormalized() )
	if DrvAngle < 0.7 then
		return false, "Cannot link due to excessive driveshaft angle!"
	end
	
	table.insert( self.WheelLink, Target )
	table.insert( self.WheelSide, Side )
	if not self.WheelCount[Side] then self.WheelCount[Side] = 0 end
	self.WheelCount[Side] = self.WheelCount[Side] + 1
	table.insert( self.WheelAxis, Target:WorldToLocal( self:GetRight() + TargetPos ) )
	
	local RopeL = ( self:LocalToWorld( LinkPos ) - TargetPos ):Length()
	constraint.Rope( self, Target, 0, 0, LinkPos, Target:WorldToLocal( TargetPos ), RopeL, RopeL * 0.2, 0, 1, "cable/cable2", false )
	table.insert( self.WheelRopeL, RopeL )
	table.insert( self.WheelOutput, LinkPos )
	
	return true, "Link successful!"
	
end

function ENT:Unlink( Target )
	
	for Key,Value in pairs(self.WheelLink) do
		if Value == Target then
		
			local Constraints = constraint.FindConstraints(Value, "Rope")
			if Constraints then
				for Key,Rope in pairs(Constraints) do
					if Rope.Ent1 == self or Rope.Ent2 == self then
						Rope.Constraint:Remove()
					end
				end
			end
			
			if not self.WheelCount[self.WheelSide[Key]] then self.WheelCount[self.WheelSide[Key]] = 0 end
			self.WheelCount[self.WheelSide[Key]] = math.max(self.WheelCount[self.WheelSide[Key]] - 1,0)
			
			table.remove(self.WheelLink,Key)
			table.remove(self.WheelAxis,Key)
			table.remove(self.WheelSide,Key)
			table.remove(self.WheelRopeL,Key)
			table.remove(self.WheelOutput,Key)
			return true, "Unlink successful!"
		end
	end
	
	return false, "That entity is not linked to this gearbox!"

end

//Duplicator stuff

function ENT:PreEntityCopy()

	//Link Saving
	local info = {}
	local entids = {}
	for Key, Value in pairs(self.WheelLink) do					--Clean the table of any invalid entities
		if not IsValid( Value ) then
			table.remove(self.WheelLink, Key)
		end
	end
	for Key, Value in pairs(self.WheelLink) do					--Then save it
		table.insert(entids, Value:EntIndex())
	end
	
	info.entities = entids
	if info.entities then
		duplicator.StoreEntityModifier( self, "WheelLink", info )
	end
	
	//Wire dupe info
	local DupeInfo = WireLib.BuildDupeInfo(self)
	if(DupeInfo) then
		duplicator.StoreEntityModifier(self, "WireDupeInfo", DupeInfo)
	end
	
end

function ENT:PostEntityPaste( Player, Ent, CreatedEntities )

	//Link Pasting
	if (Ent.EntityMods) and (Ent.EntityMods.WheelLink) and (Ent.EntityMods.WheelLink.entities) then
		local WheelLink = Ent.EntityMods.WheelLink
		if WheelLink.entities and table.Count(WheelLink.entities) > 0 then
			for _,ID in pairs(WheelLink.entities) do
				local Linked = CreatedEntities[ ID ]
				if IsValid( Linked ) then
					self:Link( Linked )
				end
			end
		end
		Ent.EntityMods.WheelLink = nil
	end
	
	//Wire dupe info
	if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
	end

end

function ENT:OnRemove()

	for Key,Value in pairs(self.Master) do		--Let's unlink ourselves from the engines properly
		if IsValid( self.Master[Key] ) then
			self.Master[Key]:Unlink( self )
		end
	end
	
	Wire_Remove(self)
end

function ENT:OnRestore()
    Wire_Restored(self)
end



