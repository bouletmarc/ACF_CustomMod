
-- Single-cylinder engines
ACF_DefineEngine( "0.125-I1.2", {
	name = "125cc Single",
	desc = "Very Tiny bike engine",
	model = "models/engines/1cyltiny.mdl",
	sound = "acf_engines/i1_small.wav",
	category = "Single",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 7,
	torque = 11,
	flywheelmass = 0.003,
	idlerpm = 2200,
	peakminrpm = 5000,
	peakmaxrpm = 7500,
	limitrpm = 8500
} )

ACF_DefineEngine( "0.25-I1.2", {
	name = "old 250cc Single",
	desc = "Tiny bike engine",
	model = "models/engines/1cyls.mdl",
	sound = "acf_engines/i1_small.wav",
	category = "Single",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 15,
	torque = 20,
	flywheelmass = 0.005,
	idlerpm = 1200,
	peakminrpm = 4000,
	peakmaxrpm = 6500,
	limitrpm = 7500
} )

ACF_DefineEngine( "0.5-I1.2", {
	name = "old 500cc Single",
	desc = "Large single cylinder bike engine",
	model = "models/engines/1cylm.mdl",
	sound = "acf_engines/i1_medium.wav",
	category = "Single",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 20,
	torque = 40,
	flywheelmass = 0.005,
	idlerpm = 900,
	peakminrpm = 4300,
	peakmaxrpm = 7000,
	limitrpm = 8000
} )

ACF_DefineEngine( "1.3-I1.2", {
	name = "old 1300cc Single",
	desc = "Ridiculously large single cylinder engine, seriously what the fuck",
	model = "models/engines/1cylb.mdl",
	sound = "acf_engines/i1_large.wav",
	category = "Single",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 50,
	torque = 90,
	flywheelmass = 0.1,
	idlerpm = 600,
	peakminrpm = 3600,
	peakmaxrpm = 6000,
	limitrpm = 6700
} )
