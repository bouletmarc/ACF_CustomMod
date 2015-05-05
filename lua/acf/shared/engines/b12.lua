
-- Flat 6 engines

ACF_DefineEngine( "B12-4.1", {
	name = "B12 4.1L Flat 12 Petrol",
	desc = "Car sized flat twelve engine, sporty and light",
	model = "models/engines/b12small.mdl",
	sound = "acf_engines/b6_petrolsmall.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 250,
	torque = 386,
	flywheelmass = 0.08,
	idlerpm = 750,
	peakminrpm = 4300,
	peakmaxrpm = 6950,
	limitrpm = 7250
} )

ACF_DefineEngine( "B12-8.0", {
	name = "B12 8.0 Flat 12 Petrol",
	desc = "Sports car grade flat twelve, renown for their smooth operation and light weight",
	model = "models/engines/b12medium.mdl",
	sound = "acf_engines/b6_petrolmedium.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 380,
	torque = 528,
	flywheelmass = 0.1,
	idlerpm = 900,
	peakminrpm = 3500,
	peakmaxrpm = 6000,
	limitrpm = 6800
} )

ACF_DefineEngine( "B12-17.0", {
	name = "B12 17.0L Flat 12 Petrol",
	desc = "Aircraft grade boxer with a high rev range biased powerband",
	model = "models/engines/b12large.mdl",
	sound = "acf_engines/b6_petrollarge.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 1050,
	torque = 1470,
	flywheelmass = 1,
	idlerpm = 620,
	peakminrpm = 2500,
	peakmaxrpm = 4100,
	limitrpm = 4500
} )
