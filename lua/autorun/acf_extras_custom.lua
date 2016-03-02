//ACF unofficial extras feature inject to custom entities.
//adding Thrust to jet custom engines
//adding flame effect to jet custom engines
//adding (soon) exhausts
//adding (soon) more stuff.
//by gamerpaddy & Edited by Bouletmarc

if SERVER then
	AddCSLuaFile()

	timer.Destroy("ACFCUSTOM_E_Scan") // clear timer

	EntitiesTable = {}
	
	for k,v in pairs(ents.FindByClass("acf_engine_custom")) do
		EntitiesTable[k] = v
	end
	for k,v in pairs(ents.FindByClass("acf_engine_maker")) do
		EntitiesTable[k] = v
	end
	
	for k,v in pairs(EntitiesTable) do v.acfcustom_e_detected = false end // clear detected engines

	function acfcustom_e_scan()
		//Redo Table
		EntitiesTable = {}
		for k,v in pairs(ents.FindByClass("acf_engine_custom")) do
			EntitiesTable[k] = v
		end
		for k,v in pairs(ents.FindByClass("acf_engine_maker")) do
			EntitiesTable[k] = v
		end
		//Custom Engines
		for _,ent in pairs(EntitiesTable) do
			if ent and ent:IsValid() and string.find(ent:GetModel(), "/turbine") and not ent.acfcustom_e_detected then
				ent.acfcustom_e_detected = true
				if GetConVarNumber("sbox_max_acf_modding") > 0 then
					Wire_AdjustInputs(ent,{"Active", "Throttle", "TqAdd", "RpmAdd", "FlywheelMass", "Override", "Thrust", "Thrust Reverse", "FlameEffect", "FlameColor [VECTOR]"})
				else
					Wire_AdjustInputs(ent,{"Active", "Throttle", "Thrust", "Thrust Reverse", "FlameEffect", "FlameColor [VECTOR]"})
				end
				ent.Thrust = 0
				ent.oldPeakTorque = ent.PeakTorque
				ent.oldTriggerInput = ent.TriggerInput
				ent.TriggerInput = function(self, iname, value)
					if not self or not self:IsValid() then return end
					if iname == "Thrust" then self.Thrust = math.Clamp(value,0,100) end
					if iname == "Thrust Reverse" then self.ThrustReverse = (value == 1 and true or false) end
					if iname == "FlameEffect"   then self:SetNetworkedBool("acfcustom_e_effects", (value == 1 and true or false) ) end
					if iname == "FlameColor" then self:SetNetworkedVector("acfcustom_e_effect_color", Vector(math.Clamp(value.x or 0, 0, 255), math.Clamp(value.y or 0, 0, 255), math.Clamp(value.z or 0, 0, 255)) ) end
					self.oldTriggerInput(self, iname, value)
				end
				ent.oldThink = ent.Think
				ent.Think = function(self)
					if self and self:IsValid() then
						self.phys = self:GetPhysicsObject()
						self:SetNetworkedFloat( "acfcustom_e_thrust", (self.FlyRPM / self.LimitRPM) * ( ( self.Thrust or 0 )+50) / 100 )
						if self.Thrust ~= 0 and self.phys and self.phys:IsValid() then
							self.CalculatedThrust = ( self.phys:GetMass() * (self.FlyRPM / self.LimitRPM) ) * ((self.Thrust or 0)*50)
							//increasing torque at higher thrust formula incomming... not working right now
							//self.PeakTorque = self.oldPeakTorque - (self.oldPeakTorque * ((self.Thrust or 0)/1000))
							self.phys:ApplyForceCenter( ( (not self.ThrustReverse) and self:GetForward() or -self:GetForward() ) * self.CalculatedThrust)
						end
					end
					self.oldThink(self)
				end
			end
			
			--pulsejet mess
			if ent and ent:IsValid() and string.find(ent:GetModel(), "/pulsejet") and not ent.acfcustom_e_detected then
				ent.acfcustom_e_detected = true --inject code only once
				
				ent.oldThink = ent.Think --overwriting hooks
				ent.oldOnRemove = ent.OnRemove
				
				ent:SetBodygroup(2,0) --off state bodygroup
						
				ent.OnRemove = function(self) --overwrite ent:onremove
					if self.Sound2 then
						self.Sound2:Stop() --stop new sound on remove
					end
					self.oldOnRemove(self) --call original onremove
				end
				
				local model = ent:GetModel()
				if string.find(model,"pulsejetl.mdl") then
					ent.TraceSize = 350
					ent.SoundOffPitch=100
				elseif string.find(model,"pulsejetm.mdl") then
					ent.TraceSize = 275
					ent.SoundOffPitch=150
				elseif string.find(model,"pulsejets.mdl") then
					ent.TraceSize = 150
					ent.SoundOffPitch=200
				end
								
				ent.Think = function(self) --overwrite ent:think
					if self.Sound ~= nil then 
						self.Sound:Stop() 
						--self.Sound = nil --remove original sound obj
					end
					if self and self:IsValid() then
						self.phys = self:GetPhysicsObject()
						if self.Active ~= false and self.FlyRPM ~=0 and self.phys and self.phys:IsValid() then
							--trace to apply damage
							/*self.acfcustom_etrace = util.TraceLine({
								start = self:GetPos(),
								endpos = self:GetPos() - self:GetForward() * self.TraceSize,
								filter = self
							})
							if self.acfcustom_etrace and self.acfcustom_etrace.Entity and IsValid(self.acfcustom_etrace.Entity) and IsEntity(self.acfcustom_etrace.Entity) then
								ACFCUSTOM_E_ApplyDamage(self.acfcustom_etrace.Entity,self)
							end*/
							
							if not self.Sound3 then
								self.Sound3 = CreateSound(self,self.SoundPath) --create sound 2 when engine is on
								self.Sound3:SetSoundLevel(90)
							end
							if not self.Sound3:IsPlaying() then 
								self.Sound3:PlayEx(0.6,115) --play
							end
							if self.Sound3 then 
								self.Sound3:ChangePitch(100-(math.Clamp(self.Throttle,0,1)*5)) --pitch and volume
								self.Sound3:ChangeVolume(0.6+ (math.Clamp(self.Throttle,0,1)/2.5) )
							end
							
							self:SetNetworkedFloat( "acfcustom_e_pjet_thrust",((( math.Clamp(self.Throttle,0,1) or 0 )+0.1)) * (self.Active and 1 or 0) ) --effect size
							self:SetBodygroup(2,1) --on state bodygroup
							
							self.CalculatedThrust = ( self.phys:GetMass() * (( math.Clamp(self.Throttle,0,1) or 0)*10000) ) --thrust formula, dont laught lol
							self.phys:ApplyForceCenter( ( self:GetForward() or -self:GetForward() ) * self.CalculatedThrust) --apply formula to phys obj
						else
							self:SetNetworkedFloat( "acfcustom_e_pjet_thrust",0 ) --turn off effects
							if self.Sound3 and self.Sound3:IsPlaying() then
								//local Pitch = 100
								self.Sound3:Stop() --stop sound and remove object 
								self.Sound3 = nil
								self:EmitSound("acf_engines/pulsejetoff.wav",90,self.SoundOffPitch,0.5,0)
							end
							self:SetBodygroup(2,0) --off state bodygroup
							self:SetNetworkedFloat( "acfcustom_e_pjet_thrust",0 )
							--this is so fucked up
						end
					end
					self.oldThink(self) --call original think
				end
			end
		end
	end

	/*function ACFCUSTOM_E_ApplyDamage(ent,self) 
		if not self or not self.Owner or not ent then return end
		if(ent:IsPlayer()) then
			ent:TakeDamage(15,self.Owner,self)
		else
			ent:TakeDamage(20,self.Owner,self)
			local HitRes = {}
				
			HitRes = ACF_Damage ( ent , {Kinetic = 150,Momentum = 0,Penetration = 15} , 2 , 0 , self.Owner )
			if HitRes and HitRes.Kill then
				constraint.RemoveAll( ent )
				ent:SetParent(nil)
				ent:SetCollisionGroup( COLLISION_GROUP_NONE ) 
				local Phys = ent:GetPhysicsObject()
				Phys:EnableMotion( true )
				Phys:Wake()
			end
		end
	end*/

	acfcustom_e_scan()
	timer.Create("ACFCUSTOM_E_Scan",0.25,0,acfcustom_e_scan) // check for new engines

