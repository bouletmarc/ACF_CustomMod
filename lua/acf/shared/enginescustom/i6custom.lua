
--PETROL I6 CUSTOM

ACF_DefineEngine2( "2.2-I6C", {
	name = "2.2L I6 Petrol Custom",
	desc = "Car sized I6 petrol with power in the high revs, customizable",
	model = "models/engines/inline6s.mdl",
	sound = "acf_engines/l6_petrolsmall2.wav",
	category = "Inline 6",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	requiresfuel = true,
	weight = 250,
	modtable = {
		[1] = 190,	--torque
		[2] = 800,	--idle
		[3] = 4000,	--Peak minimum
		[4] = 6500,	--Peak maximum
		[5] = 7200,	--Limit rpm
		[6] = 0.1	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "4.8-I6C", {
	name = "4.8L I6 Petrol Custom",
	desc = "Light truck duty I6, good for offroad applications, customizable",
	model = "models/engines/inline6m.mdl",
	sound = "acf_engines/l6_petrolmedium.wav",
	category = "Inline 6",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 350,
	modtable = {
		[1] = 400,	--torque
		[2] = 900,	--idle
		[3] = 3500,	--Peak minimum
		[4] = 5800,	--Peak maximum
		[5] = 6500,	--Limit rpm
		[6] = 0.2	--Flywheel Mass
	}
} )
