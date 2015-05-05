
-- Inline 12 engines

-- Petrol

ACF_DefineEngine( "8.4-W16", {
	name = "8.4L W16 Petrol",
	desc = "Oh yes W16 with 8.4 Liters",
	model = "models/engines/w16s.mdl",
	sound = "acf_engines/w16small.wav",
	category = "W16",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 550,
	torque = 1250,
	flywheelmass = 0.5,
	idlerpm = 1400,
	peakminrpm = 2500,
	peakmaxrpm = 7250,
	limitrpm = 8500
} )

ACF_DefineEngine( "16.4-W16", {
	name = "16.4L W16 Petrol",
	desc = "Default 16.4L W16 engine made for fun",
	model = "models/engines/w16m.mdl",
	sound = "acf_engines/w16medium.wav",
	category = "W16",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 900,
	torque = 2450,
	flywheelmass = 0.6,
	idlerpm = 1250,
	peakminrpm = 1000,
	peakmaxrpm = 6250,
	limitrpm = 7600
} )

ACF_DefineEngine( "32.8-W16", {
	name = "32.8L W16 Petrol",
	desc = "Oh my god 32.8 liters in 16 cylinders.. fuck the duck twice",
	model = "models/engines/w16b.mdl",
	sound = "acf_engines/w16large.wav",
	category = "W16",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 1700,
	torque = 3800,
	flywheelmass = 0.7,
	idlerpm = 1050,
	peakminrpm = 950,
	peakmaxrpm = 5500,
	limitrpm = 6250
} )
