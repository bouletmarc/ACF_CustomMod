
--RADIAL CUSTOM FAT

ACF_DefineEngine3( "11.0-R7C", {
	name = "11.0 R7 Petrol Custom",
	desc = "Mid range radial, thirsty and smooth, customizable",
	model = "models/engines/radial7m.mdl",
	sound = "acf_engines/R7_petrolmedium.wav",
	category = "Radial Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 350,
	modtable = {
		[1] = 950,	--torque
		[2] = 600,	--idle
		[3] = 1700,	--Peak minimum
		[4] = 3700,	--Peak maximum
		[5] = 3700,	--Limit rpm
		[6] = 1.5	--Flywheel Mass
	}
} )

ACF_DefineEngine3( "24.0-R7C", {
	name = "24.0L R7 Petrol Custom",
	desc = "The beast of Radials, this monster was destined for fighter aircraft. Customizable",
	model = "models/engines/radial7l.mdl",
	sound = "acf_engines/R7_petrollarge.wav",
	category = "Radial Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 800,
	modtable = {
		[1] = 1600,	--torque
		[2] = 750,	--idle
		[3] = 1900,	--Peak minimum
		[4] = 3000,	--Peak maximum
		[5] = 3000,	--Limit rpm
		[6] = 3	--Flywheel Mass
	}
} )
