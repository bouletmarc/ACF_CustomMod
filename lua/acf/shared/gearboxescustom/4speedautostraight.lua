
--4SPEED STRAIGHT AUTOMATIC

ACF_DefineAutomatic( "4Gear-S-MA", {
	name = "4s, Auto, Straight, Medium",
	desc = "A medium sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5med.mdl",
	category = "Auto Straight 4speed",
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
	name = "4s, Auto, Straight, Small",
	desc = "A Small sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5small.mdl",
	category = "Auto Straight 4speed",
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
	name = "4s, Auto, Straight, Large",
	desc = "A Large sized, 4 speed gearbox, automatic gearbox.",
	model = "models/engines/t5large.mdl",
	category = "Auto Straight 4speed",
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
