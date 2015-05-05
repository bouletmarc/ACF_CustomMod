
-- CVT (continuously variable transmission)

-- Weight
local GearCVTSW = 45
local GearCVTMW = 80
local GearCVTLW = 140

-- Torque Rating
local GearCVTST = 120
local GearCVTMT = 290 
local GearCVTLT = 650

-- general description
local CVTDesc = "\n\nA CVT will adjust the ratio its first gear to keep an engine within a target rpm range, allowing constant peak performance. However, this comes at the cost of increased weight and limited torque ratings."



-- Straight fwclutch

ACF_DefineGearbox( "CVT2-ST-S", {
	name = "CVT2, Straight, Small",
	desc = "A light duty straight-through CVT."..CVTDesc,
	model = "models/engines/flywheelclutchs.mdl",
	category = "CVT",
	weight = GearCVTSW,
	switch = 0.15,
	maxtq = GearCVTST,
	gears = 2,
	cvt = true,
	geartable = {
		[-3] = 3000, --target min rpm
        [-2] = 5000, --target max rpm
		[-1] = 1, --final drive
		[ 0 ] = 0,
		[ 1 ] = 0,
		[ 2 ] = -0.1
	}
} )

ACF_DefineGearbox( "CVT2-ST-M", {
	name = "CVT2, Straight, Medium",
	desc = "A medium straight-through CVT."..CVTDesc,
	model = "models/engines/flywheelclutchm.mdl",
	category = "CVT",
	weight = GearCVTMW,
	switch = 0.2,
	maxtq = GearCVTMT,
	gears = 2,
	cvt = true,
	geartable = {
		[-3] = 3000, --target min rpm
        [-2] = 5000, --target max rpm
		[-1] = 1, --final drive
		[ 0 ] = 0,
		[ 1 ] = 0,
		[ 2 ] = -0.1
	}
} )

ACF_DefineGearbox( "CVT2-ST-L", {
	name = "CVT2, Straight, Large",
	desc = "A massive straight-through CVT designed for high torque applications."..CVTDesc,
	model = "models/engines/flywheelclutchb.mdl",
	category = "CVT",
	weight = GearCVTLW,
	switch = 0.3,
	maxtq = GearCVTLT,
	gears = 2,
	cvt = true,
	geartable = {
		[-3] = 3000, --target min rpm
        [-2] = 5000, --target max rpm
		[-1] = 1, --final drive
		[ 0 ] = 0,
		[ 1 ] = 0,
		[ 2 ] = -0.1
	}
} )
