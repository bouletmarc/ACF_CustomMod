
--CVT STRAIGHT

ACF_DefineCvt( "2Gear-S-S2", {
	name = "CVT, Small",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5small.mdl",
	category = "CVT Straight",
	weight = 100,
	switch = 0.6,
	maxtq = 800,
	gears = 2,
	geartable = {
		[-1] = 0.2,     --final ... removed
		[0] = 0,		--Nothing
		[1] = 0.1,		--Gear 1 ratio
		[2] = -0.1,		--Gear 2 ratio
		[3] = 0.13,		--Minimum Ratio
		[4] = 0.8,		--Maximum Ratio
		[5] = 6500,		--Max rpm
		[6] = 5500,		--Min rpm
		[7] = 2500		--Declutch rpm
	}
} )

ACF_DefineCvt( "2Gear-S-M2", {
	name = "CVT, Medium",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5med.mdl",
	category = "CVT Straight",
	weight = 140,
	switch = 0.6,
	maxtq = 1600,
	gears = 2,
	geartable = {
		[-1] = 0.2,     --final ... removed
		[0] = 0,		--Nothing
		[1] = 0.1,		--Gear 1 ratio
		[2] = -0.1,		--Gear 2 ratio
		[3] = 0.13,		--Minimum Ratio
		[4] = 0.8,		--Maximum Ratio
		[5] = 6500,		--Max rpm
		[6] = 5500,		--Min rpm
		[7] = 2500		--Declutch rpm
	}
} )

ACF_DefineCvt( "2Gear-S-L2", {
	name = "CVT, Large",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5large.mdl",
	category = "CVT Straight",
	weight = 200,
	switch = 0.6,
	maxtq = 10000,
	gears = 2,
	geartable = {
		[-1] = 0.2,     --final ... removed
		[0] = 0,		--Nothing
		[1] = 0.1,		--Gear 1 ratio
		[2] = -0.1,		--Gear 2 ratio
		[3] = 0.13,		--Minimum Ratio
		[4] = 0.8,		--Maximum Ratio
		[5] = 6500,		--Max rpm
		[6] = 5500,		--Min rpm
		[7] = 2500		--Declutch rpm
	}
} )
