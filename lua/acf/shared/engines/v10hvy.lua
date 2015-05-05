
-- Inline 12 engines

-- Petrol

ACF_DefineEngine( "20.3-V10HVY", {
	name = "20.3L V10HVY Diesel",
	desc = "Oh yes V10 Heavy with 20.3 Liters",
	model = "models/engines/v10hvys.mdl",
	sound = "acf_engines/hugev10small.wav",
	category = "Heavy V10",
	fuel = "Diesel",
	enginetype = "GenericPetrol",
	weight = 2200,
	torque = 8544,
	flywheelmass = 5.5,
	idlerpm = 200,
	peakminrpm = 450,
	peakmaxrpm = 1150,
	limitrpm = 1250
} )

ACF_DefineEngine( "50.8-V10HVY", {
	name = "50.8L V10HVY Diesel",
	desc = "huge 50.8L V10 heavy engine made for fun",
	model = "models/engines/v10hvym.mdl",
	sound = "acf_engines/hugev10medium.wav",
	category = "Heavy V10",
	fuel = "Diesel",
	enginetype = "GenericPetrol",
	weight = 4400,
	torque = 17088,
	flywheelmass = 10.6,
	idlerpm = 180,
	peakminrpm = 400,
	peakmaxrpm = 1000,
	limitrpm = 1100
} )

ACF_DefineEngine( "110.2-V10HVY", {
	name = "110.2L V10HVY Diesel",
	desc = "Oh my god 110.2 liters in 10 cylinders.. this one must be used with multiple gearboxes to handle the torque",
	model = "models/engines/v10hvyb.mdl",
	sound = "acf_engines/hugev10large.wav",
	category = "Heavy V10",
	fuel = "Diesel",
	enginetype = "GenericPetrol",
	weight = 9700,
	torque = 38440,
	flywheelmass = 15.7,
	idlerpm = 150,
	peakminrpm = 200,
	peakmaxrpm = 850,
	limitrpm = 900
} )
