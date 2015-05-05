
-- Flat 6 engines

ACF_DefineEngine( "B10-3.8", {
	name = "B10 3.8L Flat 10 Petrol",
	desc = "Car sized flat ten engine, sporty and light",
	model = "models/engines/b10small.mdl",
	sound = "acf_engines/b6_petrolsmall.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 200,
	torque = 336,
	flywheelmass = 0.08,
	idlerpm = 750,
	peakminrpm = 4300,
	peakmaxrpm = 6950,
	limitrpm = 7250
} )

ACF_DefineEngine( "B10-5.0", {
	name = "B10 5.0 Flat 10 Petrol",
	desc = "Sports car grade flat ten, renown for their smooth operation and light weight",
	model = "models/engines/b10medium.mdl",
	sound = "acf_engines/b6_petrolmedium.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 340,
	torque = 488,
	flywheelmass = 0.1,
	idlerpm = 900,
	peakminrpm = 3500,
	peakmaxrpm = 6000,
	limitrpm = 6800
} )

ACF_DefineEngine( "B10-10.0", {
	name = "B10 10.0L Flat 10 Petrol",
	desc = "Aircraft grade boxer with a high rev range biased powerband",
	model = "models/engines/b10large.mdl",
	sound = "acf_engines/b6_petrollarge.wav",
	category = "B",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 830,
	torque = 1170,
	flywheelmass = 1,
	idlerpm = 620,
	peakminrpm = 2500,
	peakmaxrpm = 4100,
	limitrpm = 4500
} )
