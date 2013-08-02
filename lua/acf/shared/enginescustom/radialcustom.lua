
--PETROL RADIAL CUSTOM

ACF_DefineEngine2( "3.8-R7C", {
	name = "3.8L R7 Petrol Custom",
	desc = "A tiny, old worn-out radial. Customizable",
	model = "models/engines/radial7s.mdl",
	sound = "acf_engines/R7_petrolsmall.wav",
	category = "Radial engines",
	fuel = "Petrol",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 150,
	modtable = {
		[1] = 250,	--torque
		[2] = 700,	--idle
		[3] = 2800,	--Peak minimum
		[4] = 4500,	--Peak maximum
		[5] = 5000,	--Limit rpm
		[6] = 0.15	--Flywheel Mass
	}
} )
