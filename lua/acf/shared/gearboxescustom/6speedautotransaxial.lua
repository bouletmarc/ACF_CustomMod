--6SPEED AUTOMATIC TRANSAXIAL

ACF_DefineAutomatic( "6Gear-T-MA", {
	name = "6s, Auto, Transaxial, Medium",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Auto Transaxial 6speed",
	weight = 70,
	switch = 0.1,
	maxtq = 1600,
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

ACF_DefineAutomatic( "6Gear-T-SA", {
	name = "6s, Auto, Transaxial, Small",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Auto Transaxial 6speed",
	weight = 40,
	switch = 0.1,
	maxtq = 800,
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
	name = "6s, Auto, Transaxial, Large",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Auto Transaxial 6speed",
	weight = 120,
	switch = 0.1,
	maxtq = 10000,
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

-- DUAL

ACF_DefineAutomatic( "6Gear-T-MAD", {
	name = "6s, Auto, Transaxial, Medium, Dual",
	desc = "A medium sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_m.mdl",
	category = "Auto Transaxial 6speed",
	weight = 70,
	switch = 0.1,
	maxtq = 1600,
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

ACF_DefineAutomatic( "6Gear-T-SAD", {
	name = "6s, Auto, Transaxial, Small, Dual",
	desc = "A Small sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_s.mdl",
	category = "Auto Transaxial 6speed",
	weight = 40,
	switch = 0.1,
	maxtq = 800,
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
	name = "6s, Auto, Transaxial, Large, Dual",
	desc = "A Large sized, 6 speed gearbox, automatic gearbox.",
	model = "models/engines/transaxial_l.mdl",
	category = "Auto Transaxial 6speed",
	weight = 120,
	switch = 0.1,
	maxtq = 10000,
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
