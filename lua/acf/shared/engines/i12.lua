
-- Inline 12 engines

-- Petrol

ACF_DefineEngine( "4.4-I12", {
	name = "4.4L I12 Petrol",
	desc = "Incredible stupid 4.4L I12 engine made for fun",
	model = "models/engines/inline12s.mdl",
	sound = "acf_engines/i12s.wav",
	category = "I12",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 340,
	torque = 260,
	flywheelmass = 2,
	idlerpm = 400,
	peakminrpm = 2000,
	peakmaxrpm = 3250,
	limitrpm = 3500
} )

ACF_DefineEngine( "9.6-I12", {
	name = "9.6L I12 Petrol",
	desc = "Medium 9.6L I12 engine made for fun",
	model = "models/engines/inline12m.mdl",
	sound = "acf_engines/i12m.wav",
	category = "I12",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 600,
	torque = 820,
	flywheelmass = 3.4,
	idlerpm = 450,
	peakminrpm = 2000,
	peakmaxrpm = 3250,
	limitrpm = 3600
} )

ACF_DefineEngine( "30.0-I12", {
	name = "30.0L I12 Petrol",
	desc = "Oh my god 30 liters in 12 cylinders.. fuck the duck",
	model = "models/engines/inline12b.mdl",
	sound = "acf_engines/i12l.wav",
	category = "I12",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 1700,
	torque = 1920,
	flywheelmass = 5.4,
	idlerpm = 550,
	peakminrpm = 1650,
	peakmaxrpm = 2600,
	limitrpm = 2850
} )

ACF_DefineEngine( "65.0-I12", {
	name = "65.0L I12 Petrol",
	desc = "OH MY GOD, IS THIS A AN ENGINE FROM AN AIRCRAFT CARRIER?",
	model = "models/engines/inline12h.mdl",
	sound = "acf_engines/l6_petrollarge2.wav",
	category = "I12",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	weight = 3000,
	torque = 3640,
	flywheelmass = 10,
	idlerpm = 200,
	peakminrpm = 500,
	peakmaxrpm = 1000,
	limitrpm = 1100
} )

-- Diesel

ACF_DefineEngine( "6.0-I12", {
	name = "6.0L I12 Diesel",
	desc = "Tank sized I12 diesel, good, wide powerband",
	model = "models/engines/inline12s.mdl",
	sound = "acf_engines/l6_dieselsmall.wav",
	category = "I12",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	weight = 300,
	torque = 400,
	flywheelmass = 0.9,
	idlerpm = 650,
	peakminrpm = 600,
	peakmaxrpm = 1700,
	limitrpm = 2000
} )

ACF_DefineEngine( "13.0-I12", {
	name = "13.0L I12 Diesel",
	desc = "Truck duty I6, good overall powerband and torque",
	model = "models/engines/inline12m.mdl",
	sound = "acf_engines/l6_dieselmedium4.wav",
	category = "I12",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	weight = 900,
	torque = 1040,
	flywheelmass = 2,
	idlerpm = 500,
	peakminrpm = 900,
	peakmaxrpm = 2800,
	limitrpm = 3600
} )

ACF_DefineEngine( "40.0-I12", {
	name = "40.0L I12 Diesel",
	desc = "OMG 40 LITERS! This engine sucks more than my mom!",
	model = "models/engines/inline12b.mdl",
	sound = "acf_engines/l6_diesellarge2.wav",
	category = "I12",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	weight = 2400,
	torque = 4200,
	flywheelmass = 10,
	idlerpm = 350,
	peakminrpm = 450,
	peakmaxrpm = 1600,
	limitrpm = 2000
} )

ACF_DefineEngine( "80.0-I12", {
	name = "80.0L I12 Diesel",
	desc = "80 Liters, when you turn it on the world rotates in other direction!",
	model = "models/engines/inline12h.mdl",
	sound = "acf_engines/l6_diesellarge2.wav",
	category = "I12",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	weight = 4800,
	torque = 8400,
	flywheelmass = 14,
	idlerpm = 300,
	peakminrpm = 550,
	peakmaxrpm = 1700,
	limitrpm = 2100
} )