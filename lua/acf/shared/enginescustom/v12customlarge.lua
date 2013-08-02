
--V12 CUSTOM FAT

ACF_DefineEngine3( "9.2-V12C", {
	name = "9.2L V12 Diesel Custom",
	desc = "High torque V12, used mainly for vehicles that require balls, customizable",
	model = "models/engines/v12m.mdl",
	sound = "acf_engines/v12_dieselmedium.wav",
	category = "V12 Custom",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	requiresfuel = true,
	weight = 900,
	modtable = {
		[1] = 1000,	--torque
		[2] = 675,	--idle
		[3] = 1100,	--Peak minimum
		[4] = 3300,	--Peak maximum
		[5] = 3500,	--Limit rpm
		[6] = 2.5	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "21.0-V12C", {
	name = "21.0 V12 Diesel Custom",
	desc = "Extreme duty V12; however massively powerful, it is enormous and heavy, customizable",
	model = "models/engines/v12l.mdl",
	sound = "acf_engines/v12_diesellarge.wav",
	category = "V12 Custom",
	fuel = "Diesel",
	enginetype = "GenericDiesel",
	requiresfuel = true,
	weight = 1500,
	modtable = {
		[1] = 2800,	--torque
		[2] = 400,	--idle
		[3] = 500,	--Peak minimum
		[4] = 1500,	--Peak maximum
		[5] = 2500,	--Limit rpm
		[6] = 7	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "23.0-V12C", {
	name = "23.0 V12 Petrol Custom",
	desc = "A large, thirsty gasoline V12, likes to break down and roast crewmen, customizable",
	model = "models/engines/v12l.mdl",
	sound = "acf_engines/v12_petrollarge.wav",
	category = "V12 Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 1300,
	modtable = {
		[1] = 1800,	--torque
		[2] = 600,	--idle
		[3] = 1500,	--Peak minimum
		[4] = 3000,	--Peak maximum
		[5] = 3000,	--Limit rpm
		[6] = 5	--Flywheel Mass
	}
} )
