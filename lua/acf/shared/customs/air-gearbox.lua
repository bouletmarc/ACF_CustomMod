
local MaxTqTiny = 10000
local MaxTqSmall = 25000
local MaxTqMedium =	50000
local MaxTqLarge =	100000

--AIRPLANE STRAIGHT

ACF_DefineGearboxAir( "air_gearbox-s", {
	name = "Airplane Gearbox Long Small",
	desc = "A small and light straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5small.mdl",
	category = "Airplane Gearboxes",
	weight = 100,
	maxtq = MaxTqSmall
} )

ACF_DefineGearboxAir( "air_gearbox-m", {
	name = "Airplane Gearbox Long Medium",
	desc = "A medium straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5med.mdl",
	category = "Airplane Gearboxes",
	weight = 150,
	maxtq = MaxTqMedium
} )

ACF_DefineGearboxAir( "air_gearbox-l", {
	name = "Airplane Gearbox Long Large",
	desc = "A large straight airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/t5large.mdl",
	category = "Airplane Gearboxes",
	weight = 200,
	maxtq = MaxTqLarge
} )

--AIRPLANE CLUTCH MODELS

ACF_DefineGearboxAir( "air_gearbox2-t", {
	name = "Airplane Gearbox Short Tiny",
	desc = "A  short, tiny and light airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/flywheelclutcht.mdl",
	category = "Airplane Gearboxes",
	weight = 70,
	maxtq = MaxTqTiny
} )

ACF_DefineGearboxAir( "air_gearbox2-s", {
	name = "Airplane Gearbox Short Small",
	desc = "A  short, small and light airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/flywheelclutchs.mdl",
	category = "Airplane Gearboxes",
	weight = 100,
	maxtq = MaxTqSmall
} )

ACF_DefineGearboxAir( "air_gearbox2-m", {
	name = "Airplane Gearbox Short Medium",
	desc = "A  short medium airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/flywheelclutchm.mdl",
	category = "Airplane Gearboxes",
	weight = 150,
	maxtq = MaxTqMedium
} )

ACF_DefineGearboxAir( "air_gearbox2-b", {
	name = "Airplane Gearbox Short Large",
	desc = "A  short large airplane gearbox. Used to Power a propeller.\nYou SHOULD use a gearbox to power this gearbox",
	model = "models/engines/flywheelclutchb.mdl",
	category = "Airplane Gearboxes",
	weight = 200,
	maxtq = MaxTqLarge
} )