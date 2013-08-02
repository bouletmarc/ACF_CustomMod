
--ENGINE CHIPS

ACF_DefineChips( "V1_Chips", {
	name = "Chip V2",
	desc = "Increase engine power",
	model = "models/jaanus/wiretool/wiretool_gate.mdl",
	category = "Chips",
	weight = 1,
	modtable = {
		[1] = 60,	--Torque Adding
		[2] = 1000,	--RpmMax Adding
		[3] = 1000	--RpmLimit Adding
	}
} )
