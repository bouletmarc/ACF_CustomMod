E2Lib.RegisterExtension("acfcustom", true)

-- [ Helper Functions ] --

local function isEngine(ent)
	if not validPhysics(ent) then return false end
	if (ent:GetClass() == "acf_engine_custom" or ent:GetClass() == "acf_enginemaker") then return true else return false end
end

local function isGearbox(ent)
	if not validPhysics(ent) then return false end
	if (ent:GetClass() == "acf_gearbox_cvt" or ent:GetClass() == "acf_gearbox_auto") then return true else return false end
end

local function isChips(ent)
	if not validPhysics(ent) then return false end
	if (ent:GetClass() == "acf_chips" or ent:GetClass() == "acf_nos") then return true else return false end
end

local function restrictInfo(ply, ent)
	if GetConVar("sbox_acfcustom_e2restrictinfo"):GetInt() != 0 then
		if isOwner(ply, ent) then return false else return true end
	end
	return false
end

local function isLinkableACFEnt(ent)

	if not validPhysics(ent) then return false end
	
	local entClass = ent:GetClass()
	
	return ACF_E2_LinkTables[entClass] ~= nil

end

-- [General Functions ] --


__e2setcost( 1 )

-- Returns 1 if functions returning sensitive info are restricted to owned props
e2function number acfCustomInfoRestricted()
	return GetConVar("sbox_acfcustom_restrictinfo"):GetInt() or 0
end

-- Returns the short name of an ACF entity
e2function string entity:acfCustomNameShort()
	if isEngine(this) then return this.Id or "" end
	if isGearbox(this) then return this.Id or "" end
	if isChips(this) then return this.Id or "" end
	return ""
end

-- Returns 1 if an ACF engine, chips, or nos on
e2function number entity:acfCustomActive()
	if not (isEngine(this) or isChips(this)) then return 0 end
	if restrictInfo(self, this) then return 0 end
	if (this.Active) then return 1 end
	return 0
end

-- Turns an ACF engine, chips, or nos on or off
e2function void entity:acfCustomActive( number on )
	if not (isEngine(this) or isChips(this)) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Active", on)	
end

local linkTables =
{ -- link resources within each ent type.  should point to an ent: true if adding link.Ent, false to add link itself
	acf_engine_custom 		= {GearLink = true, FuelLink = false},
	acf_engine_maker 		= {GearLink = true, FuelLink = false},
	acf_gearbox_air		= {WheelLink = true, Master = false},
	acf_gearbox_cvt		= {WheelLink = true, Master = false},
	acf_gearbox_auto		= {WheelLink = true, Master = false},
	acf_chips	= {Master = false},
	acf_nos			= {Master = false}
}

