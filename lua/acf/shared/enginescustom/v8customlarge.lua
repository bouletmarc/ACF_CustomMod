
--V8 CUSTOM FAT

ACF_DefineEngine3( "18.0-V8C", {
	name = "18.0L V8 Petrol Custom",
	desc = "American Ford GAA V8, decent overall power and torque and fairly lightweight, customizable",
	model = "models/engines/v8l.mdl",
	sound = "acf_engines/v8_petrollarge.wav",
	category = "V8 Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 900,
	modtable = {
		[1] = 1450,	--torque
		[2] = 600,	--idle
		[3] = 1800,	--Peak minimum
		[4] = 3000,	--Peak maximum
		[5] = 3800,	--Limit rpm
		[6] = 2.8	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "19.0-V8C", {
	name = "19.0L V8 Diesel Custom",
	desc = "Heavy duty diesel V8, used for heavy construction equipment, customizable",
	model = "models/engines/v8l.mdl",
	sound = "acf_engines/v8_diesellarge.wav",
	category = "V8 Custom",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	requiresfuel = true,
	weight = 1300,
	modtable = {
		[1] = 2400,	--torque
		[2] = 500,	--idle
		[3] = 550,	--Peak minimum
		[4] = 1650,	--Peak maximum
		[5] = 2700,	--Limit rpm
		[6] = 4.5	--Flywheel Mass
	}
} )
