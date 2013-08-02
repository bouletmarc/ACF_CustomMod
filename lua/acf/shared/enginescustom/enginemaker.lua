
--ENGINE MAKER

ACF_DefineEngine5( "Maker", {
	name = "Engine from Engine Maker",
	desc = "Do not abuse setting, Make your own Engine",
	category = "Engine Maker",
	weight = 15,
	modtable = {
		[1] = "ACF_engines/v8_special.wav",	--Sound
		[2] = "models/engines/v8s.mdl",	--Model
		[3] = 250,	--torque
		[4] = 800,	--idle
		[5] = 2500,	--Peak minimum
		[6] = 6500,	--Peak maximum
		[7] = 7500,	--Limit rpm
		[8] = 0.075,	--Flywheel Mass
		[9] = 100,	--Weight
		[10] = "Engine from Engine Maker", --Name
		[11] = "Petrol", 		--fuel
		[12] = 1,				--use fuel?
		[13] = "GenericPetrol"	--enginetype
	}
} )
