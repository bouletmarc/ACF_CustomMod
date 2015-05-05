
-- Flat 6 engines

ACF_DefineEngine( "B8-3.8", {
	name = "B8 3.8L Flat 8 Petrol",
	desc = "Car sized flat eight engine, sporty and light",
	model = "models/engines/b8small.mdl",
	sound = "acf_engines/b6_petrolsmall.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 140,
	torque = 236,
	flywheelmass = 0.08,
	idlerpm = 750,
	peakminrpm = 4300,
	peakmaxrpm = 6950,
	limitrpm = 7250
} )

ACF_DefineEngine( "B8-6.0", {
	name = "B8 5.0 Flat 8 Petrol",
	desc = "Sports car grade flat eight, renown for their smooth operation and light weight",
	model = "models/engines/b8medium.mdl",
	sound = "acf_engines/b6_petrolmedium.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 260,
	torque = 388,
	flywheelmass = 0.1,
	idlerpm = 900,
	peakminrpm = 3500,
	peakmaxrpm = 6000,
	limitrpm = 6800
} )

ACF_DefineEngine( "B8-12.0", {
	name = "B8 10.0L Flat 8 Petrol",
	desc = "Aircraft grade boxer with a high rev range biased powerband",
	model = "models/engines/b8large.mdl",
	sound = "acf_engines/b6_petrollarge.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 680,
	torque = 970,
	flywheelmass = 1,
	idlerpm = 620,
	peakminrpm = 2500,
	peakmaxrpm = 4100,
	limitrpm = 4500
} )
