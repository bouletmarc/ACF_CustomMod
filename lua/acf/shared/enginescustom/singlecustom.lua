
--SINGLE CYLINDER CUSTOM

ACF_DefineEngine2( "0.25-I1C", {
	name = "250cc Single Custom",
	desc = "Tiny bike engine, customizable",
	model = "models/engines/1cyls.mdl",
	sound = "acf_engines/i1_small.wav",
	category = "Single Cylinder",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 15,
	modtable = {
		[1] = 41,	--torque
		[2] = 1200,	--idle
		[3] = 4000,	--Peak minimum
		[4] = 6500,	--Peak maximum
		[5] = 7500,	--Limit rpm
		[6] = 0.01	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "0.5-I1C", {
	name = "500cc Single Custom",
	desc = "Large single cylinder bike engine customizable",
	model = "models/engines/1cylm.mdl",
	sound = "acf_engines/i1_medium.wav",
	category = "Single Cylinder",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 30,
	modtable = {
		[1] = 55,	--torque
		[2] = 900,	--idle
		[3] = 4300,	--Peak minimum
		[4] = 7000,	--Peak maximum
		[5] = 8000,	--Limit rpm
		[6] = 0.01	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "1.3-I1C", {
	name = "1300cc Single Custom",
	desc = "Ridiculously large single cylinder engine, seriously what the fuck, customizable",
	model = "models/engines/1cylb.mdl",
	sound = "acf_engines/i1_large.wav",
	category = "Single Cylinder",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 55,
	modtable = {
		[1] = 90,	--torque
		[2] = 700,	--idle
		[3] = 3600,	--Peak minimum
		[4] = 6000,	--Peak maximum
		[5] = 6700,	--Limit rpm
		[6] = 0.1	--Flywheel Mass
	}
} )
