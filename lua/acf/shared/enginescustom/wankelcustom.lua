
--WANKEL CUSTOM

ACF_DefineEngine2( "900cc-R-C", {
	name = "900cc Rotary",
	desc = "Small rotary engine, very high strung and suited for yard use, customizable",
	model = "models/engines/wankelsmall.mdl",
	sound = "ACF_engines/wankel_small.wav",
	category = "Wankel",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 35,
	modtable = {
		[1] = 78,	--torque
		[2] = 950,	--idle
		[3] = 4500,	--Peak minimum
		[4] = 9000,	--Peak maximum
		[5] = 9200,	--Limit rpm
		[6] = 0.06	--Flywheel Mass
	}
} )


ACF_DefineEngine2( "1.3L-R-C", {
	name = "1.3L Rotary",
	desc = "Medium Wankel for general use. Wankels have a somewhat wide powerband, but very high strung, customizable",
	model = "models/engines/wankelmed.mdl",
	sound = "ACF_engines/wankel_medium.wav",
	category = "Wankel",
	fuel = "Petrol-94",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 70,
	modtable = {
		[1] = 155,	--torque
		[2] = 950,	--idle
		[3] = 4100,	--Peak minimum
		[4] = 8500,	--Peak maximum
		[5] = 9000,	--Limit rpm
		[6] = 0.06	--Flywheel Mass
	}
} )

ACF_DefineEngine2( "2.0L-R-C", {
	name = "2.0L Rotary",
	desc = "High performance rotary engine, customizable",
	model = "models/engines/wankellarge.mdl",
	sound = "ACF_engines/wankel_large.wav",
	category = "Wankel",
	fuel = "Petrol-96",
	enginetype = "GenericPetrol",
	requiresfuel = true,
	weight = 125,
	modtable = {
		[1] = 235,	--torque
		[2] = 950,	--idle
		[3] = 4100,	--Peak minimum
		[4] = 8500,	--Peak maximum
		[5] = 9500,	--Limit rpm
		[6] = 0.1	--Flywheel Mass
	}
} )
