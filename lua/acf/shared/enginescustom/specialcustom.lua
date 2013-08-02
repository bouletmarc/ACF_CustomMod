
-- SPECIAL CUSTOM

ACF_DefineEngine2( "2.9-V8C", {
	name = "2.9L V8 Petrol",
	desc = "Racing V8, very high revving and loud",
	model = "models/engines/v8s.mdl",
	sound = "ACF_engines/v8_special.wav",
	category = "Special Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 60,
	modtable = {
		[1] = 250,	--torque
		[2] = 1000,	--idle
		[3] = 5500,	--Peak minimum
		[4] = 9000,	--Peak maximum
		[5] = 10000,	--Limit rpm
		[6] = 0.075	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "1.9L-I4C", {
	name = "1.9L I4 Petrol",
	desc = "Supercharged racing 4 cylinder, most of the power in the high revs.",
	model = "models/engines/inline4s.mdl",
	sound = "ACF_engines/i4_special.wav",
	category = "Special Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 150,
	modtable = {
		[1] = 220,	--torque
		[2] = 950,	--idle
		[3] = 5200,	--Peak minimum
		[4] = 8500,	--Peak maximum
		[5] = 9000,	--Limit rpm
		[6] = 0.06	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "3.8-I6C", {
	name = "3.8L I6 Petrol",
	desc = "Large racing straight six, powerful and high revving, but lacking in torque.",
	model = "models/engines/inline6m.mdl",
	sound = "acf_engines/l6_special.wav",
	category = "Special Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 180,
	modtable = {
		[1] = 280,	--torque
		[2] = 1100,	--idle
		[3] = 5200,	--Peak minimum
		[4] = 8500,	--Peak maximum
		[5] = 9000,	--Limit rpm
		[6] = 0.1	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "7.2-V8C", {
	name = "7.2L V8 Petrol",
	desc = "Very high revving, glorious v8 of ear rapetasticalness.",
	model = "models/engines/v8m.mdl",
	sound = "acf_engines/v8_special2.wav",
	category = "Special Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 400,
	modtable = {
		[1] = 424,	--torque
		[2] = 1000,	--idle
		[3] = 5000,	--Peak minimum
		[4] = 8500,	--Peak maximum
		[5] = 8500,	--Limit rpm
		[6] = 0.15	--Flywheel Mass
	}
} )
