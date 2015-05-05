
-- Radial engines

ACF_DefineEngine( "R3-1.2", {
	name = "R3 1.2L Petrol",
	desc = "A tiny, old worn-out radial.",
	model = "models/engines/radial3s.mdl",
	sound = "acf_engines/r7_petrolsmall.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 70,
	torque = 120,
	flywheelmass = 0.10,
	idlerpm = 710,
	peakminrpm = 2800,
	peakmaxrpm = 4600,
	limitrpm = 5000
} )

ACF_DefineEngine( "R3-5.0", {
	name = "R3 5.0 Petrol",
	desc = "Mid range radial, thirsty and smooth",
	model = "models/engines/radial3m.mdl",
	sound = "acf_engines/r7_petrolmedium.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 240,
	torque = 340,
	flywheelmass = 0.35,
	idlerpm = 700,
	peakminrpm = 2300,
	peakmaxrpm = 3800,
	limitrpm = 4000
} )

ACF_DefineEngine( "R3-11.0", {
	name = "R3 11.0L Petrol",
	desc = "Massive American radial monster, destined for aircraft and heavy things.",
	model = "models/engines/radial3b.mdl",
	sound = "acf_engines/r7_petrollarge.wav",
	category = "Radial",
	fuel = "Petrol",
	enginetype = "Radial",
	weight = 600,
	torque = 1025,
	flywheelmass = 3,
	idlerpm = 760,
	peakminrpm = 2200,
	peakmaxrpm = 3400,
	limitrpm = 3800
} )
