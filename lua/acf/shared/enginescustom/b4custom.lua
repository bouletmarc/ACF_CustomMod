
--PETROL BOXER4 CUSTOM

ACF_DefineEngine2( "1.4-B4C", {
	name = "1.4L Flat 4 Petrol Custom",
	desc = "Small air cooled flat four, most commonly found in nazi insects, customizable",
	model = "models/engines/b4small.mdl",
	sound = "acf_engines/b4_petrolsmall.wav",
	category = "Boxer 4",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 75,
	modtable = {
		[1] = 105,	--torque
		[2] = 700,	--idle
		[3] = 2600,	--Peak minimum
		[4] = 4550,	--Peak maximum
		[5] = 4600,	--Limit rpm
		[6] = 0.06	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "2.1-B4C", {
	name = "2.1L Flat 4 Petrol Custom",
	desc = "Tuned up flat four, probably find this in things that go fast in a desert. Customizable",
	model = "models/engines/b4small.mdl",
	sound = "acf_engines/b4_petrolmedium.wav",
	category = "Boxer 4",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 150,
	modtable = {
		[1] = 225,	--torque
		[2] = 720,	--idle
		[3] = 3000,	--Peak minimum
		[4] = 4800,	--Peak maximum
		[5] = 5000,	--Limit rpm
		[6] = 0.15	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "3.2-B4C", {
	name = "3.2L Flat 4 Petrol Custom",
	desc = "Bored out fuckswindleton batshit flat four. Fuck yourself. Customizable",
	model = "models/engines/b4med.mdl",
	sound = "acf_engines/b4_petrollarge.wav",
	category = "Boxer 4",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 200,
	modtable = {
		[1] = 375,	--torque
		[2] = 900,	--idle
		[3] = 3400,	--Peak minimum
		[4] = 5500,	--Peak maximum
		[5] = 6500,	--Limit rpm
		[6] = 0.15	--Flywheel Mass
	}
} )
