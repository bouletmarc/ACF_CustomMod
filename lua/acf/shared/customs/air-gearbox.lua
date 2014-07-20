
local MaxTqSmall = 25000
local MaxTqMedium =	50000
local MaxTqLarge =	100000

--AIRPLANE STRAIGHT

ACF_DefineGearboxAir( "air_gearbox-s", {
	name = "Airplane Gearbox Small",
	desc = "A small and light straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5small.mdl",
	category = "Airplane Gearboxes",
	weight = 100,
	maxtq = MaxTqSmall
} )

ACF_DefineGearboxAir( "air_gearbox-m", {
	name = "Airplane Gearbox Medium",
	desc = "A medium straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5med.mdl",
	category = "Airplane Gearboxes",
	weight = 150,
	maxtq = MaxTqMedium
} )

ACF_DefineGearboxAir( "air_gearbox-l", {
	name = "Airplane Gearbox Large",
	desc = "A large straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5large.mdl",
	category = "Airplane Gearboxes",
	weight = 200,
	maxtq = MaxTqLarge
} )