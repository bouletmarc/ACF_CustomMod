
-- Radial engines

ACF_DefineEngine( "R5-2.1", {
	name = "R5 2.1L Petrol",
	desc = "A tiny, old worn-out radial.",
	model = "models/engines/radial5s.mdl",
	sound = "acf_engines/r5.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 133,
	torque = 99,
	flywheelmass = 0.10,
	idlerpm = 1100,
	peakminrpm = 3500,
	peakmaxrpm = 6600,
	limitrpm = 7000
} )

ACF_DefineEngine( "R5-9.3", {
	name = "R5 9.3 Petrol",
	desc = "Mid range radial, thirsty and smooth",
	model = "models/engines/radial5m.mdl",
	sound = "acf_engines/r5.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 250,
	torque = 238,
	flywheelmass = 0.35,
	idlerpm = 650,
	peakminrpm = 2900,
	peakmaxrpm = 5500,
	limitrpm = 5750
} )

ACF_DefineEngine( "R5-19.5", {
	name = "R5 19.5L Petrol",
	desc = "Massive American radial monster, destined for fighter aircraft and heavy tanks.",
	model = "models/engines/radial5b.mdl",
	sound = "acf_engines/r5.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 400,
	torque = 590,
	flywheelmass = 3,
	idlerpm = 550,
	peakminrpm = 2500,
	peakmaxrpm = 4200,
	limitrpm = 4350
} )
