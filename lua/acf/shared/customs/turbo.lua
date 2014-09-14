
--ENGINE TURBO

ACF_DefineTurbo( "V1_Turbo", {
	name = "Engine Turbocharger",
	desc = "The Turbocharger is used to add power/rpm to the engine same as a real Turbocharger",
	model = "models/sem/chargers/sem_turbocharger.mdl",
	sound = "/acf_extra/vehiclefx/boost/tcl_turbo.wav",
	modtable = {
		[1] = 0.5,	--Turbo Torque/hp Slider
		[2] = "acf_extra/vehiclefx/boost/evo8_blowoff.wav"	--BOV
	}
} )
