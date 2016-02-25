
-- Manual Gearboxes

-- Weight
local wmul = 1.5
local Gear4SW = 60 * wmul
local Gear4MW = 120 * wmul
local Gear4LW = 240 * wmul

local Gear6SW = 80 * wmul
local Gear6MW = 160 * wmul
local Gear6LW = 320 * wmul

local Gear8SW = 100 * wmul
local Gear8MW = 200 * wmul
local Gear8LW = 400 * wmul

-- Torque Rating
local Gear4ST = 675
local Gear4MT = 2125
local Gear4LT = 10000

local Gear6ST = 550
local Gear6MT = 1700
local Gear6LT = 10000

local Gear8ST = 425
local Gear8MT = 1250
local Gear8LT = 10000

-- Straight through bonuses
local StWB = 0.75 --straight weight bonus mulitplier
local StTB = 1.25 --straight torque bonus multiplier

-- Shift Time
local ShiftS = 0.15
local ShiftM = 0.22
local ShiftL = 0.3

-- 4 Speed
-- Inline

ACF_DefineGearboxManual( "4Gear-L-SM", {
	name = "4-Speed Manual, Inline, Small",
	desc = "A small, and light 4 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear4SW,
	switch = ShiftS,
	maxtq = Gear4ST,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-L-MM", {
	name = "4-Speed Manual, Inline, Medium",
	desc = "A medium sized, 4 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear4MW,
	switch = ShiftM,
	maxtq = Gear4MT,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-L-LM", {
	name = "4-Speed Manual, Inline, Large",
	desc = "A large, heavy and sturdy 4 speed inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear4LW,
	switch = ShiftL,
	maxtq = Gear4LT,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Inline Dual Clutch

ACF_DefineGearboxManual( "4Gear-L-SMD", {
	name = "4-Speed Manual, Inline, Small, Dual Clutch",
	desc = "A small, and light 4 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear4SW,
	switch = ShiftS,
	maxtq = Gear4ST,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-L-MMD", {
	name = "4-Speed Manual, Inline, Medium, Dual Clutch",
	desc = "A medium sized, 4 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear4MW,
	switch = ShiftM,
	maxtq = Gear4MT,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-L-LMD", {
	name = "4-Speed Manual, Inline, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 4 speed manual inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear4LW,
	switch = ShiftL,
	maxtq = Gear4LT,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial

ACF_DefineGearboxManual( "4Gear-T-SM", {
	name = "4-Speed Manual, Transaxial, Small",
	desc = "A small, and light 4 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear4SW,
	switch = ShiftS,
	maxtq = Gear4ST,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-T-MM", {
	name = "4-Speed Manual, Transaxial, Medium",
	desc = "A medium sized, 4 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear4MW,
	switch = ShiftM,
	maxtq = Gear4MT,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-T-LM", {
	name = "4-Speed Manual, Transaxial, Large",
	desc = "A large, heavy and sturdy 4 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear4LW,
	switch = ShiftL,
	maxtq = Gear4LT,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial Dual Clutch

ACF_DefineGearboxManual( "4Gear-T-SMD", {
	name = "4-Speed Manual, Transaxial, Small, Dual Clutch",
	desc = "A small, and light 4 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear4SW,
	switch = ShiftS,
	maxtq = Gear4ST,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-T-MMD", {
	name = "4-Speed Manual, Transaxial, Medium, Dual Clutch",
	desc = "A medium sized, 4 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear4MW,
	switch = ShiftM,
	maxtq = Gear4MT,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-T-LMD", {
	name = "4-Speed Manual, Transaxial, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 4 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear4LW,
	switch = ShiftL,
	maxtq = Gear4LT,
	doubleclutch = true,
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Straight-through gearboxes

ACF_DefineGearboxManual( "4Gear-ST-SM", {
	name = "4-Speed Manual, Straight, Small",
	desc = "A small straight-through manual gearbox",
	model = "models/engines/t5small.mdl",
	category = "Manual",
	weight = math.floor(Gear4SW * StWB),
	switch = ShiftS,
	maxtq = math.floor(Gear4ST * StTB),
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-ST-MM", {
	name = "4-Speed Manual, Straight, Medium",
	desc = "A medium sized, 4 speed manual straight-through gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Manual",
	weight = math.floor(Gear4MW * StWB),
	switch = ShiftM,
	maxtq = math.floor(Gear4MT * StTB),
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "4Gear-ST-LM", {
	name = "4-Speed Manual, Straight, Large",
	desc = "A large sized, 4 speed manual straight-through gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Manual",
	weight = math.floor(Gear4LW * StWB),
	switch = ShiftL,
	maxtq = math.floor(Gear4LT * StTB),
	gears = 4,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = -0.1,
		[ -1 ] = 0.5
	}
} )


-- 5 Speed
-- Inline

ACF_DefineGearboxManual( "6Gear-L-SM", {
	name = "6-Speed Manual, Inline, Small",
	desc = "A small, and light 6 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear6SW,
	switch = ShiftS,
	maxtq = Gear6ST,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-L-MM", {
	name = "6-Speed Manual, Inline, Medium",
	desc = "A medium sized, 6 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear6MW,
	switch = ShiftM,
	maxtq = Gear6MT,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-L-LM", {
	name = "6-Speed Manual, Inline, Large",
	desc = "A large, heavy and sturdy 6 speed inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear6LW,
	switch = ShiftL,
	maxtq = Gear6LT,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Inline Dual Clutch

ACF_DefineGearboxManual( "6Gear-L-SMD", {
	name = "6-Speed Manual, Inline, Small, Dual Clutch",
	desc = "A small, and light 6 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear6SW,
	switch = ShiftS,
	maxtq = Gear6ST,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-L-MMD", {
	name = "6-Speed Manual, Inline, Medium, Dual Clutch",
	desc = "A medium sized, 6 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear6MW,
	switch = ShiftM,
	maxtq = Gear6MT,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-L-LMD", {
	name = "6-Speed Manual, Inline, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 6 speed manual inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear6LW,
	switch = ShiftL,
	maxtq = Gear6LT,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial

ACF_DefineGearboxManual( "6Gear-T-SM", {
	name = "6-Speed Manual, Transaxial, Small",
	desc = "A small, and light 6 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear6SW,
	switch = ShiftS,
	maxtq = Gear6ST,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-T-MM", {
	name = "6-Speed Manual, Transaxial, Medium",
	desc = "A medium sized, 6 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear6MW,
	switch = ShiftM,
	maxtq = Gear6MT,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-T-LM", {
	name = "6-Speed Manual, Transaxial, Large",
	desc = "A large, heavy and sturdy 6 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear6LW,
	switch = ShiftL,
	maxtq = Gear6LT,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial Dual Clutch

ACF_DefineGearboxManual( "6Gear-T-SMD", {
	name = "6-Speed Manual, Transaxial, Small, Dual Clutch",
	desc = "A small, and light 6 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear6SW,
	switch = ShiftS,
	maxtq = Gear6ST,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-T-MMD", {
	name = "6-Speed Manual, Transaxial, Medium, Dual Clutch",
	desc = "A medium sized, 6 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear6MW,
	switch = ShiftM,
	maxtq = Gear6MT,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-T-LMD", {
	name = "6-Speed Manual, Transaxial, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 6 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear6LW,
	switch = ShiftL,
	maxtq = Gear6LT,
	doubleclutch = true,
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Straight-through gearboxes

ACF_DefineGearboxManual( "6Gear-ST-SM", {
	name = "6-Speed Manual, Straight, Small",
	desc = "A small straight-through manual gearbox",
	model = "models/engines/t5small.mdl",
	category = "Manual",
	weight = math.floor(Gear6SW * StWB),
	switch = ShiftS,
	maxtq = math.floor(Gear6ST * StTB),
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-ST-MM", {
	name = "6-Speed Manual, Straight, Medium",
	desc = "A medium sized, 6 speed manual straight-through gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Manual",
	weight = math.floor(Gear6MW * StWB),
	switch = ShiftM,
	maxtq = math.floor(Gear6MT * StTB),
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "6Gear-ST-LM", {
	name = "6-Speed Manual, Straight, Large",
	desc = "A large sized, 6 speed manual straight-through gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Manual",
	weight = math.floor(Gear6LW * StWB),
	switch = ShiftL,
	maxtq = math.floor(Gear6LT * StTB),
	gears = 6,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = -0.1,
		[ -1 ] = 0.5
	}
} )


-- 8 Speed
-- Inline

ACF_DefineGearboxManual( "8Gear-L-SM", {
	name = "8-Speed Manual, Inline, Small",
	desc = "A small, and light 8 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear8SW,
	switch = ShiftS,
	maxtq = Gear8ST,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-L-MM", {
	name = "8-Speed Manual, Inline, Medium",
	desc = "A medium sized, 8 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear8MW,
	switch = ShiftM,
	maxtq = Gear8MT,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-L-LM", {
	name = "8-Speed Manual, Inline, Large",
	desc = "A large, heavy and sturdy 8 speed inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear8LW,
	switch = ShiftL,
	maxtq = Gear8LT,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Inline Dual Clutch

ACF_DefineGearboxManual( "8Gear-L-SMD", {
	name = "8-Speed Manual, Inline, Small, Dual Clutch",
	desc = "A small, and light 8 speed manual inline gearbox, with a somewhat limited max torque rating",
	model = "models/engines/linear_s.mdl",
	category = "Manual",
	weight = Gear8SW,
	switch = ShiftS,
	maxtq = Gear8ST,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-L-MMD", {
	name = "8-Speed Manual, Inline, Medium, Dual Clutch",
	desc = "A medium sized, 8 speed manual inline gearbox",
	model = "models/engines/linear_m.mdl",
	category = "Manual",
	weight = Gear8MW,
	switch = ShiftM,
	maxtq = Gear8MT,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-L-LMD", {
	name = "8-Speed Manual, Inline, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 8 speed manual inline gearbox",
	model = "models/engines/linear_l.mdl",
	category = "Manual",
	weight = Gear8LW,
	switch = ShiftL,
	maxtq = Gear8LT,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial

ACF_DefineGearboxManual( "8Gear-T-SM", {
	name = "8-Speed Manual, Transaxial, Small",
	desc = "A small, and light 8 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear8SW,
	switch = ShiftS,
	maxtq = Gear8ST,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-T-MM", {
	name = "8-Speed Manual, Transaxial, Medium",
	desc = "A medium sized, 8 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear8MW,
	switch = ShiftM,
	maxtq = Gear8MT,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-T-LM", {
	name = "8-Speed Manual, Transaxial, Large",
	desc = "A large, heavy and sturdy 8 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear8LW,
	switch = ShiftL,
	maxtq = Gear8LT,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Transaxial Dual Clutch

ACF_DefineGearboxManual( "8Gear-T-SMD", {
	name = "8-Speed Manual, Transaxial, Small, Dual Clutch",
	desc = "A small, and light 8 speed manual gearbox, with a somewhat limited max torque rating",
	model = "models/engines/transaxial_s.mdl",
	category = "Manual",
	weight = Gear8SW,
	switch = ShiftS,
	maxtq = Gear8ST,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-T-MMD", {
	name = "8-Speed Manual, Transaxial, Medium, Dual Clutch",
	desc = "A medium sized, 8 speed manual gearbox",
	model = "models/engines/transaxial_m.mdl",
	category = "Manual",
	weight = Gear8MW,
	switch = ShiftM,
	maxtq = Gear8MT,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-T-LMD", {
	name = "8-Speed Manual, Transaxial, Large, Dual Clutch",
	desc = "A large, heavy and sturdy 8 speed manual gearbox",
	model = "models/engines/transaxial_l.mdl",
	category = "Manual",
	weight = Gear8LW,
	switch = ShiftL,
	maxtq = Gear8LT,
	doubleclutch = true,
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

-- Straight-through gearboxes

ACF_DefineGearboxManual( "8Gear-ST-SM", {
	name = "8-Speed Manual, Straight, Small",
	desc = "A small straight-through manual gearbox",
	model = "models/engines/t5small.mdl",
	category = "Manual",
	weight = math.floor(Gear8SW * StWB),
	switch = ShiftS,
	maxtq = math.floor(Gear8ST * StTB),
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-ST-MM", {
	name = "8-Speed Manual, Straight, Medium",
	desc = "A medium sized, 8 speed manual straight-through gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Manual",
	weight = math.floor(Gear8MW * StWB),
	switch = ShiftM,
	maxtq = math.floor(Gear8MT * StTB),
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )

ACF_DefineGearboxManual( "8Gear-ST-LM", {
	name = "8-Speed Manual, Straight, Large",
	desc = "A large sized, 8 speed manual straight-through gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Manual",
	weight = math.floor(Gear8LW * StWB),
	switch = ShiftL,
	maxtq = math.floor(Gear8LT * StTB),
	gears = 8,
	geartable = {
		[ 0 ] = 0,
		[ 1 ] = 0.1,
		[ 2 ] = 0.2,
		[ 3 ] = 0.3,
		[ 4 ] = 0.4,
		[ 5 ] = 0.5,
		[ 6 ] = 0.6,
		[ 7 ] = 0.7,
		[ 8 ] = -0.1,
		[ -1 ] = 0.5
	}
} )