end --if server

if CLIENT then
	timer.Destroy("ACFCUSTOM_E_Scan") // clear timer
	local emitter = ParticleEmitter(Vector(0,0,0))
	
	EntitiesTable = {}
	
	for k,v in pairs(ents.FindByClass("acf_engine_custom")) do
		EntitiesTable[k] = v
	end
	for k,v in pairs(ents.FindByClass("acf_engine_maker")) do
		EntitiesTable[k] = v
	end
	
	for k,v in pairs(EntitiesTable) do v.acfcustom_e_detected = false end // clear detected engines

	function acfcustom_e_scan()
		//Redo Table
		EntitiesTable = {}
		for k,v in pairs(ents.FindByClass("acf_engine_custom")) do
			EntitiesTable[k] = v
		end
		for k,v in pairs(ents.FindByClass("acf_engine_maker")) do
			EntitiesTable[k] = v
		end
		//Custom Engines
		for _,ent in pairs(EntitiesTable) do
			if ent and ent:IsValid() and string.find(ent:GetModel(), "/turbine") and not ent.acfcustom_e_detected then
				ent.acfcustom_e_detected = true
				if not notifyShown then 
					LocalPlayer():ChatPrint( "Due to a bug in ACF-Extras, the newly added wire inputs can break after duplicating. Please check before use.." ) 
					notifyShown = true
				end
				ent.GetOffset = function(self)
					local Offset = Vector()
					if self and self:IsValid() then
						local model = self:GetModel()
						if string.find(model,"turbine_l.mdl") then
							Offset = Vector(-50,0,0)
							Size = 1
						elseif string.find(model,"turbine_m.mdl") then
							Offset = Vector(-35,0,0)
							Size = 0.75
						elseif string.find(model,"turbine_s.mdl") then
							Offset = Vector(-25,0,0)
							Size = 0.5
						end
						
					end
					return {Size, Offset}
				end
				
				ent.CalcNormal = function (self)
					local Offset = self:GetOffset()[2] or Vector()
					return (self:LocalToWorld(Offset) - self:GetPos()):GetNormalized()
				end
				
				ent.oldThink = ent.Think
				ent.Think = function(self)
					if self and self:IsValid() then
						if self:GetNetworkedBool("acfcustom_e_effects") then
							self.EffectSize = self:GetNetworkedFloat("acfcustom_e_thrust")
							self.EffectColor = self:GetNetworkedVector("acfcustom_e_effect_color")
						else
							self.EffectSize = 0
							self.EffectColor = Vector()
						end
						--help me!
					end
					self.oldThink(self)
				end
				
				ent.oldDraw = ent.Draw
				ent.Draw = function(self)
					if not self or not self:IsValid() then return end
					self.oldDraw(self)
					if self.EffectSize and self.EffectSize > 0 then
						self:EffectDraw_fire()
					end
				end
				ent.EffectDraw_fire = function(self)
						local Size = self:GetOffset()[1] or 1
						local Offset = self:GetOffset()[2] or Vector()
						
						if not Size then Size = 1 end
						self.SmokeTimer = self.SmokeTimer or 0
						if ( self.SmokeTimer > CurTime() ) then return end
						self.SmokeTimer = CurTime() + 0.0000005
						local vOffset = self:LocalToWorld(Offset)
						local vNormal = self:CalcNormal()
						local speed = math.Rand(90,252)
						local roll = math.Rand(-90,90)
							--------------------
						local particle = emitter:Add( "particle/fire", vOffset )
							particle:SetVelocity( vNormal * speed )
							particle:SetDieTime( (0.5*Size) * math.Clamp(self.EffectSize or 0,0,1)+0.01 )
							particle:SetStartAlpha( 255 )
							particle:SetEndAlpha( 150 )
							particle:SetStartSize( 15.8 )
							particle:SetEndSize( 9 )
							particle:SetColor( self.EffectColor.x or math.Rand(200,250), self.EffectColor.y or math.Rand(200,250), self.EffectColor.z or math.Rand(200,250) )
							particle:SetRoll( roll )
							--------------------
						local particle3 = emitter:Add( "sprites/heatwave", vOffset )
							particle3:SetVelocity( vNormal * speed )
							particle3:SetDieTime( (0.6*Size) * math.Clamp(self.EffectSize*4 or 0,0,1)+0.1 )
							particle3:SetStartAlpha( 255 )
							particle3:SetEndAlpha( 255 )
							particle3:SetStartSize( 16 )
							particle3:SetEndSize( 18 )
							particle3:SetColor( 255,255,255 )
							particle3:SetRoll( roll )
							--------------------
							vOffset = self:LocalToWorld(Offset)
						local particle2 = emitter:Add( "particle/fire", vOffset )
							particle2:SetVelocity( vNormal * speed )
							particle2:SetDieTime( (0.2*Size) * math.Clamp(self.EffectSize or 0,0,1)+0.01 )
							particle2:SetStartAlpha( 200 )
							particle2:SetEndAlpha( 50 )
							particle2:SetStartSize( 8.8 )
							particle2:SetEndSize( 5 )
							particle2:SetColor( 200,200,200 )
							particle2:SetRoll( roll )
				end
			end
			
			if ent and ent:IsValid() and string.find(ent:GetModel(), "/pulsejet") and not ent.acfcustom_e_detected then
				ent.acfcustom_e_detected = true

				ent.GetOffset = function(self)
					local Offset = Vector()
					if self and self:IsValid() then
						local model = self:GetModel()
						if string.find(model,"pulsejetl.mdl") then
							Offset = Vector(-110,0,0)
							Size = 1
						elseif string.find(model,"pulsejetm.mdl") then
							Offset = Vector(-85,0,0)
							Size = 0.75
						elseif string.find(model,"pulsejets.mdl") then
							Offset = Vector(-50,0,0)
							Size = 0.5
						end
						
					end
					return {Size, Offset}
				end
				
				ent.CalcNormal = function (self)
					local Offset = self:GetOffset()[2] or Vector()
					return (self:LocalToWorld(Offset) - self:GetPos()):GetNormalized()
				end
				
				ent.oldThink = ent.Think
				ent.Think = function(self)
					self.EffectColor = Vector(255,255,255)
					if self and self:IsValid() then
						self.EffectSize = self:GetNetworkedFloat("acfcustom_e_pjet_thrust")
					end
					self.oldThink(self)
				end
				
				ent.oldDraw = ent.Draw
				ent.Draw = function(self)
					if not self or not self:IsValid() then return end
					self.oldDraw(self)
					if self.EffectSize and self.EffectSize > 0 then
						self:EffectDraw_fire()
					end
				end
				ent.EffectDraw_fire = function(self)
						local Size = self:GetOffset()[1] or 1
						local Offset = self:GetOffset()[2] or Vector()
						
						if not Size then Size = 1 end
						self.SmokeTimer = self.SmokeTimer or 0
						if ( self.SmokeTimer > CurTime() ) then return end
						self.SmokeTimer = CurTime() + 0.0000005
						local vOffset = self:LocalToWorld(Offset)
						local vNormal = self:CalcNormal()
						local speed = math.Rand(150,352) * (self.EffectSize+1)
						local roll = math.Rand(-90,90)
							--------------------
						local particle = emitter:Add( "particle/fire", vOffset )
							particle:SetVelocity( vNormal * (speed*9) )
							particle:SetDieTime( (0.002*Size) * math.Clamp(self.EffectSize or 0,0,1)+0.01 )
							particle:SetStartAlpha( 255 )
							particle:SetEndAlpha( 200 )
							particle:SetStartSize( 15 )
							particle:SetEndSize( 45 )
							particle:SetColor( 230 , 0, 0 )
							particle:SetRoll( roll )
							--------------------
						local particle3 = emitter:Add( "particle/fire", vOffset )
							particle3:SetVelocity( vNormal * (speed*6) )
							particle3:SetDieTime( (0.002*Size) * math.Clamp(self.EffectSize*4 or 0,0,1)+0.1 )
							particle3:SetStartAlpha( 55 )
							particle3:SetEndAlpha( 20 )
							particle3:SetStartSize( 20 )
							particle3:SetEndSize( 30 )
							particle3:SetColor( 220,140,0 )
							particle3:SetRoll( roll )
							--------------------
							vOffset = self:LocalToWorld(Offset)

						local particle4 = emitter:Add( "sprites/heatwave", vOffset )
							particle4:SetVelocity( vNormal * (speed*9) )
							particle4:SetDieTime( (0.5*Size) * math.Clamp(self.EffectSize or 0,0,1)+0.01 )
							particle4:SetStartAlpha( 255 )
							particle4:SetEndAlpha( 200 )
							particle4:SetStartSize( 15.8 )
							particle4:SetEndSize( 50 )
							particle4:SetColor( 255,255,255 )
							particle4:SetRoll( roll )
				end
			end
		end
	end

	acfcustom_e_scan()
	timer.Create("ACFCUSTOM_E_Scan",0.25,0,acfcustom_e_scan) // check for new engines

end // client end