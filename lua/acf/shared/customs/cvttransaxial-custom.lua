
local MaxTqSmall = 25000
local MaxTqMedium =	50000
local MaxTqLarge =	100000

--CVT Transaxial

ACF_DefineCvt( "2Gear-T-S2", {
	name = "CVT, Transaxial, Small",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_s.mdl",
	category = "CVT Custom",
	weight = 40,
	switch = 0.3,
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

ACF_DefineCvt( "2Gear-T-M2", {
	name = "CVT, Transaxial, Medium",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_m.mdl",
	category = "CVT Custom",
	weight = 70,
	switch = 0.4,
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

ACF_DefineCvt( "2Gear-T-L2", {
	name = "CVT, Transaxial, Large",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_l.mdl",
	category = "CVT Custom",
	weight = 100,
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

--dual

ACF_DefineCvt( "2Gear-T-S2D", {
	name = "CVT, Transaxial, Small, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_s.mdl",
	category = "CVT Custom",
	weight = 40,
	switch = 0.3,
	maxtq = MaxTqSmall,
	gears = 2,
	doubleclutch = true,
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

ACF_DefineCvt( "2Gear-T-M2D", {
	name = "CVT, Transaxial, Medium, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_m.mdl",
	category = "CVT Custom",
	weight = 70,
	switch = 0.4,
	maxtq = MaxTqMedium,
	gears = 2,
	doubleclutch = true,
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

ACF_DefineCvt( "2Gear-T-L2D", {
	name = "CVT, Transaxial, Large, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/transaxial_l.mdl",
	category = "CVT Custom",
	weight = 100,
	switch = 0.6,
	maxtq = MaxTqLarge,
	gears = 2,
	doubleclutch = true,
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
