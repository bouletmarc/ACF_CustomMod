
-- PETROL I4 SMALL

ACF_DefineEngine2( "1.5-I4C", {
	name = "1.5L I4 Petrol Custom",
	desc = "Small car engine, not a whole lot of git, customizable",
	model = "models/engines/inline4s.mdl",
	sound = "acf_engines/i4_petrolsmall2.wav",
	category = "Inline 4",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 125,
	modtable = {
		[1] = 125,	--torque
		[2] = 900,	--idle
		[3] = 4000,	--Peak minimum
		[4] = 6500,	--Peak maximum
		[5] = 7500,	--Limit rpm
		[6] = 0.06	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "3.7-I4C", {
	name = "3.7L I4 Petrol Custom",
	desc = "Large inline 4, sees most use in light trucks, customizable",
	model = "models/engines/inline4m.mdl",
	sound = "acf_engines/i4_petrolmedium2.wav",
	category = "Inline 4",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 250,
	modtable = {
		[1] = 300,	--torque
		[2] = 900,	--idle
		[3] = 3700,	--Peak minimum
		[4] = 6000,	--Peak maximum
		[5] = 6000,	--Limit rpm
		[6] = 0.2	--Flywheel Mass
	}
} )
