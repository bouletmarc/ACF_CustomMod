
--I4 CUSTOM FAT

ACF_DefineEngine3( "16.0-I4C", {
	name = "16.0L I4 Petrol Custom",
	desc = "Giant, thirsty I4 petrol, most commonly used in boats, customizable",
	model = "models/engines/inline4l.mdl",
	sound = "acf_engines/i4_petrollarge.wav",
	category = "Inline4",
	weight = 800,
	modtable = {
		[1] = 950,	--torque
		[2] = 500,	--idle
		[3] = 1750,	--Peak minimum
		[4] = 3250,	--Peak maximum
		[5] = 3500,	--Limit rpm
		[6] = 1.5	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "15.0-I4C", {
	name = "15.0L I4 Diesel Custom",
	desc = "Small boat sized diesel, with large amounts of torque, customizable",
	model = "models/engines/inline4l.mdl",
	sound = "acf_engines/i4_diesellarge.wav",
	category = "Inline4",
	weight = 1000,
	modtable = {
		[1] = 1800,	--torque
		[2] = 300,	--idle
		[3] = 500,	--Peak minimum
		[4] = 1500,	--Peak maximum
		[5] = 2000,	--Limit rpm
		[6] = 5	--Flywheel Mass
	}
} )
