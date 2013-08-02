
--CVT INLINE

ACF_DefineCvt( "2Gear-L-S2", {
	name = "CVT, Small",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_s.mdl",
	category = "CVT Inline",
	weight = 40,
	switch = 0.3,
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

ACF_DefineCvt( "2Gear-L-M2", {
	name = "CVT, Medium",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_m.mdl",
	category = "CVT Inline",
	weight = 80,
	switch = 0.3,
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

ACF_DefineCvt( "2Gear-L-L2", {
	name = "CVT, Large",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_l.mdl",
	category = "CVT Inline",
	weight = 120,
	switch = 0.3,
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

-- dual

ACF_DefineCvt( "2Gear-L-S2D", {
	name = "CVT, Small, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_s.mdl",
	category = "CVT Inline",
	weight = 40,
	switch = 0.3,
	maxtq = 800,
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
		[7] = 2500		--Declutch rpm
	}
} )

ACF_DefineCvt( "2Gear-L-M2D", {
	name = "CVT, Medium, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_m.mdl",
	category = "CVT Inline",
	weight = 80,
	switch = 0.3,
	maxtq = 1600,
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
		[7] = 2500		--Declutch rpm
	}
} )

ACF_DefineCvt( "2Gear-L-L2D", {
	name = "CVT, Large, Dual",
	desc = "CVT Gearbox, Automatic 1 speed",
	model = "models/engines/linear_l.mdl",
	category = "CVT Inline",
	weight = 120,
	switch = 0.3,
	maxtq = 10000,
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
		[7] = 2500		--Declutch rpm
	}
} )
