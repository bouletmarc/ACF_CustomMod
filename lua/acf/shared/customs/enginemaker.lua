
--ENGINE MAKER

ACF_DefineEngineMaker( "Maker", {
	name = "Engine from Engine Maker",
	desc = "Do not abuse setting, Make your own Engine",
	--category = "Engine Maker",
	weight = 150,
	modtable = {
		[1] = "",	--Name
		[2] = "",	--Sound
		[3] = "",	--Model
		[4] = "", 	--fuel
		[5] = "",	--enginetype
		[6] = 0,	--torque
		[7] = 0,	--idle
		[8] = 0,	--Peak minimum
		[9] = 0,	--Peak maximum
		[10] = 0,	--Limit rpm
		[11] = 0,	--Flywheel Mass
		[12] = 0,	--Weight
		[13] = 0,	--iselec
		[14] = 0,	--istrans
		[15] = 0	--Override
	}
} )
