
local MaxTqSmall = 25000
local MaxTqMedium =	50000
local MaxTqLarge =	100000


--4SPEED AUTOMATIC INLINE

ACF_DefineAutomatic( "4Gear-S-SA", {
	name = "4speed, Inline, Small",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-I-MA", {
	name = "4speed, Inline, Medium",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-LA", {
	name = "4speed, Inline, Large",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

-- INLINE DUAL

ACF_DefineAutomatic( "4Gear-S-SAD", {
	name = "4speed, Inline, Small, Dual",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-I-MAD", {
	name = "4speed, Inline, Medium, Dual",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-LAD", {
	name = "4speed, Inline, Large, Dual",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

--4SPEED STRAIGHT AUTOMATIC

ACF_DefineAutomatic( "4Gear-S-SA", {
	name = "4speed, Straight, Small",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5small.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-MA", {
	name = "4speed, Straight, Medium",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-LA", {
	name = "4speed, Straight, Large",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

--4SPEED AUTOMATIC TRANSAXIAL

ACF_DefineAutomatic( "4Gear-T-SA", {
	name = "4speed, Transaxial, Small",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-T-MA", {
	name = "4speed, Transaxial, Medium",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-T-LA", {
	name = "4speed, Transaxial, Large",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

-- TRANSAXIAL DUAL

ACF_DefineAutomatic( "4Gear-T-SAD", {
	name = "4speed, Transaxial, Small, Dual",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-T-MAD", {
	name = "4speed, Transaxial, Medium, Dual",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-T-LAD", {
	name = "4speed, Transaxial, Large, Dual",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )


--###############################################################################################
--6SPEED AUTOMATIC INLINE

ACF_DefineAutomatic( "6Gear-S-SA", {
	name = "6speed, Inline, Small",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-I-MA", {
	name = "6speed, Inline, Medium",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-S-LA", {
	name = "6speed, Inline, Large",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

-- 6SPEED INLINE DUAL

ACF_DefineAutomatic( "6Gear-S-SAD", {
	name = "6speed, Inline, Small, Dual",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 6,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-I-MAD", {
	name = "6speed, Inline, Medium, Dual",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 6,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-S-LAD", {
	name = "6speed, Inline, Large, Dual",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 6,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

--6SPEED STRAIGHT AUTOMATIC

ACF_DefineAutomatic( "6Gear-S-SA", {
	name = "6speed, Straight, Small",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/t5small.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-S-MA", {
	name = "6speed, Straight, Medium",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-S-LA", {
	name = "6speed, Straight, Large",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

--6SPEED AUTOMATIC TRANSAXIAL

ACF_DefineAutomatic( "6Gear-T-SA", {
	name = "6speed, Transaxial, Small",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-T-MA", {
	name = "6speed, Transaxial, Medium",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-T-LA", {
	name = "6speed, Transaxial, Large",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 6,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

-- 6SPEED TRANSAXIAL DUAL

ACF_DefineAutomatic( "6Gear-T-SAD", {
	name = "6speed, Transaxial, Small, Dual",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Automatic gearboxes",
	weight = 40,
	switch = 0.1,
	maxtq = MaxTqSmall,
	gears = 6,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-T-MAD", {
	name = "6speed, Transaxial, Medium, Dual",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Automatic gearboxes",
	weight = 70,
	switch = 0.1,
	maxtq = MaxTqMedium,
	gears = 6,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "6Gear-T-LAD", {
	name = "6speed, Transaxial, Large, Dual",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Automatic gearboxes",
	weight = 120,
	switch = 0.1,
	maxtq = MaxTqLarge,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[4] = 0.4,	--Gear4
		[5] = 0.5,	--Gear5
		[6] = -0.1,	--Gear6 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )
