
-- Radial engines

ACF_DefineEngine( "R9-4.1", {
	name = "R9 4.1L Petrol",
	desc = "A tiny, old worn-out radial.",
	model = "models/engines/radial9s.mdl",
	sound = "acf_engines/r9b.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 150,
	torque = 450,
	flywheelmass = 0.15,
	idlerpm = 700,
	peakminrpm = 2700,
	peakmaxrpm = 4400,
	limitrpm = 4800
} )

ACF_DefineEngine( "R9-18.5", {
	name = "R9 18.5 Petrol",
	desc = "Mid range radial, thirsty and smooth",
	model = "models/engines/radial9m.mdl",
	sound = "acf_engines/r9m.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 560,
	torque = 1500,
	flywheelmass = 0.45,
	idlerpm = 700,
	peakminrpm = 1500,
	peakmaxrpm = 2150,
	limitrpm = 2200
} )

ACF_DefineEngine( "R9-36.5", {
	name = "R9 36.5L Petrol",
	desc = "Massive American radial monster, destined for fighter aircraft and heavy tanks.",
	model = "models/engines/radial9b.mdl",
	sound = "acf_engines/r9s.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 1200,
	torque = 3205,
	flywheelmass = 1,
	idlerpm = 730,
	peakminrpm = 500,
	peakmaxrpm = 2200,
	limitrpm = 2300
} )
