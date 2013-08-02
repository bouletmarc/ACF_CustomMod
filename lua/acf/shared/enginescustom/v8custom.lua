
--PETROL V8 CUSTOM

ACF_DefineEngine2( "5.7-V8C", {
	name = "5.7L V8 Petrol Custom",
	desc = "Car sized petrol engine, good power and mid range torque, customizable",
	model = "models/engines/v8s.mdl",
	sound = "acf_engines/v8_petrolsmall.wav",
	category = "V8 engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 350,
	modtable = {
		[1] = 400,	--torque
		[2] = 800,	--idle
		[3] = 3000,	--Peak minimum
		[4] = 5000,	--Peak maximum
		[5] = 6500,	--Limit rpm
		[6] = 0.15	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "9.0-V8C", {
	name = "9.0L V8 Petrol Custom",
	desc = "Thirsty, giant V8, for medium applications, customizable",
	model = "models/engines/v8m.mdl",
	sound = "acf_engines/v8_petrolmedium.wav",
	category = "V8 engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 500,
	modtable = {
		[1] = 575,	--torque
		[2] = 700,	--idle
		[3] = 3100,	--Peak minimum
		[4] = 5000,	--Peak maximum
		[5] = 5500,	--Limit rpm
		[6] = 0.25	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "5.8LS-V8C", {
	name = "5.8L LS Motor Custom",
	desc = "corvette motor, customizable",
	model = "models/engines/v8s.mdl",
	sound = "/engines/v8/corvette69-onmid.wav",
	category = "V8 engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 300,
	modtable = {
		[1] = 490,	--torque
		[2] = 1150,	--idle
		[3] = 2800,	--Peak minimum
		[4] = 5800,	--Peak maximum
		[5] = 6800,	--Limit rpm
		[6] = 0.2	--Flywheel Mass
	}
} )
