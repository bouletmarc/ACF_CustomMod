
--Nos Bottle

ACF_DefineNos( "NosBottle", {
	name = "Nos Bottle",
	desc = "Increase engine power. More Torque will take more time before Usable.",
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	category = "N2O Boost Bottle",
	sound = "/ambient/machines/steam_release_2.wav",
	weight = 10,
	rpmadd = 1000,
	modtable = {
		[1] = 60	--Torque Adding
	}
} )
