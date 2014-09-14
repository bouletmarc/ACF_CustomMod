
--ENGINE SUPERCHARGER

ACF_DefineSupercharger( "V1_Supercharger", {
	name = "Engine Supercharger",
	desc = "The Supercharger is used to add power/rpm to the engine same as a real Supercharger",
	model = "models/sem/chargers/sem_supercharger.mdl",
	sound = "acf_extra/vehiclefx/boost/supercharger.wav",
	modtable = {
		[1] = 0.5	--Supercharger Torque/hp Slider
	}
} )
