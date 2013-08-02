
--PETROL BOXER6 CUSTOM

ACF_DefineEngine2( "2.8-B6C", {
	name = "2.8L Flat 6 Petrol Custom",
	desc = "Car sized flat six engine, sporty and light, customizable",
	model = "models/engines/b6small.mdl",
	sound = "acf_engines/b6_petrolsmall.wav",
	category = "Boxer 6",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 200,
	modtable = {
		[1] = 170,	--torque
		[2] = 750,	--idle
		[3] = 4300,	--Peak minimum
		[4] = 6950,	--Peak maximum
		[5] = 7250,	--Limit rpm
		[6] = 0.08	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "5.0-B6C", {
	name = "5.0L Flat 6 Petrol Custom",
	desc = "Sports car grade flat six, renown for their smooth operation and light weight, customizable",
	model = "models/engines/b6med.mdl",
	sound = "acf_engines/b6_petrolmedium.wav",
	category = "Boxer 6",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 275,
	modtable = {
		[1] = 360,	--torque
		[2] = 900,	--idle
		[3] = 3500,	--Peak minimum
		[4] = 6000,	--Peak maximum
		[5] = 6800,	--Limit rpm
		[6] = 0.1	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "10.0-B6C", {
	name = "10.0L Flat 6 Petrol Custom",
	desc = "Aircraft grade boxer with a high rev range biased powerband, customizable",
	model = "models/engines/b6large.mdl",
	sound = "acf_engines/b6_petrollarge.wav",
	category = "Boxer 6",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 600,
	modtable = {
		[1] = 900,	--torque
		[2] = 620,	--idle
		[3] = 2500,	--Peak minimum
		[4] = 4550,	--Peak maximum
		[5] = 4600,	--Limit rpm
		[6] = 0.95	--Flywheel Mass
	}
} )
