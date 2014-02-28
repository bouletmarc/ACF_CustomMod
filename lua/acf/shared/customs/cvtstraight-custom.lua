
local MaxTqSmall = 25000
local MaxTqMedium =	50000
local MaxTqLarge =	100000

--CVT STRAIGHT

ACF_DefineCvt( "2Gear-S-S2", {
	name = "CVT, Straight, Small",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5small.mdl",
	category = "CVT Custom",
	weight = 100,
	switch = 0.6,
	maxtq = MaxTqSmall,
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
		[7] = 2500,		--Declutch rpm
		[17] = 0		--Custom Gui
	}
} )

ACF_DefineCvt( "2Gear-S-M2", {
	name = "CVT, Straight, Medium",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5med.mdl",
	category = "CVT Custom",
	weight = 140,
	switch = 0.6,
	maxtq = MaxTqMedium,
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
		[7] = 2500,		--Declutch rpm
		[17] = 0		--Custom Gui
	}
} )

ACF_DefineCvt( "2Gear-S-L2", {
	name = "CVT, Straight, Large",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/t5large.mdl",
	category = "CVT Custom",
	weight = 200,
	switch = 0.6,
	maxtq = MaxTqLarge,
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
		[7] = 2500,		--Declutch rpm
		[17] = 0		--Custom Gui
	}
} )
