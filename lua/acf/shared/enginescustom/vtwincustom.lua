
--VTWIN CUSTOM

ACF_DefineEngine2( "0.6-V2C", {
	name = "600cc V-Twin Custom",
	desc = "Twin cylinder bike engine, torquey for its size, customizable",
	model = "models/engines/v-twins.mdl",
	sound = "acf_engines/vtwin_small.wav",
	category = "V2 Engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 40,
	modtable = {
		[1] = 50,	--torque
		[2] = 900,	--idle
		[3] = 4000,	--Peak minimum
		[4] = 6500,	--Peak maximum
		[5] = 7500,	--Limit rpm
		[6] = 0.01	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "1.2-V2C", {
	name = "1200cc V-Twin Custom",
	desc = "Large displacement vtwin engine customizable",
	model = "models/engines/v-twinm.mdl",
	sound = "acf_engines/vtwin_medium.wav",
	category = "V2 Engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 60,
	modtable = {
		[1] = 85,	--torque
		[2] = 725,	--idle
		[3] = 3300,	--Peak minimum
		[4] = 5500,	--Peak maximum
		[5] = 6250,	--Limit rpm
		[6] = 0.02	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "2.4-V2C", {
	name = "2400cc V-Twin Custom",
	desc = "Huge fucking Vtwin 'MURRICA FUCK YEAH, customizable",
	model = "models/engines/v-twinb.mdl",
	sound = "acf_engines/vtwin_large.wav",
	category = "V2 Engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 120,
	modtable = {
		[1] = 160,	--torque
		[2] = 900,	--idle
		[3] = 3300,	--Peak minimum
		[4] = 5500,	--Peak maximum
		[5] = 6250,	--Limit rpm
		[6] = 0.07	--Flywheel Mass
	}
} )
