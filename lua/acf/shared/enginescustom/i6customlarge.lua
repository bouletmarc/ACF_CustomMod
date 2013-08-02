
--I6 CUSTOM FAT

ACF_DefineEngine3( "20.0-I6C", {
	name = "20.0L I6 Diesel Custom",
	desc = "Heavy duty diesel I6, used in generators and heavy movers, customizable",
	model = "models/engines/inline6l.mdl",
	sound = "acf_engines/l6_diesellarge2.wav",
	category = "Inline6",
	weight = 1000,
	modtable = {
		[1] = 2000,	--torque
		[2] = 400,	--idle
		[3] = 500,	--Peak minimum
		[4] = 1700,	--Peak maximum
		[5] = 2250,	--Limit rpm
		[6] = 8	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "17.2-I6C", {
	name = "17.2L I6 Petrol Custom",
	desc = "Heavy tractor duty petrol I6, decent overall powerband, customizable",
	model = "models/engines/inline6l.mdl",
	sound = "acf_engines/l6_petrollarge2.wav",
	category = "Inline6",
	weight = 700,
	modtable = {
		[1] = 1200,	--torque
		[2] = 800,	--idle
		[3] = 2000,	--Peak minimum
		[4] = 3300,	--Peak maximum
		[5] = 4000,	--Limit rpm
		[6] = 2.5	--Flywheel Mass
	}
} )
