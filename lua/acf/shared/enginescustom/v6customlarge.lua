
--V6 CUSTOM FAT

ACF_DefineEngine3( "12.0-V6C", {
	name = "12.0L V6 Petrol Custom",
	desc = "Fuck duty V6, guts ripped from god himself diluted in salt and shaped into an engine./n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable",
	model = "models/engines/v6large.mdl",
	sound = "acf_engines/v6_petrollarge.wav",
	category = "V6 Custom",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 750,
	modtable = {
		[1] = 1300,	--torque
		[2] = 600,	--idle
		[3] = 1750,	--Peak minimum
		[4] = 2950,	--Peak maximum
		[5] = 3500,	--Limit rpm
		[6] = 2.5	--Flywheel Mass
	}
} )