local function getLinks(ent, enttype)
	local ret = {}
	-- find the link resources available for this ent type
	for entry, mode in pairs(linkTables[enttype]) do
		if not ent[entry] then error("Couldn't find link resource " .. entry .. " for entity " .. tostring(ent)) return end
		
		-- find all the links inside the resources
		for _, link in pairs(ent[entry]) do
			ret[#ret+1] = mode and link.Ent or link
		end
	end
	
	return ret
end

local function searchForGearboxLinks(ent)
	local boxes = ents.FindByClass("acf_gearbox")
	local boxes3 = ents.FindByClass("acf_gearbox_cvt")
	local boxes4 = ents.FindByClass("acf_gearbox_auto")
	
	local ret = {}
	
	for _, box in pairs(boxes) do
		if IsValid(box) then
			for _, link in pairs(box.WheelLink) do
				if link.Ent == ent then
					ret[#ret+1] = box
					break
				end
			end
		end
	end
	
	for _, box3 in pairs(boxes3) do
		if IsValid(box3) then
			for _, link in pairs(box3.WheelLink) do
				if link.Ent == ent then
					ret[#ret+1] = box3
					break
				end
			end
		end
	end
	
	for _, box4 in pairs(boxes4) do
		if IsValid(box4) then
			for _, link in pairs(box4.WheelLink) do
				if link.Ent == ent then
					ret[#ret+1] = box4
					break
				end
			end
		end
	end
	
	return ret
end

__e2setcost( 20 )

e2function array entity:acfCustomLinks()
	if not IsValid(this) then return {} end
	
	local enttype = this:GetClass()
	
	if not linkTables[enttype] then
		return searchForGearboxLinks(this)
	end
	
	return getLinks(this, enttype)
end

__e2setcost( 2 )

-- Returns the full name of an ACF entity
e2function string entity:acfCustomName()
	local acftype = ""
	if isEngine(this) then acftype = "MobilityCustom" end
	if isGearbox(this) then acftype = "MobilityCustom" end
	if isChips(this) then acftype = "MobilityCustom" end
	if (acftype == "") then return "" end
	local List = list.Get("ACFCUSTOMEnts")
	return List[acftype][this.Id]["name"] or ""
end

-- Returns the type of ACF entity
e2function string entity:acfCustomType()
	if isEngine(this) or isGearbox(this) or isChips(this) then
		local List = list.Get("ACFCUSTOMEnts")
		return List["MobilityCustom"][this.Id]["category"] or ""
	end
	return ""
end

--allows e2 to perform ACF links
e2function number entity:acfCustomLinkTo(entity target, number notify)
	if not (isLinkableACFEnt(this)) and (isOwner(self, this) and isOwner(self, target)) then
		if notify > 0 then
			ACF_SendNotify(self.player, 0, "Must be called on a gun, engine, or gearbox you own.")
		end
		return 0
	end
    
    local success, msg = this:Link(target)
    if notify > 0 then
        ACFCUSTOM_SendNotify(self.player, success, msg)
    end
    return success and 1 or 0
end

--allows e2 to perform ACF unlinks
e2function number entity:acfCustomUnlinkFrom(entity target, number notify)
	if not (isLinkableACFEnt(this)) and (isOwner(self, this) and isOwner(self, target)) then
		if notify > 0 then
			ACF_SendNotify(self.player, 0, "Must be called on a gun, engine, or gearbox you own.")
		end
		return 0
	end
    
    local success, msg = this:Unlink(target)
    if notify > 0 then
        ACFCUSTOM_SendNotify(self.player, success, msg)
    end
    return success and 1 or 0
end


-- [ Engine Functions ] --

__e2setcost( 1 )

-- Returns 1 if the entity is an ACF engine
e2function number entity:acfCustomIsEngine()
	if isEngine(this) then return 1 else return 0 end
end

-- Returns the torque in N/m of an ACF engine
e2function number entity:acfCustomMaxTorque()
	if not isEngine(this) then return 0 end
	return this.PeakTorque or 0
end

-- Returns the power in kW of an ACF engine
e2function number entity:acfCustomMaxPower()
	if not isEngine(this) then return 0 end
	local peakpower
	if this.iselec then
		peakpower = math.floor(this.PeakTorque * this.LimitRPM / (4*9548.8))
	else
		peakpower = math.floor(this.PeakTorque * this.PeakMaxRPM / 9548.8)
	end
	return peakpower or 0
end

-- Returns the idle rpm of an ACF engine
e2function number entity:acfCustomIdleRPM()
	if not isEngine(this) then return 0 end
	return this.IdleRPM or 0
end

-- Returns the powerband min of an ACF engine
e2function number entity:acfCustomPowerbandMin()
	if not isEngine(this) then return 0 end
	return this.PeakMinRPM or 0
end

-- Returns the powerband max of an ACF engine
e2function number entity:acfCustomPowerbandMax()
	if not isEngine(this) then return 0 end
	return this.PeakMaxRPM or 0
end

-- Returns the redline rpm of an ACF engine
e2function number entity:acfCustomRedline()
	if not isEngine(this) then return 0 end
	return this.LimitRPM or 0
end

-- Returns the current rpm of an ACF engine
e2function number entity:acfCustomRPM()
	if not isEngine(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return math.floor(this.FlyRPM or 0)
end

-- Returns the current torque of an ACF engine
e2function number entity:acfCustomTorque()
	if not isEngine(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return math.floor(this.Torque or 0)
end

-- Returns the current power of an ACF engine
e2function number entity:acfCustomPower()
	if not isEngine(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return math.floor((this.Torque or 0) * (this.FlyRPM or 0) / 9548.8)
end

-- Returns 1 if the RPM of an ACF engine is inside the powerband
e2function number entity:acfCustomInPowerband()
	if not isEngine(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	if (this.FlyRPM < this.PeakMinRPM) then return 0 end
	if (this.FlyRPM > this.PeakMaxRPM) then return 0 end
	return 1
end

-- Returns the throttle of an ACF engine
e2function number entity:acfCustomThrottle()
	if not isEngine(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return (this.Throttle or 0) * 100
end

__e2setcost( 5 )

-- Sets the throttle value for an ACF engine
e2function void entity:acfCustomThrottle( number throttle )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Throttle", throttle)
end

-- Sets the TorqueAdd value for an ACF engine
e2function void entity:acfCustomTqAdd( number torqueadd )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("TqAdd", torqueadd)
end

-- Sets the MaxRpmAdd value for an ACF engine
e2function void entity:acfCustomRpmAdd( number maxrpm )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("RpmAdd", maxrpm)
end

-- Sets the FlywheelMass value for an ACF engine
e2function void entity:acfCustomFlywheelMass( number flywheelmass )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("FlywheelMass", flywheelmass)
end

-- Sets the Idle value for an ACF engine
e2function void entity:acfCustomIdle( number idle )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Idle", idle)
end

-- Sets the DisableCut value for an ACF engine
e2function void entity:acfCustomDisableCut( number cutoff )
	if not isEngine(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("DisableCut", cutoff)
end


-- [ Gearbox Functions ] --


__e2setcost( 1 )

-- Returns 1 if the entity is an ACF gearbox
e2function number entity:acfCustomIsGearbox()
	if isGearbox(this) then return 1 else return 0 end
end

-- Returns the current gear for an ACF gearbox
e2function number entity:acfCustomGear()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return this.Gear or 0
end

-- Returns the number of gears for an ACF gearbox
e2function number entity:acfCustomNumGears()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return this.Gears or 0
end

-- Returns the final ratio for an ACF gearbox
e2function number entity:acfCustomFinalRatio()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return this.GearTable["Final"] or 0
end

-- Returns the total ratio (current gear * final) for an ACF gearbox
e2function number entity:acfCustomTotalRatio()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	return this.GearRatio or 0
end

-- Returns the max torque for an ACF gearbox
e2function number entity:acfCustomTorqueRating()
	if not isGearbox(this) then return 0 end
	return this.MaxTorque or 0
end

-- Returns whether an ACF gearbox is dual clutch
e2function number entity:acfCustomIsDual()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	if (this.Dual) then return 1 end
	return 0
end

-- Returns the time in ms an ACF gearbox takes to change gears
e2function number entity:acfCustomShiftTime()
	if not isGearbox(this) then return 0 end
	return (this.SwitchTime or 0) * 1000
end

-- Returns 1 if an ACF gearbox is in gear
e2function number entity:acfCustomInGear()
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	if (this.InGear) then return 1 end
	return 0
end

-- Returns the ratio for a specified gear of an ACF gearbox
e2function number entity:acfCustomGearRatio( number gear )
	if not isGearbox(this) then return 0 end
	if restrictInfo(self, this) then return 0 end
	local g = math.Clamp(math.floor(gear),1,this.Gears)
	return this.GearTable[g] or 0
end

-- Returns the current torque output for an ACF gearbox
e2function number entity:acfCustomTorqueOut()
	if not isGearbox(this) then return 0 end
	return math.min(this.TotalReqTq or 0, this.MaxTorque or 0) / (this.GearRatio or 1)
end

__e2setcost( 5 )

-- Sets the current gear for an ACF gearbox
e2function void entity:acfCustomShift( number gear )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Gear", gear)
end

-- Cause an ACF gearbox to shift up
e2function void entity:acfCustomShiftUp()
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Gear Up", 1) --doesn't need to be toggled off
end

-- Cause an ACF gearbox to shift down
e2function void entity:acfCustomShiftDown()
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Gear Down", 1) --doesn't need to be toggled off
end

-- Sets the brakes for an ACF gearbox
e2function void entity:acfCustomBrake( number brake )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Brake", brake)
end

-- Sets the left brakes for an ACF gearbox
e2function void entity:acfCustomBrakeLeft( number brake )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	if (not this.Dual) then return end
	this:TriggerInput("Left Brake", brake)
end

-- Sets the right brakes for an ACF gearbox
e2function void entity:acfCustomBrakeRight( number brake )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	if (not this.Dual) then return end
	this:TriggerInput("Right Brake", brake)
end

-- Sets the clutch for an ACF gearbox
e2function void entity:acfCustomClutch( number clutch )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	this:TriggerInput("Clutch", clutch)
end

-- Sets the left clutch for an ACF gearbox
e2function void entity:acfCustomClutchLeft( number clutch )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	if (not this.Dual) then return end
	this:TriggerInput("Left Clutch", clutch)
end

-- Sets the right clutch for an ACF gearbox
e2function void entity:acfCustomClutchRight( number clutch )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	if (not this.Dual) then return end
	this:TriggerInput("Right Clutch", clutch)
end

-- Sets the steer ratio for an ACF gearbox
e2function void entity:acfCustomSteerRate( number rate )
	if not isGearbox(this) then return end
	if not isOwner(self, this) then return end
	if (not this.DoubleDiff) then return end
	this:TriggerInput("Steer Rate", rate)
end

