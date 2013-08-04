
--I6

ACF_DefineEngine4( "6.6-I6", {
	name = "5.9L Cummins I6 Diesel",
	desc = "CUMMINS DIESEL POWER BABY!",
	model = "models/engines/inline6m.mdl",
	sound = "/engines/diesel/newdiesel.wav",
	category = "Inline 6 engines",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	requiresfuel = true,
	weight = 500,
	torque = 730,
	idlerpm = 950,
	flywheelmass = 0.9,
	peakminrpm = 1400,
	peakmaxrpm = 4400,
	limitrpm = 4700
} )

ACF_DefineEngine4( "6.3-I62", {
	name = "4.0L Mercedes Petrol",
	desc = "4.0L Mercedes Engine",
	model = "models/engines/inline6s.mdl",
	sound = "/engines/l6/mercedes-onmid.wav",
	category = "Inline 6 engines",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 200,
	torque = 330,
	idlerpm = 950,
	flywheelmass = 0.12,
	peakminrpm = 2400,
	peakmaxrpm = 6400,
	limitrpm = 6500
} )

ACF_DefineEngine4( "4.1-I62", {
	name = "4.1L Audi Petrol",
	desc = "4.1L Audi Engine",
	model = "models/engines/inline6s.mdl",
	sound = "/engines/l5/audis1_onmid.wav",
	category = "Inline 6 engines",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 210,
	torque = 350,
	idlerpm = 930,
	flywheelmass = 0.13,
	peakminrpm = 2300,
	peakmaxrpm = 6500,
	limitrpm = 6600
} )
