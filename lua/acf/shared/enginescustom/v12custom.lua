
--PETROL V12 CUSTOM

ACF_DefineEngine2( "4.6-V12C", {
	name = "4.6L V12 Petrol Custom",
	desc = "An old racing engine; low on torque, but plenty of power, customizable",
	model = "models/engines/v12s.mdl",
	sound = "acf_engines/v12_petrolsmall.wav",
	category = "V12 engines",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 300,
	modtable = {
		[1] = 250,	--torque
		[2] = 1200,	--idle
		[3] = 1350,	--Peak minimum
		[4] = 7000,	--Peak maximum
		[5] = 8000,	--Limit rpm
		[6] = 0.2	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "7.0-V12C", {
	name = "7.0L V12 Petrol Custom",
	desc = "A high end V12; primarily found in very expensive cars, customizable",
	model = "models/engines/v12m.mdl",
	sound = "acf_engines/v12_petrolmedium.wav",
	category = "V12 engines",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 450,
	modtable = {
		[1] = 520,	--torque
		[2] = 800,	--idle
		[3] = 3600,	--Peak minimum
		[4] = 6000,	--Peak maximum
		[5] = 7500,	--Limit rpm
		[6] = 0.45	--Flywheel Mass
	}
} )
