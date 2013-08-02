
--4SPEED AUTOMATIC INLINE

ACF_DefineAutomatic( "4Gear-I-MA", {
	name = "4s, Auto, Inline, Medium",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Auto Inline 4speed",
	weight = 70,
	switch = 0.1,
	maxtq = 1600,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-SA", {
	name = "4s, Auto, Inline, Small",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Auto Inline 4speed",
	weight = 40,
	switch = 0.1,
	maxtq = 800,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-LA", {
	name = "4s, Auto, Inline, Large",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Auto Inline 4speed",
	weight = 120,
	switch = 0.1,
	maxtq = 10000,
	gears = 4,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

-- Dual

ACF_DefineAutomatic( "4Gear-I-MAD", {
	name = "4s, Auto, Inline, Medium, Dual",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_m.mdl",
	category = "Auto Inline 4speed",
	weight = 70,
	switch = 0.1,
	maxtq = 1600,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-SAD", {
	name = "4s, Auto, Inline, Small, Dual",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_s.mdl",
	category = "Auto Inline 4speed",
	weight = 40,
	switch = 0.1,
	maxtq = 800,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )

ACF_DefineAutomatic( "4Gear-S-LAD", {
	name = "4s, Auto, Inline, Large, Dual",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/linear_l.mdl",
	category = "Auto Inline 4speed",
	weight = 120,
	switch = 0.1,
	maxtq = 10000,
	gears = 4,
	doubleclutch = true,
	geartable = {
		[-1] = 0.3,	--final
		[0] = 0,		--unknow
		[1] = 0.1,	--Gear1
		[2] = 0.2,	--Gear2
		[3] = 0.3,	--Gear3
		[6] = -0.1,	--Gear4 (reverse)
		[7] = 2000,	--Declutch Rpm
		[8] = 4500,	--Rpm Minimum
		[9] = 6500	--Rpm Maximum
	}
} )