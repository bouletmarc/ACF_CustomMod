
--Chips VTEC

ACF_DefineVtec( "Chip-V2", {
	name = "Chip Vtec V2",
	desc = "This chip Active the normal chip\nWith the rpm to make a VTEC",
	model = "models/jaanus/wiretool/wiretool_gate.mdl",
	category = "Chips",
	weight = 1,
	modtable = {
		[ 1 ] = 4500	--Rpm Kick
	}
} )
