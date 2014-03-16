
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

--CVT INLINE

ACF_DefineCvt( "2Gear-L-S2", {
	name = "CVT, Inline, Small",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_s.mdl",
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

ACF_DefineCvt( "2Gear-L-M2", {
	name = "CVT, Inline, Medium",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_m.mdl",
	category = "CVT Custom",
	weight = 80,
	switch = 0.3,
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

ACF_DefineCvt( "2Gear-L-L2", {
	name = "CVT, Inline, Large",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_l.mdl",
	category = "CVT Custom",
	weight = 120,
	switch = 0.3,
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

-- CVT DUAL INLINE

ACF_DefineCvt( "2Gear-L-S2D", {
	name = "CVT, Inline, Small, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_s.mdl",
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

ACF_DefineCvt( "2Gear-L-M2D", {
	name = "CVT, Inline, Medium, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_m.mdl",
	category = "CVT Custom",
	weight = 80,
	switch = 0.3,
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

ACF_DefineCvt( "2Gear-L-L2D", {
	name = "CVT, Inline, Large, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_l.mdl",
	category = "CVT Custom",
	weight = 120,
	switch = 0.3,
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

--CVT DUAL TRANSAXIAL

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
