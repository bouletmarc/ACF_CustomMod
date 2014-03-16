
--ENGINE CHIPS

ACF_DefineChips( "V3_Chips", {
	name = "Engine Performance Chip V3",
	desc = "Increase engine power",
	model = "models/jaanus/wiretool/wiretool_gate.mdl",
	weight = 1,
	modtable = {
		[1] = 60,	--Torque Adding
		[2] = 1000,	--RpmMax Adding
		[3] = 1000,	--RpmLimit Adding
		[4] = 0		--Vtec Kick Rpm
	}
} )
