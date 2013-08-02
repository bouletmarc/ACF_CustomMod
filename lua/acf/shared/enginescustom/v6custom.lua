
--PETROL V6 CUSTOM

ACF_DefineEngine2( "3.6-V6C", {
	name = "3.6L V6 Petrol Custom",
	desc = "Meaty Car sized V6, lots of torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable",
	model = "models/engines/v6small.mdl",
	sound = "acf_engines/v6_petrolsmall.wav",
	category = "V6 engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 280,
	modtable = {
		[1] = 285,	--torque
		[2] = 720,	--idle
		[3] = 2200,	--Peak minimum
		[4] = 4600,	--Peak maximum
		[5] = 5500,	--Limit rpm
		[6] = 0.25	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "6.2-V6C", {
	name = "6.2L V6 Petrol Custom",
	desc = "Heavy duty v6, loaded with torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable",
	model = "models/engines/v6med.mdl",
	sound = "acf_engines/v6_petrolmedium.wav",
	category = "V6 engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 450,
	modtable = {
		[1] = 525,	--torque
		[2] = 800,	--idle
		[3] = 2200,	--Peak minimum
		[4] = 4550,	--Peak maximum
		[5] = 6000,	--Limit rpm
		[6] = 0.55	--Flywheel Mass
	}
} )
