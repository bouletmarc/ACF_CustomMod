AddCSLuaFile( "ACF/Shared/ACFMobility2List.lua" )

local Mobility2Table = {}  --Start mobility listing

			/*    THIS IS SOMES NOTES
				--> acf_engine2 = Customizable LITTLE engines
				--> acf_engine3 = No Customizable engines
				--> acf_engine4 = Customizable FAT engines
				--> acf_engine5 = Engine Maker
				--> acf_gearbox2 = CVT Gearbox's
				--> acf_gearbox3 = Automatic Gearbox's
				--> acf_chips = Engines Chips ( TqAdd, MaxRpmAdd, LimitRpmAdd )
				--> acf_vtec = VTEC chips ( Rpm )
				
				
			*/

--###################################################################################################################################
-- Customizable Engines SMALL

--Special engines
local Engine29V8C = {}
	Engine29V8C.id = "2.9-V8C"
	Engine29V8C.ent = "acf_engine2"
	Engine29V8C.type = "Mobility2"
	Engine29V8C.name = "2.9L V8 Petrol"
	Engine29V8C.desc = "Racing V8, very high revving and loud"
	Engine29V8C.model = "models/engines/v8s.mdl"
	Engine29V8C.sound = "ACF_engines/v8_special.wav"
	Engine29V8C.category = "Special Custom"
	Engine29V8C.weight = 180
	Engine29V8C.modtable = {}
		Engine29V8C.modtable[1] = 250	--torque
		Engine29V8C.modtable[2] = 1000	--idle
		Engine29V8C.modtable[3] = 5500	--Peak minimum
		Engine29V8C.modtable[4] = 9000	--Peak maximum
		Engine29V8C.modtable[5] = 10000	--Limit rpm
		Engine29V8C.modtable[6] = 0.075	--Flywheel Mass
	if ( CLIENT ) then
		Engine29V8C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine29V8C.guiupdate = function() return end
	end
Mobility2Table["2.9-V8C"] = Engine29V8C

local Engine130V12C = {}
	Engine130V12C.id = "13.0-V12C"
	Engine130V12C.ent = "acf_engine2"
	Engine130V12C.type = "Mobility2"
	Engine130V12C.name = "13.0L V12 Petrol"
	Engine130V12C.desc = "Thirsty gasoline v12, good torque and power for medium applications."
	Engine130V12C.model = "models/engines/v12m.mdl"
	Engine130V12C.sound = "ACF_engines/v12_special.wav"
	Engine130V12C.category = "Special Custom"
	Engine130V12C.weight = 520
	Engine130V12C.modtable = {}
		Engine130V12C.modtable[1] = 750	--torque
		Engine130V12C.modtable[2] = 700	--idle
		Engine130V12C.modtable[3] = 2500	--Peak minimum
		Engine130V12C.modtable[4] = 4000	--Peak maximum
		Engine130V12C.modtable[5] = 4000	--Limit rpm
		Engine130V12C.modtable[6] = 1	--Flywheel Mass
	if ( CLIENT ) then
		Engine130V12C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine130V12C.guiupdate = function() return end
	end
Mobility2Table["13.0-V12C"] = Engine130V12C

local Engine19I4C= {}
	Engine19I4C.id = "1.9L-I4C"
	Engine19I4C.ent = "acf_engine2"
	Engine19I4C.type = "Mobility2"
	Engine19I4C.name = "1.9L I4 Petrol"
	Engine19I4C.desc = "Supercharged racing 4 cylinder, most of the power in the high revs."
	Engine19I4C.model = "models/engines/inline4s.mdl"
	Engine19I4C.sound = "ACF_engines/i4_special.wav"
	Engine19I4C.category = "Special Custom"
	Engine19I4C.weight = 150
	Engine19I4C.modtable = {}
		Engine19I4C.modtable[1] = 220	--torque
		Engine19I4C.modtable[2] = 950	--idle
		Engine19I4C.modtable[3] = 5200	--Peak minimum
		Engine19I4C.modtable[4] = 8500	--Peak maximum
		Engine19I4C.modtable[5] = 9000	--Limit rpm
		Engine19I4C.modtable[6] = 0.06	--Flywheel Mass
	if ( CLIENT ) then
		Engine19I4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine19I4C.guiupdate = function() return end
	end
Mobility2Table["1.9L-I4C"] = Engine19I4C


-- Spankels
local Engine9Wankel= {}
	Engine9Wankel.id = "900cc-R-C"
	Engine9Wankel.ent = "acf_engine2"
	Engine9Wankel.type = "Mobility2"
	Engine9Wankel.name = "900cc Rotary"
	Engine9Wankel.desc = "Small rotary engine, very high strung and suited for yard use, customizable"
	Engine9Wankel.model = "models/engines/emotorsmall2.mdl"
	Engine9Wankel.sound = "ACF_engines/wankel_small.wav"
	Engine9Wankel.category = "Wankel"
	Engine9Wankel.weight = 35
	Engine9Wankel.modtable = {}
		Engine9Wankel.modtable[1] = 78	--torque
		Engine9Wankel.modtable[2] = 950	--idle
		Engine9Wankel.modtable[3] = 4500	--Peak minimum
		Engine9Wankel.modtable[4] = 9000	--Peak maximum
		Engine9Wankel.modtable[5] = 9200	--Limit rpm
		Engine9Wankel.modtable[6] = 0.06	--Flywheel Mass
	if ( CLIENT ) then
		Engine9Wankel.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine9Wankel.guiupdate = function() return end
	end
Mobility2Table["900cc-R-C"] = Engine9Wankel

local Engine13Wankel= {}
	Engine13Wankel.id = "1.3L-R-C"
	Engine13Wankel.ent = "acf_engine2"
	Engine13Wankel.type = "Mobility2"
	Engine13Wankel.name = "1.3L Rotary"
	Engine13Wankel.desc = "Medium Wankel for general use. Wankels have a somewhat wide powerband, but very high strung, customizable"
	Engine13Wankel.model = "models/engines/emotorsmall2.mdl"
	Engine13Wankel.sound = "ACF_engines/wankel_medium.wav"
	Engine13Wankel.category = "Wankel"
	Engine13Wankel.weight = 70
	Engine13Wankel.modtable = {}
		Engine13Wankel.modtable[1] = 155		--torque
		Engine13Wankel.modtable[2] = 950	--idle
		Engine13Wankel.modtable[3] = 4100	--Peak minimum
		Engine13Wankel.modtable[4] = 8500	--Peak maximum
		Engine13Wankel.modtable[5] = 9000	--Limit rpm
		Engine13Wankel.modtable[6] = 0.06	--Flywheel Mass
	if ( CLIENT ) then
		Engine13Wankel.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine13Wankel.guiupdate = function() return end
	end
Mobility2Table["1.3L-R-C"] = Engine13Wankel

local Engine20Wankel= {}
	Engine20Wankel.id = "2.0L-R-C"
	Engine20Wankel.ent = "acf_engine2"
	Engine20Wankel.type = "Mobility2"
	Engine20Wankel.name = "2.0L Rotary"
	Engine20Wankel.desc = "High performance rotary engine, customizable"
	Engine20Wankel.model = "models/engines/emotormed2.mdl"
	Engine20Wankel.sound = "ACF_engines/wankel_large.wav"
	Engine20Wankel.category = "Wankel"
	Engine20Wankel.weight = 125
	Engine20Wankel.modtable = {}
		Engine20Wankel.modtable[1] = 235		--torque
		Engine20Wankel.modtable[2] = 950	--idle
		Engine20Wankel.modtable[3] = 4100	--Peak minimum
		Engine20Wankel.modtable[4] = 8500	--Peak maximum
		Engine20Wankel.modtable[5] = 9500	--Limit rpm
		Engine20Wankel.modtable[6] = 0.1	--Flywheel Mass
	if ( CLIENT ) then
		Engine20Wankel.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine20Wankel.guiupdate = function() return end
	end
Mobility2Table["2.0L-R-C"] = Engine20Wankel

--Single cylinders
local Engine2I1C = {}
	Engine2I1C.id = "0.25-I1C"
	Engine2I1C.ent = "acf_engine2"
	Engine2I1C.type = "Mobility2"
	Engine2I1C.name = "250cc Single Custom"
	Engine2I1C.desc = "Tiny bike engine, customizable"
	Engine2I1C.model = "models/engines/1cyls.mdl"
	Engine2I1C.sound = "acf_engines/i1_small.wav"
	Engine2I1C.category = "Single Cylinder"
	Engine2I1C.weight = 15
	Engine2I1C.vtec = false
	Engine2I1C.modtable = {}
		Engine2I1C.modtable[1] = 41		--torque
		Engine2I1C.modtable[2] = 1200	--idle
		Engine2I1C.modtable[3] = 4000	--Peak minimum
		Engine2I1C.modtable[4] = 6500	--Peak maximum
		Engine2I1C.modtable[5] = 7500	--Limit rpm
		Engine2I1C.modtable[6] = 0.01	--Flywheel Mass
	if ( CLIENT ) then
		Engine2I1C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine2I1C.guiupdate = function() return end
	end
Mobility2Table["0.25-I1C"] = Engine2I1C

local Engine5I1C = {}
	Engine5I1C.id = "0.5-I1C"
	Engine5I1C.ent = "acf_engine2"
	Engine5I1C.type = "Mobility2"
	Engine5I1C.name = "500cc Single Custom"
	Engine5I1C.desc = "Large single cylinder bike engine customizable"
	Engine5I1C.model = "models/engines/1cylm.mdl"
	Engine5I1C.sound = "acf_engines/i1_medium.wav"
	Engine5I1C.category = "Single Cylinder"
	Engine5I1C.weight = 30
	Engine5I1C.vtec = false
	Engine5I1C.modtable = {}
		Engine5I1C.modtable[1] = 55		--torque
		Engine5I1C.modtable[2] = 900		--idle
		Engine5I1C.modtable[3] = 4300	--Peak minimum
		Engine5I1C.modtable[4] = 7000	--Peak maximum
		Engine5I1C.modtable[5] = 8000	--Limit rpm
		Engine5I1C.modtable[6] = 0.01	--Flywheel Mass
	if ( CLIENT ) then
		Engine5I1C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine5I1C.guiupdate = function() return end
	end
Mobility2Table["0.5-I1C"] = Engine5I1C

local Engine13I1C = {}
	Engine13I1C.id = "1.3-I1C"
	Engine13I1C.ent = "acf_engine2"
	Engine13I1C.type = "Mobility2"
	Engine13I1C.name = "1300cc Single Custom"
	Engine13I1C.desc = "Ridiculously large single cylinder engine, seriously what the fuck, customizable"
	Engine13I1C.model = "models/engines/1cylb.mdl"
	Engine13I1C.sound = "acf_engines/i1_large.wav"
	Engine13I1C.category = "Single Cylinder"
	Engine13I1C.weight = 55
	Engine13I1C.vtec = false
	Engine13I1C.modtable = {}
		Engine13I1C.modtable[1] = 90		--torque
		Engine13I1C.modtable[2] = 700		--idle
		Engine13I1C.modtable[3] = 3600	--Peak minimum
		Engine13I1C.modtable[4] = 6000	--Peak maximum
		Engine13I1C.modtable[5] = 6700	--Limit rpm
		Engine13I1C.modtable[6] = 0.1	--Flywheel Mass
	if ( CLIENT ) then
		Engine13I1C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine13I1C.guiupdate = function() return end
	end
Mobility2Table["1.3-I1C"] = Engine13I1C

--Vtwins
local Engine6V2C = {}
	Engine6V2C.id = "0.6-V2C"
	Engine6V2C.ent = "acf_engine2"
	Engine6V2C.type = "Mobility2"
	Engine6V2C.name = "600cc V-Twin Custom"
	Engine6V2C.desc = "Twin cylinder bike engine, torquey for its size, customizable"
	Engine6V2C.model = "models/engines/v-twins.mdl"
	Engine6V2C.sound = "acf_engines/vtwin_small.wav"
	Engine6V2C.category = "V2 Engines"
	Engine6V2C.weight = 40
	Engine6V2C.vtec = false
	Engine6V2C.modtable = {}
		Engine6V2C.modtable[1] = 50		--torque
		Engine6V2C.modtable[2] = 900		--idle
		Engine6V2C.modtable[3] = 4000	--Peak minimum
		Engine6V2C.modtable[4] = 6500	--Peak maximum
		Engine6V2C.modtable[5] = 7500	--Limit rpm
		Engine6V2C.modtable[6] = 0.01	--Flywheel Mass
	if ( CLIENT ) then
		Engine6V2C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine6V2C.guiupdate = function() return end
	end
Mobility2Table["0.6-V2C"] = Engine6V2C

local Engine12V2C = {}
	Engine12V2C.id = "1.2-V2C"
	Engine12V2C.ent = "acf_engine2"
	Engine12V2C.type = "Mobility2"
	Engine12V2C.name = "1200cc V-Twin Custom"
	Engine12V2C.desc = "Large displacement vtwin engine customizable"
	Engine12V2C.model = "models/engines/v-twinm.mdl"
	Engine12V2C.sound = "acf_engines/vtwin_medium.wav"
	Engine12V2C.category = "V2 Engines"
	Engine12V2C.weight = 60
	Engine12V2C.vtec = false
	Engine12V2C.modtable = {}
		Engine12V2C.modtable[1] = 85		--torque
		Engine12V2C.modtable[2] = 725		--idle
		Engine12V2C.modtable[3] = 3300	--Peak minimum
		Engine12V2C.modtable[4] = 5500	--Peak maximum
		Engine12V2C.modtable[5] = 6250	--Limit rpm
		Engine12V2C.modtable[6] = 0.02	--Flywheel Mass
	if ( CLIENT ) then
		Engine12V2C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine12V2C.guiupdate = function() return end
	end
Mobility2Table["1.2-V2C"] = Engine12V2C

local Engine24V2C = {}
	Engine24V2C.id = "2.4-V2C"
	Engine24V2C.ent = "acf_engine2"
	Engine24V2C.type = "Mobility2"
	Engine24V2C.name = "2400cc V-Twin Custom"
	Engine24V2C.desc = "Huge fucking Vtwin 'MURRICA FUCK YEAH, customizable"
	Engine24V2C.model = "models/engines/v-twinb.mdl"
	Engine24V2C.sound = "acf_engines/vtwin_large.wav"
	Engine24V2C.category = "V2 Engines"
	Engine24V2C.weight = 120
	Engine24V2C.vtec = false
	Engine24V2C.modtable = {}
		Engine24V2C.modtable[1] = 160	--torque
		Engine24V2C.modtable[2] = 900	--idle
		Engine24V2C.modtable[3] = 3300	--Peak minimum
		Engine24V2C.modtable[4] = 5500	--Peak maximum
		Engine24V2C.modtable[5] = 6250	--Limit rpm
		Engine24V2C.modtable[6] = 0.07	--Flywheel Mass
	if ( CLIENT ) then
		Engine24V2C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine24V2C.guiupdate = function() return end
	end
Mobility2Table["2.4-V2C"] = Engine24V2C

-- Petrol I4s
local Engine15I4C = {}
	Engine15I4C.id = "1.5-I4C"
	Engine15I4C.ent = "acf_engine2"
	Engine15I4C.type = "Mobility2"
	Engine15I4C.name = "1.5L I4 Petrol Custom"
	Engine15I4C.desc = "Small car engine, not a whole lot of git, customizable"
	Engine15I4C.model = "models/engines/inline4s.mdl"
	Engine15I4C.sound = "ACF_engines/i4_petrolsmall2.wav"
	Engine15I4C.category = "Inline 4"
	Engine15I4C.weight = 125
	Engine15I4C.vtec = false
	Engine15I4C.modtable = {}
		Engine15I4C.modtable[1] = 125	--torque
		Engine15I4C.modtable[2] = 900	--idle
		Engine15I4C.modtable[3] = 4000	--Peak minimum
		Engine15I4C.modtable[4] = 6500	--Peak maximum
		Engine15I4C.modtable[5] = 7500	--Limit rpm
		Engine15I4C.modtable[6] = 0.06	--Flywheel Mass
	if ( CLIENT ) then
		Engine15I4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine15I4C.guiupdate = function() return end
	end
Mobility2Table["1.5-I4C"] = Engine15I4C

local Engine37I4C = {}
	Engine37I4C.id = "3.7-I4C"
	Engine37I4C.ent = "acf_engine2"
	Engine37I4C.type = "Mobility2"
	Engine37I4C.name = "3.7L I4 Petrol Custom"
	Engine37I4C.desc = "Large inline 4, sees most use in light trucks, customizable"
	Engine37I4C.model = "models/engines/inline4m.mdl"
	Engine37I4C.sound = "ACF_engines/i4_petrolmedium2.wav"
	Engine37I4C.category = "Inline 4"
	Engine37I4C.weight = 250
	Engine37I4C.vtec = false
	Engine37I4C.modtable = {}
		Engine37I4C.modtable[1] = 300	--torque
		Engine37I4C.modtable[2] = 900	--idle
		Engine37I4C.modtable[3] = 3700	--Peak minimum
		Engine37I4C.modtable[4] = 6000	--Peak maximum
		Engine37I4C.modtable[5] = 6000	--Limit rpm
		Engine37I4C.modtable[6] = 0.2	--Flywheel Mass
	if ( CLIENT ) then
		Engine37I4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine37I4C.guiupdate = function() return end
	end
Mobility2Table["3.7-I4C"] = Engine37I4C

--Petrol Boxer 4s
local Engine14B4C = {}
	Engine14B4C.id = "1.4-B4C"
	Engine14B4C.ent = "acf_engine2"
	Engine14B4C.type = "Mobility2"
	Engine14B4C.name = "1.4L Flat 4 Petrol Custom"
	Engine14B4C.desc = "Small air cooled flat four, most commonly found in nazi insects, customizable"
	Engine14B4C.model = "models/engines/b4small.mdl"
	Engine14B4C.sound = "ACF_engines/b4_petrolsmall.wav"
	Engine14B4C.category = "Boxer 4"
	Engine14B4C.weight = 75
	Engine14B4C.vtec = false
	Engine14B4C.modtable = {}
		Engine14B4C.modtable[1] = 105	--torque
		Engine14B4C.modtable[2] = 700	--idle
		Engine14B4C.modtable[3] = 2600	--Peak minimum
		Engine14B4C.modtable[4] = 4550	--Peak maximum
		Engine14B4C.modtable[5] = 4600	--Limit rpm
		Engine14B4C.modtable[6] = 0.06	--Flywheel Mass
	if ( CLIENT ) then
		Engine14B4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine14B4C.guiupdate = function() return end
	end
Mobility2Table["1.4-B4C"] = Engine14B4C

local Engine21B4C = {}
	Engine21B4C.id = "2.1-B4C"
	Engine21B4C.ent = "acf_engine2"
	Engine21B4C.type = "Mobility2"
	Engine21B4C.name = "2.1L Flat 4 Petrol Custom"
	Engine21B4C.desc = "Tuned up flat four, probably find this in things that go fast in a desert. Customizable"
	Engine21B4C.model = "models/engines/b4small.mdl"
	Engine21B4C.sound = "ACF_engines/b4_petrolmedium.wav"
	Engine21B4C.category = "Boxer 4"
	Engine21B4C.weight = 150
	Engine21B4C.vtec = false
	Engine21B4C.modtable = {}
		Engine21B4C.modtable[1] = 225	--torque
		Engine21B4C.modtable[2] = 720	--idle
		Engine21B4C.modtable[3] = 3000	--Peak minimum
		Engine21B4C.modtable[4] = 4800	--Peak maximum
		Engine21B4C.modtable[5] = 5000	--Limit rpm
		Engine21B4C.modtable[6] = 0.15	--Flywheel Mass
	if ( CLIENT ) then
		Engine21B4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine21B4C.guiupdate = function() return end
	end
Mobility2Table["2.1-B4C"] = Engine21B4C

local Engine32B4C = {}
	Engine32B4C.id = "3.2-B4C"
	Engine32B4C.ent = "acf_engine2"
	Engine32B4C.type = "Mobility2"
	Engine32B4C.name = "3.2L Flat 4 Petrol Custom"
	Engine32B4C.desc = "Bored out fuckswindleton batshit flat four. Fuck yourself. Customizable"
	Engine32B4C.model = "models/engines/b4med.mdl"
	Engine32B4C.sound = "ACF_engines/b4_petrollarge.wav"
	Engine32B4C.category = "Boxer 4"
	Engine32B4C.weight = 200
	Engine32B4C.vtec = false
	Engine32B4C.modtable = {}
		Engine32B4C.modtable[1] = 375	--torque
		Engine32B4C.modtable[2] = 900	--idle
		Engine32B4C.modtable[3] = 3400	--Peak minimum
		Engine32B4C.modtable[4] = 5500	--Peak maximum
		Engine32B4C.modtable[5] = 6500	--Limit rpm
		Engine32B4C.modtable[6] = 0.15	--Flywheel Mass
	if ( CLIENT ) then
		Engine32B4C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine32B4C.guiupdate = function() return end
	end
Mobility2Table["3.2-B4C"] = Engine32B4C

--Petrol Boxer 6s
local Engine28B6C = {}
	Engine28B6C.id = "2.8-B6C"
	Engine28B6C.ent = "acf_engine2"
	Engine28B6C.type = "Mobility2"
	Engine28B6C.name = "2.8L Flat 6 Petrol Custom"
	Engine28B6C.desc = "Car sized flat six engine, sporty and light, customizable"
	Engine28B6C.model = "models/engines/b6small.mdl"
	Engine28B6C.sound = "ACF_engines/b6_petrolsmall.wav"
	Engine28B6C.category = "Boxer 6"
	Engine28B6C.weight = 200
	Engine28B6C.vtec = false
	Engine28B6C.modtable = {}
		Engine28B6C.modtable[1] = 170	--torque
		Engine28B6C.modtable[2] = 750	--idle
		Engine28B6C.modtable[3] = 4300	--Peak minimum
		Engine28B6C.modtable[4] = 6950	--Peak maximum
		Engine28B6C.modtable[5] = 7250	--Limit rpm
		Engine28B6C.modtable[6] = 0.08	--Flywheel Mass
	if ( CLIENT ) then
		Engine28B6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine28B6C.guiupdate = function() return end
	end
Mobility2Table["2.8-B6C"] = Engine28B6C

local Engine50B6C = {}
	Engine50B6C.id = "5.0-B6C"
	Engine50B6C.ent = "acf_engine2"
	Engine50B6C.type = "Mobility2"
	Engine50B6C.name = "5.0 Flat 6 Petrol Custom"
	Engine50B6C.desc = "Sports car grade flat six, renown for their smooth operation and light weight, customizable"
	Engine50B6C.model = "models/engines/b6med.mdl"
	Engine50B6C.sound = "ACF_engines/b6_petrolmedium.wav"
	Engine50B6C.category = "Boxer 6"
	Engine50B6C.weight = 275
	Engine50B6C.vtec = false
	Engine50B6C.modtable = {}
		Engine50B6C.modtable[1] = 360	--torque
		Engine50B6C.modtable[2] = 900	--idle
		Engine50B6C.modtable[3] = 3500	--Peak minimum
		Engine50B6C.modtable[4] = 6000	--Peak maximum
		Engine50B6C.modtable[5] = 6800	--Limit rpm
		Engine50B6C.modtable[6] = 0.1	--Flywheel Mass
	if ( CLIENT ) then
		Engine50B6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine50B6C.guiupdate = function() return end
	end
Mobility2Table["5.0-B6C"] = Engine50B6C

local Engine10B6C = {}
	Engine10B6C.id = "10.0-B6C"
	Engine10B6C.ent = "acf_engine2"
	Engine10B6C.type = "Mobility2"
	Engine10B6C.name = "10.0L Flat 6 Petrol Custom"
	Engine10B6C.desc = "Aircraft grade boxer with a high rev range biased powerband, customizable"
	Engine10B6C.model = "models/engines/b6large.mdl"
	Engine10B6C.sound = "ACF_engines/b6_petrollarge.wav"
	Engine10B6C.category = "Boxer 6"
	Engine10B6C.weight = 600
	Engine10B6C.vtec = false
	Engine10B6C.modtable = {}
		Engine10B6C.modtable[1] = 900	--torque
		Engine10B6C.modtable[2] = 620	--idle
		Engine10B6C.modtable[3] = 2500	--Peak minimum
		Engine10B6C.modtable[4] = 4550	--Peak maximum
		Engine10B6C.modtable[5] = 4600	--Limit rpm
		Engine10B6C.modtable[6] = 0.95	--Flywheel Mass
	if ( CLIENT ) then
		Engine10B6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine10B6C.guiupdate = function() return end
	end
Mobility2Table["10.0-B6C"] = Engine10B6C

--Petrol V6s
local Engine36V6C = {}
	Engine36V6C.id = "3.6-V6C"
	Engine36V6C.ent = "acf_engine2"
	Engine36V6C.type = "Mobility2"
	Engine36V6C.name = "3.6L V6 Petrol Custom"
	Engine36V6C.desc = "Meaty Car sized V6, lots of torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable"
	Engine36V6C.model = "models/engines/v6small.mdl"
	Engine36V6C.sound = "ACF_engines/v6_petrolsmall.wav"
	Engine36V6C.category = "V6 engines"
	Engine36V6C.weight = 280
	Engine36V6C.vtec = false
	Engine36V6C.modtable = {}
		Engine36V6C.modtable[1] = 285	--torque
		Engine36V6C.modtable[2] = 720	--idle
		Engine36V6C.modtable[3] = 2200	--Peak minimum
		Engine36V6C.modtable[4] = 4600	--Peak maximum
		Engine36V6C.modtable[5] = 5500	--Limit rpm
		Engine36V6C.modtable[6] = 0.25	--Flywheel Mass
	if ( CLIENT ) then
		Engine36V6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine36V6C.guiupdate = function() return end
	end
Mobility2Table["3.6-V6C"] = Engine36V6C

local Engine62V6C = {}
	Engine62V6C.id = "6.2-V6C"
	Engine62V6C.ent = "acf_engine2"
	Engine62V6C.type = "Mobility2"
	Engine62V6C.name = "6.2L V6 Petrol Custom"
	Engine62V6C.desc = "Heavy duty v6, loaded with torque/n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable"
	Engine62V6C.model = "models/engines/v6med.mdl"
	Engine62V6C.sound = "ACF_engines/v6_petrolmedium.wav"
	Engine62V6C.category = "V6 engines"
	Engine62V6C.weight = 450
	Engine62V6C.vtec = false
	Engine62V6C.modtable = {}
		Engine62V6C.modtable[1] = 525	--torque
		Engine62V6C.modtable[2] = 800	--idle
		Engine62V6C.modtable[3] = 2200	--Peak minimum
		Engine62V6C.modtable[4] = 4550	--Peak maximum
		Engine62V6C.modtable[5] = 6000	--Limit rpm
		Engine62V6C.modtable[6] = 0.45	--Flywheel Mass
	if ( CLIENT ) then
		Engine62V6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine62V6C.guiupdate = function() return end
	end
Mobility2Table["6.2-V6C"] = Engine62V6C

--Petrol L6s
local Engine22I6C = {}
	Engine22I6C.id = "2.2-I6C"
	Engine22I6C.ent = "acf_engine2"
	Engine22I6C.type = "Mobility2"
	Engine22I6C.name = "2.2L I6 Petrol Custom"
	Engine22I6C.desc = "Car sized I6 petrol with power in the high revs, customizable"
	Engine22I6C.model = "models/engines/inline6s.mdl"
	Engine22I6C.sound = "ACF_engines/l6_petrolsmall2.wav"
	Engine22I6C.category = "Inline 6"
	Engine22I6C.weight = 250
	Engine22I6C.vtec = false
	Engine22I6C.modtable = {}
		Engine22I6C.modtable[1] = 190	--torque
		Engine22I6C.modtable[2] = 800	--idle
		Engine22I6C.modtable[3] = 4000	--Peak minimum
		Engine22I6C.modtable[4] = 6500	--Peak maximum
		Engine22I6C.modtable[5] = 7200	--Limit rpm
		Engine22I6C.modtable[6] = 0.1	--Flywheel Mass
	if ( CLIENT ) then
		Engine22I6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine22I6C.guiupdate = function() return end
	end
Mobility2Table["2.2-I6C"] = Engine22I6C

local Engine48I6C = {}
	Engine48I6C.id = "4.8-I6C"
	Engine48I6C.ent = "acf_engine2"
	Engine48I6C.type = "Mobility2"
	Engine48I6C.name = "4.8L I6 Petrol Custom"
	Engine48I6C.desc = "Light truck duty I6, good for offroad applications, customizable"
	Engine48I6C.model = "models/engines/inline6m.mdl"
	Engine48I6C.sound = "ACF_engines/l6_petrolmedium.wav"
	Engine48I6C.category = "Inline 6"
	Engine48I6C.weight = 350
	Engine48I6C.vtec = false
	Engine48I6C.modtable = {}
		Engine48I6C.modtable[1] = 400	--torque
		Engine48I6C.modtable[2] = 900	--idle
		Engine48I6C.modtable[3] = 3500	--Peak minimum
		Engine48I6C.modtable[4] = 5800	--Peak maximum
		Engine48I6C.modtable[5] = 6500	--Limit rpm
		Engine48I6C.modtable[6] = 0.2	--Flywheel Mass
	if ( CLIENT ) then
		Engine48I6C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine48I6C.guiupdate = function() return end
	end
Mobility2Table["4.8-I6C"] = Engine48I6C

--Petrol V12s
local Engine46V12C = {}
	Engine46V12C.id = "4.6-V12C"
	Engine46V12C.ent = "acf_engine2"
	Engine46V12C.type = "Mobility2"
	Engine46V12C.name = "4.6L V12 Petrol Custom"
	Engine46V12C.desc = "An old racing engine; low on torque, but plenty of power, customizable"
	Engine46V12C.model = "models/engines/v12s.mdl"
	Engine46V12C.sound = "ACF_engines/v12_petrolsmall.wav"
	Engine46V12C.category = "V12 engines"
	Engine46V12C.weight = 300
	Engine46V12C.vtec = false
	Engine46V12C.modtable = {}
		Engine46V12C.modtable[1] = 250	--torque
		Engine46V12C.modtable[2] = 1200	--idle
		Engine46V12C.modtable[3] = 1350	--Peak minimum
		Engine46V12C.modtable[4] = 7000	--Peak maximum
		Engine46V12C.modtable[5] = 8000	--Limit rpm
		Engine46V12C.modtable[6] = 0.2	--Flywheel Mass
	if ( CLIENT ) then
		Engine46V12C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine46V12C.guiupdate = function() return end
	end
Mobility2Table["4.6-V12C"] = Engine46V12C

local Engine70V12C = {}
	Engine70V12C.id = "7.0-V12C"
	Engine70V12C.ent = "acf_engine2"
	Engine70V12C.type = "Mobility2"
	Engine70V12C.name = "7.0L V12 Petrol Custom"
	Engine70V12C.desc = "A high end V12; primarily found in very expensive cars, customizable"
	Engine70V12C.model = "models/engines/v12m.mdl"
	Engine70V12C.sound = "ACF_engines/v12_petrolmedium.wav"
	Engine70V12C.category = "V12 engines"
	Engine70V12C.weight = 450
	Engine70V12C.vtec = false
	Engine70V12C.modtable = {}
		Engine70V12C.modtable[1] = 520	--torque
		Engine70V12C.modtable[2] = 800	--idle
		Engine70V12C.modtable[3] = 3600	--Peak minimum
		Engine70V12C.modtable[4] = 6000	--Peak maximum
		Engine70V12C.modtable[5] = 7500	--Limit rpm
		Engine70V12C.modtable[6] = 0.45	--Flywheel Mass
	if ( CLIENT ) then
		Engine70V12C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine70V12C.guiupdate = function() return end
	end
Mobility2Table["7.0-V12C"] = Engine70V12C

--Petrol V8s
local Engine57V8C = {}
	Engine57V8C.id = "5.7-V8C"
	Engine57V8C.ent = "acf_engine2"
	Engine57V8C.type = "Mobility2"
	Engine57V8C.name = "5.7L V8 Petrol Custom"
	Engine57V8C.desc = "Car sized petrol engine, good power and mid range torque, customizable"
	Engine57V8C.model = "models/engines/v8s.mdl"
	Engine57V8C.sound = "ACF_engines/v8_petrolsmall.wav"
	Engine57V8C.category = "V8 engines"
	Engine57V8C.weight = 350
	Engine57V8C.vtec = false
	Engine57V8C.modtable = {}
		Engine57V8C.modtable[1] = 400	--torque
		Engine57V8C.modtable[2] = 800	--idle
		Engine57V8C.modtable[3] = 3000	--Peak minimum
		Engine57V8C.modtable[4] = 5000	--Peak maximum
		Engine57V8C.modtable[5] = 6500	--Limit rpm
		Engine57V8C.modtable[6] = 0.15	--Flywheel Mass
	if ( CLIENT ) then
		Engine57V8C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine57V8C.guiupdate = function() return end
	end
Mobility2Table["5.7-V8C"] = Engine57V8C

local Engine90V8C = {}
	Engine90V8C.id = "9.0-V8C"
	Engine90V8C.ent = "acf_engine2"
	Engine90V8C.type = "Mobility2"
	Engine90V8C.name = "9.0L V8 Petrol Custom"
	Engine90V8C.desc = "Thirsty, giant V8, for medium applications, customizable"
	Engine90V8C.model = "models/engines/v8m.mdl"
	Engine90V8C.sound = "ACF_engines/v8_petrolmedium.wav"
	Engine90V8C.category = "V8 engines"
	Engine90V8C.weight = 500
	Engine90V8C.vtec = false
	Engine90V8C.modtable = {}
		Engine90V8C.modtable[1] = 575	--torque
		Engine90V8C.modtable[2] = 700	--idle
		Engine90V8C.modtable[3] = 3100	--Peak minimum
		Engine90V8C.modtable[4] = 5000	--Peak maximum
		Engine90V8C.modtable[5] = 5500	--Limit rpm
		Engine90V8C.modtable[6] = 0.25	--Flywheel Mass
	if ( CLIENT ) then
		Engine90V8C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine90V8C.guiupdate = function() return end
	end
Mobility2Table["9.0-V8C"] = Engine90V8C

local Engine58V8C = {}
	Engine58V8C.id = "5.8LS-V8C"
	Engine58V8C.ent = "acf_engine2"
	Engine58V8C.type = "Mobility2"
	Engine58V8C.name = "5.8L LS Motor Custom"
	Engine58V8C.desc = "corvette motor, customizable"
	Engine58V8C.model = "models/engines/v8s.mdl"
	Engine58V8C.sound = "/engines/v8/corvette69-onmid.wav"
	Engine58V8C.category = "V8 engines"
	Engine58V8C.weight = 400
	Engine58V8C.vtec = false
	Engine58V8C.modtable = {}
		Engine58V8C.modtable[1] = 490	--torque
		Engine58V8C.modtable[2] = 1150	--idle
		Engine58V8C.modtable[3] = 2800	--Peak minimum
		Engine58V8C.modtable[4] = 5800	--Peak maximum
		Engine58V8C.modtable[5] = 6800	--Limit rpm
		Engine58V8C.modtable[6] = 0.25	--Flywheel Mass
	if ( CLIENT ) then
		Engine58V8C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine58V8C.guiupdate = function() return end
	end
Mobility2Table["5.8LS-V8C"] = Engine58V8C

--Petrol Radials
local Engine38R7C = {}
	Engine38R7C.id = "3.8-R7C"
	Engine38R7C.ent = "acf_engine2"
	Engine38R7C.type = "Mobility2"
	Engine38R7C.name = "3.8L R7 Petrol Custom"
	Engine38R7C.desc = "A tiny, old worn-out radial. Customizable"
	Engine38R7C.model = "models/engines/radial7s.mdl"
	Engine38R7C.sound = "ACF_engines/R7_petrolsmall.wav"
	Engine38R7C.category = "Radial Engines"
	Engine38R7C.weight = 150
	Engine38R7C.vtec = false
	Engine38R7C.modtable = {}
		Engine38R7C.modtable[1] = 250	--torque
		Engine38R7C.modtable[2] = 700	--idle
		Engine38R7C.modtable[3] = 2800	--Peak minimum
		Engine38R7C.modtable[4] = 4500	--Peak maximum
		Engine38R7C.modtable[5] = 5000	--Limit rpm
		Engine38R7C.modtable[6] = 0.15	--Flywheel Mass
	if ( CLIENT ) then
		Engine38R7C.guicreate = (function( Panel, Table ) ACFEngine2GUICreate( Table ) end or nil)
		Engine38R7C.guiupdate = function() return end
	end
Mobility2Table["3.8-R7C"] = Engine38R7C

--###################################################################################################################################
-- Customizable Engines FAT

--Inline 4
local Engine160I4C = {}
	Engine160I4C.id = "16.0-I4C"
	Engine160I4C.ent = "acf_engine4"
	Engine160I4C.type = "Mobility2"
	Engine160I4C.name = "16.0L I4 Petrol Custom"
	Engine160I4C.desc = "Giant, thirsty I4 petrol, most commonly used in boats, customizable"
	Engine160I4C.model = "models/engines/inline4l.mdl"
	Engine160I4C.sound = "ACF_engines/i4_petrollarge.wav"
	Engine160I4C.category = "Inline4"
	Engine160I4C.weight = 800
	Engine160I4C.vtec = false
	Engine160I4C.modtable = {}
		Engine160I4C.modtable[1] = 950	--torque			--########
		Engine160I4C.modtable[2] = 500	--idle
		Engine160I4C.modtable[3] = 1750	--Peak minimum
		Engine160I4C.modtable[4] = 3250	--Peak maximum
		Engine160I4C.modtable[5] = 3500	--Limit rpm
		Engine160I4C.modtable[6] = 1.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine160I4C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine160I4C.guiupdate = function() return end
	end
Mobility2Table["16.0-I4C"] = Engine160I4C

local Engine150I4C = {}
	Engine150I4C.id = "15.0-I4C"
	Engine150I4C.ent = "acf_engine4"
	Engine150I4C.type = "Mobility2"
	Engine150I4C.name = "15.0L I4 Diesel Custom"
	Engine150I4C.desc = "Small boat sized diesel, with large amounts of torque, customizable"
	Engine150I4C.model = "models/engines/inline4l.mdl"
	Engine150I4C.sound = "ACF_engines/i4_diesellarge.wav"
	Engine150I4C.category = "Inline4"
	Engine150I4C.weight = 1000
	Engine150I4C.vtec = false
	Engine150I4C.modtable = {}
		Engine150I4C.modtable[1] = 1800	--torque		--########
		Engine150I4C.modtable[2] = 300	--idle
		Engine150I4C.modtable[3] = 500	--Peak minimum
		Engine150I4C.modtable[4] = 1500	--Peak maximum
		Engine150I4C.modtable[5] = 2000	--Limit rpm
		Engine150I4C.modtable[6] = 5	--Flywheel Mass
	if ( CLIENT ) then
		Engine150I4C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine150I4C.guiupdate = function() return end
	end
Mobility2Table["15.0-I4C"] = Engine150I4C

--V6
local Engine120V6C = {}
	Engine120V6C.id = "12.0-V6C"
	Engine120V6C.ent = "acf_engine4"
	Engine120V6C.type = "Mobility2"
	Engine120V6C.name = "12.0L V6 Petrol Custom"
	Engine120V6C.desc = "Fuck duty V6, guts ripped from god himself diluted in salt and shaped into an engine./n/nV6s are more torquey than the Boxer and Inline 6s but suffer in power, customizable"
	Engine120V6C.model = "models/engines/v6large.mdl"
	Engine120V6C.sound = "ACF_engines/v6_petrollarge.wav"
	Engine120V6C.category = "V6 Custom"
	Engine120V6C.weight = 750
	Engine120V6C.vtec = false
	Engine120V6C.modtable = {}
		Engine120V6C.modtable[1] = 1300	--torque			--########
		Engine120V6C.modtable[2] = 600	--idle
		Engine120V6C.modtable[3] = 1750	--Peak minimum
		Engine120V6C.modtable[4] = 2950	--Peak maximum
		Engine120V6C.modtable[5] = 3500	--Limit rpm
		Engine120V6C.modtable[6] = 2.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine120V6C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine120V6C.guiupdate = function() return end
	end
Mobility2Table["12.0-V6C"] = Engine120V6C

--Inline 6
local Engine200I6C = {}
	Engine200I6C.id = "20.0-I6C"
	Engine200I6C.ent = "acf_engine4"
	Engine200I6C.type = "Mobility2"
	Engine200I6C.name = "20.0L I6 Diesel Custom"
	Engine200I6C.desc = "Heavy duty diesel I6, used in generators and heavy movers, customizable"
	Engine200I6C.model = "models/engines/inline6l.mdl"
	Engine200I6C.sound = "ACF_engines/l6_diesellarge2.wav"
	Engine200I6C.category = "Inline6"
	Engine200I6C.weight = 1000
	Engine200I6C.vtec = false
	Engine200I6C.modtable = {}
		Engine200I6C.modtable[1] = 2000	--torque			--########
		Engine200I6C.modtable[2] = 400	--idle
		Engine200I6C.modtable[3] = 500	--Peak minimum
		Engine200I6C.modtable[4] = 1700	--Peak maximum
		Engine200I6C.modtable[5] = 2250	--Limit rpm
		Engine200I6C.modtable[6] = 8	--Flywheel Mass
	if ( CLIENT ) then
		Engine200I6C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine200I6C.guiupdate = function() return end
	end
Mobility2Table["20.0-I6C"] = Engine200I6C

local Engine172I6C = {}
	Engine172I6C.id = "17.2-I6C"
	Engine172I6C.ent = "acf_engine4"
	Engine172I6C.type = "Mobility2"
	Engine172I6C.name = "17.2L I6 Petrol Custom"
	Engine172I6C.desc = "Heavy tractor duty petrol I6, decent overall powerband, customizable"
	Engine172I6C.model = "models/engines/inline6l.mdl"
	Engine172I6C.sound = "ACF_engines/l6_petrollarge2.wav"
	Engine172I6C.category = "Inline6"
	Engine172I6C.weight = 700
	Engine172I6C.vtec = false
	Engine172I6C.modtable = {}
		Engine172I6C.modtable[1] = 1200	--torque			--########
		Engine172I6C.modtable[2] = 800	--idle
		Engine172I6C.modtable[3] = 2000	--Peak minimum
		Engine172I6C.modtable[4] = 3300	--Peak maximum
		Engine172I6C.modtable[5] = 4000	--Limit rpm
		Engine172I6C.modtable[6] = 2.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine172I6C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine172I6C.guiupdate = function() return end
	end
Mobility2Table["17.2-I6C"] = Engine172I6C

--V12
local Engine92V12C = {}
	Engine92V12C.id = "9.2-V12C"
	Engine92V12C.ent = "acf_engine4"
	Engine92V12C.type = "Mobility2"
	Engine92V12C.name = "9.2L V12 Diesel Custom"
	Engine92V12C.desc = "High torque V12, used mainly for vehicles that require balls, customizable"
	Engine92V12C.model = "models/engines/v12m.mdl"
	Engine92V12C.sound = "ACF_engines/v12_dieselmedium.wav"
	Engine92V12C.category = "V12 Custom"
	Engine92V12C.weight = 900
	Engine92V12C.vtec = false
	Engine92V12C.modtable = {}
		Engine92V12C.modtable[1] = 1000	--torque			--########
		Engine92V12C.modtable[2] = 675	--idle
		Engine92V12C.modtable[3] = 1100	--Peak minimum
		Engine92V12C.modtable[4] = 3300	--Peak maximum
		Engine92V12C.modtable[5] = 3500	--Limit rpm
		Engine92V12C.modtable[6] = 2.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine92V12C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine92V12C.guiupdate = function() return end
	end
Mobility2Table["9.2-V12C"] = Engine92V12C

local Engine210V12C = {}
	Engine210V12C.id = "21.0-V12C"
	Engine210V12C.ent = "acf_engine4"
	Engine210V12C.type = "Mobility2"
	Engine210V12C.name = "21.0 V12 Diesel Custom"
	Engine210V12C.desc = "Extreme duty V12; however massively powerful, it is enormous and heavy, customizable"
	Engine210V12C.model = "models/engines/v12l.mdl"
	Engine210V12C.sound = "ACF_engines/v12_diesellarge.wav"
	Engine210V12C.category = "V12 Custom"
	Engine210V12C.weight = 1500
	Engine210V12C.vtec = false
	Engine210V12C.modtable = {}
		Engine210V12C.modtable[1] = 2800	--torque			--########
		Engine210V12C.modtable[2] = 400	--idle
		Engine210V12C.modtable[3] = 500	--Peak minimum
		Engine210V12C.modtable[4] = 1500	--Peak maximum
		Engine210V12C.modtable[5] = 2500	--Limit rpm
		Engine210V12C.modtable[6] = 7	--Flywheel Mass
	if ( CLIENT ) then
		Engine210V12C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine210V12C.guiupdate = function() return end
	end
Mobility2Table["21.0-V12C"] = Engine210V12C

local Engine230V12C = {}
	Engine230V12C.id = "23.0-V12C"
	Engine230V12C.ent = "acf_engine4"
	Engine230V12C.type = "Mobility2"
	Engine230V12C.name = "23.0 V12 Petrol Custom"
	Engine230V12C.desc = "A large, thirsty gasoline V12, likes to break down and roast crewmen, customizable"
	Engine230V12C.model = "models/engines/v12l.mdl"
	Engine230V12C.sound = "ACF_engines/v12_petrollarge.wav"
	Engine230V12C.category = "V12 Custom"
	Engine230V12C.weight = 1300
	Engine230V12C.vtec = false
	Engine230V12C.modtable = {}
		Engine230V12C.modtable[1] = 1800	--torque			--########
		Engine230V12C.modtable[2] = 600	--idle
		Engine230V12C.modtable[3] = 1500	--Peak minimum
		Engine230V12C.modtable[4] = 3000	--Peak maximum
		Engine230V12C.modtable[5] = 3000	--Limit rpm
		Engine230V12C.modtable[6] = 5	--Flywheel Mass
	if ( CLIENT ) then
		Engine230V12C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine230V12C.guiupdate = function() return end
	end
Mobility2Table["23.0-V12C"] = Engine230V12C

--Radial
local Engine11R7C = {}
	Engine11R7C.id = "11.0-R7C"
	Engine11R7C.ent = "acf_engine4"
	Engine11R7C.type = "Mobility2"
	Engine11R7C.name = "11.0 R7 Petrol Custom"
	Engine11R7C.desc = "Mid range radial, thirsty and smooth, customizable"
	Engine11R7C.model = "models/engines/radial7m.mdl"
	Engine11R7C.sound = "ACF_engines/R7_petrolmedium.wav"
	Engine11R7C.category = "Radial Custom"
	Engine11R7C.weight = 350
	Engine11R7C.vtec = false
	Engine11R7C.modtable = {}
		Engine11R7C.modtable[1] = 950	--torque
		Engine11R7C.modtable[2] = 600	--idle
		Engine11R7C.modtable[3] = 1700	--Peak minimum
		Engine11R7C.modtable[4] = 3700	--Peak maximum
		Engine11R7C.modtable[5] = 3700	--Limit rpm
		Engine11R7C.modtable[6] = 1.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine11R7C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine11R7C.guiupdate = function() return end
	end
Mobility2Table["11.0-R7C"] = Engine11R7C

local Engine240R7C = {}
	Engine240R7C.id = "24.0-R7C"
	Engine240R7C.ent = "acf_engine4"
	Engine240R7C.type = "Mobility2"
	Engine240R7C.name = "24.0L R7 Petrol Custom"
	Engine240R7C.desc = "The beast of Radials, this monster was destined for fighter aircraft. Customizable"
	Engine240R7C.model = "models/engines/radial7l.mdl"
	Engine240R7C.sound = "ACF_engines/R7_petrollarge.wav"
	Engine240R7C.category = "Radial Custom"
	Engine240R7C.weight = 800
	Engine240R7C.vtec = false
	Engine240R7C.modtable = {}
		Engine240R7C.modtable[1] = 1600	--torque			--########
		Engine240R7C.modtable[2] = 750	--idle
		Engine240R7C.modtable[3] = 1900	--Peak minimum
		Engine240R7C.modtable[4] = 3000	--Peak maximum
		Engine240R7C.modtable[5] = 3000	--Limit rpm
		Engine240R7C.modtable[6] = 3	--Flywheel Mass
	if ( CLIENT ) then
		Engine240R7C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine240R7C.guiupdate = function() return end
	end
Mobility2Table["24.0-R7C"] = Engine240R7C

--V8
local Engine180V8C = {}
	Engine180V8C.id = "18.0-V8C"
	Engine180V8C.ent = "acf_engine4"
	Engine180V8C.type = "Mobility2"
	Engine180V8C.name = "18.0L V8 Petrol Custom"
	Engine180V8C.desc = "American Ford GAA V8, decent overall power and torque and fairly lightweight, customizable"
	Engine180V8C.model = "models/engines/v8l.mdl"
	Engine180V8C.sound = "ACF_engines/v8_petrollarge.wav"
	Engine180V8C.category = "V8 Custom"
	Engine180V8C.weight = 900
	Engine180V8C.vtec = false
	Engine180V8C.modtable = {}
		Engine180V8C.modtable[1] = 1420	--torque			--########
		Engine180V8C.modtable[2] = 600	--idle
		Engine180V8C.modtable[3] = 1800	--Peak minimum
		Engine180V8C.modtable[4] = 3000	--Peak maximum
		Engine180V8C.modtable[5] = 3800	--Limit rpm
		Engine180V8C.modtable[6] = 2.8	--Flywheel Mass
	if ( CLIENT ) then
		Engine180V8C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine180V8C.guiupdate = function() return end
	end
Mobility2Table["18.0-V8C"] = Engine180V8C

local Engine190V8C = {}
	Engine190V8C.id = "19.0-V8C"
	Engine190V8C.ent = "acf_engine4"
	Engine190V8C.type = "Mobility2"
	Engine190V8C.name = "19.0L V8 Diesel Custom"
	Engine190V8C.desc = "Heavy duty diesel V8, used for heavy construction equipment, customizable"
	Engine190V8C.model = "models/engines/v8l.mdl"
	Engine190V8C.sound = "ACF_engines/v8_diesellarge.wav"
	Engine190V8C.category = "V8 Custom"
	Engine190V8C.weight = 1300
	Engine190V8C.vtec = false
	Engine190V8C.modtable = {}
		Engine190V8C.modtable[1] = 2400	--torque				--########
		Engine190V8C.modtable[2] = 500	--idle
		Engine190V8C.modtable[3] = 550	--Peak minimum
		Engine190V8C.modtable[4] = 1650	--Peak maximum
		Engine190V8C.modtable[5] = 2700	--Limit rpm
		Engine190V8C.modtable[6] = 4.5	--Flywheel Mass
	if ( CLIENT ) then
		Engine190V8C.guicreate = (function( Panel, Table ) ACFEngine3GUICreate( Table ) end or nil)
		Engine190V8C.guiupdate = function() return end
	end
Mobility2Table["19.0-V8C"] = Engine190V8C


--###################################################################################################################################
--###################################################################################################################################
--Custom Engines

--v12 6.5L
local Engine65V12C = {}
	Engine65V12C.id = "6.5-V12C"
	Engine65V12C.ent = "acf_engine3"
	Engine65V12C.type = "Mobility2"
	Engine65V12C.name = "6.5L V12 SuperVeloce"
	Engine65V12C.desc = "Racing engine V12 Custom"
	Engine65V12C.model = "models/engines/v12s.mdl"
	Engine65V12C.sound = "/engines/v12/dbr9.wav"
	Engine65V12C.category = "V12 series"
	Engine65V12C.weight = 220
	Engine65V12C.vtec = false
	Engine65V12C.torque = 490	--in Meter/Kg
	Engine65V12C.idlerpm = 2200	--in Rotations Per Minute
	Engine65V12C.flywheelmass = 0.05		--in Meter/Kg
	Engine65V12C.peakminrpm = 2800
	Engine65V12C.peakmaxrpm = 8800
	Engine65V12C.limitrpm = 9000
	if ( CLIENT ) then
		Engine65V12C.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine65V12C.guiupdate = function() return end
	end
Mobility2Table["6.5-V12C"] = Engine65V12C

-- Racing I4s
local Engine16I4E1 = {}
	Engine16I4E1.id = "1.6-I4R"
	Engine16I4E1.ent = "acf_engine3"
	Engine16I4E1.type = "Mobility2"
	Engine16I4E1.name = "1.6L Petrol 1, Racing"
	Engine16I4E1.desc = "1600cc racing motor, for small, lightweight cars"
	Engine16I4E1.model = "models/engines/inline4s.mdl"
	Engine16I4E1.sound = "i4_petrol16_1.wav"
	Engine16I4E1.category = "Inline 4 engines"
	Engine16I4E1.weight = 90
	Engine16I4E1.vtec = true
	Engine16I4E1.vteckick = 4300
	Engine16I4E1.vtectorque = 80
	Engine16I4E1.torque = 125	--in Meter/Kg
	Engine16I4E1.idlerpm = 900	--in Rotations Per Minute
	Engine16I4E1.flywheelmass = 0.03		--in Meter/Kg
	Engine16I4E1.peakminrpm = 3900
	Engine16I4E1.peakmaxrpm = 6500
	Engine16I4E1.limitrpm = 8000
	if ( CLIENT ) then
		Engine16I4E1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine16I4E1.guiupdate = function() return end
	end
Mobility2Table["1.6-I4R"] = Engine16I4E1

local Engine16I4E2 = {}
	Engine16I4E2.id = "1.6-I4R2"
	Engine16I4E2.ent = "acf_engine3"
	Engine16I4E2.type = "Mobility2"
	Engine16I4E2.name = "1.6L Petrol 2, Racing"
	Engine16I4E2.desc = "1600cc racing motor, for small, lightweight cars"
	Engine16I4E2.model = "models/engines/inline4s.mdl"
	Engine16I4E2.sound = "i4_petrol16_2.wav"
	Engine16I4E2.category = "Inline 4 engines"
	Engine16I4E2.weight = 90
	Engine16I4E2.vtec = true
	Engine16I4E2.vteckick = 4200
	Engine16I4E2.vtectorque = 80
	Engine16I4E2.torque = 125	--in Meter/Kg
	Engine16I4E2.idlerpm = 900	--in Rotations Per Minute
	Engine16I4E2.flywheelmass = 0.03		--in Meter/Kg
	Engine16I4E2.peakminrpm = 3900
	Engine16I4E2.peakmaxrpm = 6500
	Engine16I4E2.limitrpm = 8000
	if ( CLIENT ) then
		Engine16I4E2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine16I4E2.guiupdate = function() return end
	end
Mobility2Table["1.6-I4R2"] = Engine16I4E2

local Engine20I4E1 = {}
	Engine20I4E1.id = "2.0-I4R"
	Engine20I4E1.ent = "acf_engine3"
	Engine20I4E1.type = "Mobility2"
	Engine20I4E1.name = "2.0L Petrol 1, Racing"
	Engine20I4E1.desc = "2000cc racing engine, used in small cars"
	Engine20I4E1.model = "models/engines/inline4s.mdl"
	Engine20I4E1.sound = "i4_petrol20_1.wav"
	Engine20I4E1.category = "Inline 4 engines"
	Engine20I4E1.weight = 140
	Engine20I4E1.vtec = true
	Engine20I4E1.vteckick = 4250
	Engine20I4E1.vtectorque = 110
	Engine20I4E1.torque = 190	--in Meter/Kg
	Engine20I4E1.idlerpm = 1000	--in Rotations Per Minute
	Engine20I4E1.flywheelmass = 0.05		--in Meter/Kg
	Engine20I4E1.peakminrpm = 3500
	Engine20I4E1.peakmaxrpm = 6000
	Engine20I4E1.limitrpm = 7500
	if ( CLIENT ) then
		Engine20I4E1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine20I4E1.guiupdate = function() return end
	end
Mobility2Table["2.0-I4R"] = Engine20I4E1

local Engine20I4E2 = {}
	Engine20I4E2.id = "2.0-I4R2"
	Engine20I4E2.ent = "acf_engine3"
	Engine20I4E2.type = "Mobility2"
	Engine20I4E2.name = "2.0L Petrol 2, Racing"
	Engine20I4E2.desc = "2000cc racing engine, used in small cars"
	Engine20I4E2.model = "models/engines/inline4s.mdl"
	Engine20I4E2.sound = "i4_petrol20_2.wav"
	Engine20I4E2.category = "Inline 4 engines"
	Engine20I4E2.weight = 140
	Engine20I4E2.vtec = true
	Engine20I4E2.vteckick = 4300
	Engine20I4E2.vtectorque = 110
	Engine20I4E2.torque = 190	--in Meter/Kg
	Engine20I4E2.idlerpm = 1000	--in Rotations Per Minute
	Engine20I4E2.flywheelmass = 0.05		--in Meter/Kg
	Engine20I4E2.peakminrpm = 3500
	Engine20I4E2.peakmaxrpm = 6000
	Engine20I4E2.limitrpm = 7500
	if ( CLIENT ) then
		Engine20I4E2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine20I4E2.guiupdate = function() return end
	end
Mobility2Table["2.0-I4R2"] = Engine20I4E2

 local Engine58V8 = {}
Engine58V8.id = "5.8LS-V8"
Engine58V8.ent = "acf_engine3"
Engine58V8.type = "Mobility2"
Engine58V8.name = "Standard 5.8 LS"
Engine58V8.desc = "corvette motor"
Engine58V8.model = "models/engines/v8s.mdl"
Engine58V8.sound = "/engines/v8/corvette69-onmid.wav"
Engine58V8.category = "V8 series"
Engine58V8.weight = 400
Engine58V8.vtec = true
Engine58V8.vteckick = 4300
Engine58V8.vtectorque = 180
Engine58V8.torque = 490--in Meter/Kg
Engine58V8.flywheelmass = 0.25

Engine58V8.idlerpm = 1150--in Rotations Per Minute
Engine58V8.peakminrpm = 2800
Engine58V8.peakmaxrpm = 5800
Engine58V8.limitrpm = 6800
if ( CLIENT ) then
Engine58V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine58V8.guiupdate = function() return end
end
Mobility2Table["5.8LS-V8"] = Engine58V8

 local Engine572V8 = {}
Engine572V8.id = "5.4-V8"
Engine572V8.ent = "acf_engine3"
Engine572V8.type = "Mobility2"
Engine572V8.name = "5.4L GT-500 V8 Petrol"
Engine572V8.desc = "GT-500 motor"
Engine572V8.model = "models/engines/v8s.mdl"
Engine572V8.sound = "/engines/v8/cobra_onlow.wav"
Engine572V8.category = "V8 series"
Engine572V8.weight = 500
Engine572V8.vtec = false
Engine572V8.torque = 750--in Meter/Kg
Engine572V8.flywheelmass = 0.65

Engine572V8.idlerpm = 700--in Rotations Per Minute
Engine572V8.peakminrpm = 1650
Engine572V8.peakmaxrpm = 5890
Engine572V8.limitrpm = 6800
if ( CLIENT ) then
Engine572V8.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine572V8.guiupdate = function() return end
end
Mobility2Table["5.4-V8"] = Engine572V8



local Engine66I6 = {}
Engine66I6.id = "6.6-I6"
Engine66I6.ent = "acf_engine3"
Engine66I6.type = "Mobility2"
Engine66I6.name = "5.9L Cummins I6 Diesel"
Engine66I6.desc = "CUMMINS DIESEL POWER BABY!"
Engine66I6.model = "models/engines/inline6m.mdl"
Engine66I6.sound = "/engines/diesel/newdiesel.wav"
Engine66I6.category = "Inline 6 engines"
Engine66I6.weight = 500
Engine66I6.vtec = false
Engine66I6.torque = 730--in Meter/Kg
Engine66I6.flywheelmass = 0.9

Engine66I6.idlerpm = 950--in Rotations Per Minute
Engine66I6.peakminrpm = 1400
Engine66I6.peakmaxrpm = 4400
Engine66I6.limitrpm = 4700
if ( CLIENT ) then
Engine66I6.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine66I6.guiupdate = function() return end
end
Mobility2Table["6.6-I6"] = Engine66I6


local Engine22I4E1 = {}
	Engine22I4E1.id = "2.2-I4R"
	Engine22I4E1.ent = "acf_engine3"
	Engine22I4E1.type = "Mobility2"
	Engine22I4E1.name = "2.2L H22A Racing"
	Engine22I4E1.desc = "2.2L similar as H22A"
	Engine22I4E1.model = "models/engines/inline4s.mdl"
	Engine22I4E1.sound = "SCarEngineSounds/14.wav"
	Engine22I4E1.category = "Inline 4 engines"
	Engine22I4E1.weight = 150
	Engine22I4E1.vtec = true
	Engine22I4E1.vteckick = 4500
	Engine22I4E1.vtectorque = 90
	Engine22I4E1.torque = 205--in Meter/Kg
	Engine22I4E1.flywheelmass = 0.04
	Engine22I4E1.idlerpm = 900--in Rotations Per Minute
	Engine22I4E1.peakminrpm = 2500
	Engine22I4E1.peakmaxrpm = 6500
	Engine22I4E1.limitrpm = 7200
	if ( CLIENT ) then
		Engine22I4E1.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine22I4E1.guiupdate = function() return end
	end
Mobility2Table["2.2-I4R"] = Engine22I4E1


local Engine10I4E2 = {}
	Engine10I4E2.id = "1.0-I4R2"
	Engine10I4E2.ent = "acf_engine3"
	Engine10I4E2.type = "Mobility2"
	Engine10I4E2.name = "1L Bike Engine"
	Engine10I4E2.desc = "1000cc racing bike motor"
	Engine10I4E2.model = "models/engines/inline4s.mdl"
	Engine10I4E2.sound = "/engines/v8/38lv8_gp3_onhigh_in.wav"
	Engine10I4E2.category = "Inline 4 engines"
	Engine10I4E2.weight = 70
	Engine10I4E2.vtec = false
	Engine10I4E2.torque = 135	--in Meter/Kg
	Engine10I4E2.idlerpm = 900	--in Rotations Per Minute
	Engine10I4E2.flywheelmass = 0.02		--in Meter/Kg
	Engine10I4E2.peakminrpm = 3900
	Engine10I4E2.peakmaxrpm = 8500
	Engine10I4E2.limitrpm = 9000
	if ( CLIENT ) then
		Engine10I4E2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine10I4E2.guiupdate = function() return end
	end
Mobility2Table["1.0-I4R2"] = Engine10I4E2

local Engine11I4E2 = {}
	Engine11I4E2.id = "1.1-I4R2"
	Engine11I4E2.ent = "acf_engine3"
	Engine11I4E2.type = "Mobility2"
	Engine11I4E2.name = "1.1L Bike Engine"
	Engine11I4E2.desc = "1100cc racing bike motor"
	Engine11I4E2.model = "models/engines/inline4s.mdl"
	Engine11I4E2.sound = "/engines/l4/elan_onmid.wav"
	Engine11I4E2.category = "Inline 4 engines"
	Engine11I4E2.weight = 75
	Engine11I4E2.vtec = false
	Engine11I4E2.torque = 145	--in Meter/Kg
	Engine11I4E2.idlerpm = 920	--in Rotations Per Minute
	Engine11I4E2.flywheelmass = 0.021		--in Meter/Kg
	Engine11I4E2.peakminrpm = 3800
	Engine11I4E2.peakmaxrpm = 8400
	Engine11I4E2.limitrpm = 8500
	if ( CLIENT ) then
		Engine11I4E2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine11I4E2.guiupdate = function() return end
	end
Mobility2Table["1.1-I4R2"] = Engine11I4E2

local Engine12I2E2 = {}
	Engine12I2E2.id = "1.2-I2R2"
	Engine12I2E2.ent = "acf_engine3"
	Engine12I2E2.type = "Mobility2"
	Engine12I2E2.name = "1.2L Harley Engine"
	Engine12I2E2.desc = "1200cc Harley motor"
	Engine12I2E2.model = "models/engines/v-twinb.mdl"
	Engine12I2E2.sound = "/engines/flat4/vw.wav"
	Engine12I2E2.category = "V2 series"
	Engine12I2E2.weight = 65
	Engine12I2E2.vtec = false
	Engine12I2E2.torque = 95	--in Meter/Kg
	Engine12I2E2.idlerpm = 600	--in Rotations Per Minute
	Engine12I2E2.flywheelmass = 0.03		--in Meter/Kg
	Engine12I2E2.peakminrpm = 3300
	Engine12I2E2.peakmaxrpm = 5400
	Engine12I2E2.limitrpm = 6000
	if ( CLIENT ) then
		Engine12I2E2.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine12I2E2.guiupdate = function() return end
	end
Mobility2Table["1.2-I2R2"] = Engine12I2E2

local Engine16I4E3 = {}
	Engine16I4E3.id = "1.6-I4R3"
	Engine16I4E3.ent = "acf_engine3"
	Engine16I4E3.type = "Mobility2"
	Engine16I4E3.name = "1.6L Honda Engine"
	Engine16I4E3.desc = "1.6L B16 Engine"
	Engine16I4E3.model = "models/engines/inline4s.mdl"
	Engine16I4E3.sound = "/engines/l4/a110i1.wav"
	Engine16I4E3.category = "Inline 4 engines"
	Engine16I4E3.weight = 95
	Engine16I4E3.vtec = true
	Engine16I4E3.vteckick = 4800
	Engine16I4E3.vtectorque = 70
	Engine16I4E3.torque = 165	--in Meter/Kg
	Engine16I4E3.idlerpm = 1000	--in Rotations Per Minute
	Engine16I4E3.flywheelmass = 0.025		--in Meter/Kg
	Engine16I4E3.peakminrpm = 3500
	Engine16I4E3.peakmaxrpm = 7300
	Engine16I4E3.limitrpm = 7500
	if ( CLIENT ) then
		Engine16I4E3.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine16I4E3.guiupdate = function() return end
	end
Mobility2Table["1.6-I4R3"] = Engine16I4E3

local Engine14I4E3 = {}
	Engine14I4E3.id = "1.4-I4R3"
	Engine14I4E3.ent = "acf_engine3"
	Engine14I4E3.type = "Mobility2"
	Engine14I4E3.name = "1.4L Cheap Engine"
	Engine14I4E3.desc = "1.4L Cheapy Engine"
	Engine14I4E3.model = "models/engines/inline4s.mdl"
	Engine14I4E3.sound = "/engines/l4/elite_onlow.wav"
	Engine14I4E3.category = "Inline 4 engines"
	Engine14I4E3.weight = 75
	Engine14I4E3.vtec = true
	Engine14I4E3.vteckick = 4200
	Engine14I4E3.vtectorque = 40
	Engine14I4E3.torque = 75	--in Meter/Kg
	Engine14I4E3.idlerpm = 1000	--in Rotations Per Minute
	Engine14I4E3.flywheelmass = 0.045		--in Meter/Kg
	Engine14I4E3.peakminrpm = 3300
	Engine14I4E3.peakmaxrpm = 5800
	Engine14I4E3.limitrpm = 6000
	if ( CLIENT ) then
		Engine14I4E3.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine14I4E3.guiupdate = function() return end
	end
Mobility2Table["1.4-I4R3"] = Engine14I4E3

local Engine18I4E3 = {}
	Engine18I4E3.id = "1.8-I4R3"
	Engine18I4E3.ent = "acf_engine3"
	Engine18I4E3.type = "Mobility2"
	Engine18I4E3.name = "1.8L Ford Engine"
	Engine18I4E3.desc = "1.8L Ford Escort Engine"
	Engine18I4E3.model = "models/engines/inline4s.mdl"
	Engine18I4E3.sound = "/engines/l4/escort_onverylow.wav"
	Engine18I4E3.category = "Inline 4 engines"
	Engine18I4E3.weight = 95
	Engine18I4E3.vtec = false
	Engine18I4E3.torque = 135	--in Meter/Kg
	Engine18I4E3.idlerpm = 1000	--in Rotations Per Minute
	Engine18I4E3.flywheelmass = 0.03		--in Meter/Kg
	Engine18I4E3.peakminrpm = 3500
	Engine18I4E3.peakmaxrpm = 6600
	Engine18I4E3.limitrpm = 6800
	if ( CLIENT ) then
		Engine18I4E3.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine18I4E3.guiupdate = function() return end
	end
Mobility2Table["1.8-I4R3"] = Engine18I4E3

local Engine63I62 = {}
Engine63I62.id = "6.3-I62"
Engine63I62.ent = "acf_engine3"
Engine63I62.type = "Mobility2"
Engine63I62.name = "4.0L Mercedes Petrol"
Engine63I62.desc = "4.0L Mercedes Engine"
Engine63I62.model = "models/engines/inline6s.mdl"
Engine63I62.sound = "/engines/l6/mercedes-onmid.wav"
Engine63I62.category = "Inline 6 engines"
Engine63I62.weight = 200
Engine63I62.vtec = false
Engine63I62.torque = 330--in Meter/Kg
Engine63I62.flywheelmass = 0.12

Engine63I62.idlerpm = 950--in Rotations Per Minute
Engine63I62.peakminrpm = 2400
Engine63I62.peakmaxrpm = 6400
Engine63I62.limitrpm = 6500
if ( CLIENT ) then
	Engine63I62.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
	Engine63I62.guiupdate = function() return end
end
Mobility2Table["6.3-I62"] = Engine63I62

local Engine41I62 = {}
Engine41I62.id = "4.1-I62"
Engine41I62.ent = "acf_engine3"
Engine41I62.type = "Mobility2"
Engine41I62.name = "4.1L Audi Petrol"
Engine41I62.desc = "4.1L Audi Engine"
Engine41I62.model = "models/engines/inline6s.mdl"
Engine41I62.sound = "/engines/l5/audis1_onmid.wav"
Engine41I62.category = "Inline 6 engines"
Engine41I62.weight = 210
Engine41I62.vtec = false
Engine41I62.torque = 350--in Meter/Kg
Engine41I62.flywheelmass = 0.13

Engine41I62.idlerpm = 930--in Rotations Per Minute
Engine41I62.peakminrpm = 2300
Engine41I62.peakmaxrpm = 6500
Engine41I62.limitrpm = 6600
if ( CLIENT ) then
	Engine41I62.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
	Engine41I62.guiupdate = function() return end
end
Mobility2Table["4.1-I62"] = Engine41I62

local Engine32V62 = {}
	Engine32V62.id = "3.2-V62"
	Engine32V62.ent = "acf_engine3"
	Engine32V62.type = "Mobility2"
	Engine32V62.name = "3.2L V6 Petrol"
	Engine32V62.desc = "3.2L Racing V6 Engine"
	Engine32V62.model = "models/engines/v6small.mdl"
	Engine32V62.sound = "/engines/v6/newv6.wav"
	Engine32V62.category = "V6 series"
	Engine32V62.weight = 108
	Engine32V62.vtec = false
	Engine32V62.torque = 385		--in Meter/Kg
	Engine32V62.flywheelmass = 0.15
	
	Engine32V62.idlerpm = 850	--in Rotations Per Minute
	Engine32V62.peakminrpm = 2200
	Engine32V62.peakmaxrpm = 5500
	Engine32V62.limitrpm = 6500
	if ( CLIENT ) then
		Engine32V62.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine32V62.guiupdate = function() return end
	end
Mobility2Table["3.2-V62"] = Engine32V62

local Engine56V82 = {}
Engine56V82.id = "5.6ford-V8"
Engine56V82.ent = "acf_engine3"
Engine56V82.type = "Mobility2"
Engine56V82.name = "5.6L Ford V8"
Engine56V82.desc = "5.6L Ford V8 petrol engine"
Engine56V82.model = "models/engines/v8s.mdl"
Engine56V82.sound = "/scarenginesounds/fordc.wav"
Engine56V82.category = "V8 series"
Engine56V82.weight = 300
Engine56V82.vtec = false
Engine56V82.torque = 470--in Meter/Kg
Engine56V82.flywheelmass = 0.23

Engine56V82.idlerpm = 1000--in Rotations Per Minute
Engine56V82.peakminrpm = 2700
Engine56V82.peakmaxrpm = 6200
Engine56V82.limitrpm = 6700
if ( CLIENT ) then
Engine56V82.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine56V82.guiupdate = function() return end
end
Mobility2Table["5.6ford-V8"] = Engine56V82

local Engine60V82 = {}
Engine60V82.id = "6.0heavy-V8"
Engine60V82.ent = "acf_engine3"
Engine60V82.type = "Mobility2"
Engine60V82.name = "6.0L Heavy V8"
Engine60V82.desc = "6.0L Heavy V8 petrol engine"
Engine60V82.model = "models/engines/v8s.mdl"
Engine60V82.sound = "/scarenginesounds/heavyb.wav"
Engine60V82.category = "V8 series"
Engine60V82.weight = 420
Engine60V82.vtec = false
Engine60V82.torque = 530--in Meter/Kg
Engine60V82.flywheelmass = 0.28

Engine60V82.idlerpm = 1100--in Rotations Per Minute
Engine60V82.peakminrpm = 2500
Engine60V82.peakmaxrpm = 6100
Engine60V82.limitrpm = 6800
if ( CLIENT ) then
Engine60V82.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine60V82.guiupdate = function() return end
end
Mobility2Table["6.0heavy-V8"] = Engine60V82

local Engine53V82 = {}
Engine53V82.id = "5.3f1-V8"
Engine53V82.ent = "acf_engine3"
Engine53V82.type = "Mobility2"
Engine53V82.name = "5.3L F1 V8"
Engine53V82.desc = "5.3L F1 Racing V8 petrol"
Engine53V82.model = "models/engines/v8s.mdl"
Engine53V82.sound = "/engines/v10/viper_on.wav"
Engine53V82.category = "V8 series"
Engine53V82.weight = 280
Engine53V82.vtec = false
Engine53V82.torque = 560--in Meter/Kg
Engine53V82.flywheelmass = 0.24

Engine53V82.idlerpm = 1050--in Rotations Per Minute
Engine53V82.peakminrpm = 1800
Engine53V82.peakmaxrpm = 6700
Engine53V82.limitrpm = 7000
if ( CLIENT ) then
Engine53V82.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
Engine53V82.guiupdate = function() return end
end
Mobility2Table["5.3f1-V8"] = Engine53V82

local Engine48V122 = {}
	Engine48V122.id = "4.8-V122"
	Engine48V122.ent = "acf_engine3"
	Engine48V122.type = "Mobility2"
	Engine48V122.name = "4.8L V12 DBR9"
	Engine48V122.desc = "4.8L Racing DBR9 Engine"
	Engine48V122.model = "models/engines/v12s.mdl"
	Engine48V122.sound = "/engines/v12/dbr9_onmid.wav"
	Engine48V122.category = "V12 series"
	Engine48V122.weight = 180
	Engine48V122.vtec = false
	Engine48V122.torque = 350		--in Meter/Kg
	Engine48V122.flywheelmass = 0.18
	
	Engine48V122.idlerpm = 1100	--in Rotations Per Minute
	Engine48V122.peakminrpm = 1300
	Engine48V122.peakmaxrpm = 6500
	Engine48V122.limitrpm = 7500
	if ( CLIENT ) then
		Engine48V122.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine48V122.guiupdate = function() return end
	end
Mobility2Table["4.8-V122"] = Engine48V122

local Engine54V122 = {}
	Engine54V122.id = "5.4-V122"
	Engine54V122.ent = "acf_engine3"
	Engine54V122.type = "Mobility2"
	Engine54V122.name = "5.4L V12 Zonda"
	Engine54V122.desc = "5.4L Racing Zonda Engine"
	Engine54V122.model = "models/engines/v12s.mdl"
	Engine54V122.sound = "/engines/v12/zonda_on_low.wav"
	Engine54V122.category = "V12 series"
	Engine54V122.weight = 190
	Engine54V122.vtec = false
	Engine54V122.torque = 370		--in Meter/Kg
	Engine54V122.flywheelmass = 0.19
	
	Engine54V122.idlerpm = 1000	--in Rotations Per Minute
	Engine54V122.peakminrpm = 1300
	Engine54V122.peakmaxrpm = 6700
	Engine54V122.limitrpm = 7300
	if ( CLIENT ) then
		Engine54V122.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine54V122.guiupdate = function() return end
	end
Mobility2Table["5.4-V122"] = Engine54V122

local Engine56V122 = {}
	Engine56V122.id = "5.6-V122"
	Engine56V122.ent = "acf_engine3"
	Engine56V122.type = "Mobility2"
	Engine56V122.name = "5.6L V12 Carrera"
	Engine56V122.desc = "5.6L Racing Porche Carrera GT"
	Engine56V122.model = "models/engines/v12s.mdl"
	Engine56V122.sound = "/vehicles/trsounds/carreragt.wav"
	Engine56V122.category = "V12 series"
	Engine56V122.weight = 200
	Engine56V122.vtec = false
	Engine56V122.torque = 390		--in Meter/Kg
	Engine56V122.flywheelmass = 0.19
	
	Engine56V122.idlerpm = 1100	--in Rotations Per Minute
	Engine56V122.peakminrpm = 1300
	Engine56V122.peakmaxrpm = 6500
	Engine56V122.limitrpm = 7400
	if ( CLIENT ) then
		Engine56V122.guicreate = (function( Panel, Table ) ACFEngineGUICreate( Table ) end or nil)
		Engine56V122.guiupdate = function() return end
	end
Mobility2Table["5.6-V122"] = Engine56V122

--###################################################################################################################################
--engine Maker

local EngineMaker = {}
	EngineMaker.id = "Maker"
	EngineMaker.ent = "acf_engine5"
	EngineMaker.type = "Mobility2"
	EngineMaker.desc = "Do not abuse setting, Make your own Engine"
	EngineMaker.name = "Engine from Engine Maker"
	EngineMaker.category = "Engine Maker"
	EngineMaker.modtable = {}
		EngineMaker.modtable[1] = "ACF_engines/v8_special.wav"	--Sound
		EngineMaker.modtable[2] = "models/engines/v8s.mdl"	--Model
		EngineMaker.modtable[3] = 250	--torque
		EngineMaker.modtable[4] = 800	--idle
		EngineMaker.modtable[5] = 2500	--Peak minimum
		EngineMaker.modtable[6] = 6500	--Peak maximum
		EngineMaker.modtable[7] = 7500	--Limit rpm
		EngineMaker.modtable[8] = 0.075	--Flywheel Mass
		EngineMaker.modtable[9] = 100	--Weight
		EngineMaker.modtable[10] = "Engine from Engine Maker" --Name
	if ( CLIENT ) then
		EngineMaker.guicreate = (function( Panel, Table ) ACFEngine5GUICreate( Table ) end or nil)
		EngineMaker.guiupdate = function() return end
	end
Mobility2Table["Maker"] = EngineMaker

--###################################################################################################################################
--###################################################################################################################################
--CVT Gearbox's

--2 speed transfer boxes

local Gear2TS2 = {}
	Gear2TS2.id = "2Gear-T-S2"
	Gear2TS2.ent = "acf_gearbox2"
	Gear2TS2.type = "Mobility2"
	Gear2TS2.name = "CVT, Small"
	Gear2TS2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TS2.model = "models/engines/transaxial_s.mdl"
	Gear2TS2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TS2.category = "CVT Transaxial"
	Gear2TS2.weight = 40
	Gear2TS2.switch = 0.3
	Gear2TS2.maxtq = 800
	Gear2TS2.doubleclutch = false
	Gear2TS2.gears = 2
	Gear2TS2.geartable = {}
		Gear2TS2.geartable[-1] = 0.2      	--final ... removed
		Gear2TS2.geartable[0] = 0			--Nothing
		Gear2TS2.geartable[1] = 0.1			--Gear 1 ratio
		Gear2TS2.geartable[2] = -0.1		--Gear 2 ratio
		Gear2TS2.geartable[3] = 0.13		--Minimum Ratio
		Gear2TS2.geartable[4] = 0.8			--Maximum Ratio
		Gear2TS2.geartable[5] = 6500		--Max rpm
		Gear2TS2.geartable[6] = 5500		--Min rpm
		Gear2TS2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TS2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TS2.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-S2"] = Gear2TS2

local Gear2TM2 = {}
	Gear2TM2.id = "2Gear-T-M2"
	Gear2TM2.ent = "acf_gearbox2"
	Gear2TM2.type = "Mobility2"
	Gear2TM2.name = "CVT, Medium"
	Gear2TM2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TM2.model = "models/engines/transaxial_m.mdl"
	Gear2TM2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TM2.category = "CVT Transaxial"
	Gear2TM2.weight = 70
	Gear2TM2.switch = 0.4
	Gear2TM2.maxtq = 1600
	Gear2TM2.doubleclutch = false
	Gear2TM2.gears = 2
	Gear2TM2.geartable = {}
		Gear2TM2.geartable[-1] = 0.2
		Gear2TM2.geartable[0] = 0
		Gear2TM2.geartable[1] = 0.1
		Gear2TM2.geartable[2] = -0.1
		Gear2TM2.geartable[3] = 0.13
		Gear2TM2.geartable[4] = 0.8
		Gear2TM2.geartable[5] = 6500
		Gear2TM2.geartable[6] = 5500
		Gear2TM2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TM2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TM2.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-M2"] = Gear2TM2

local Gear2TL2 = {}
	Gear2TL2.id = "2Gear-T-L2"
	Gear2TL2.ent = "acf_gearbox2"
	Gear2TL2.type = "Mobility2"
	Gear2TL2.name = "CVT, Large"
	Gear2TL2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TL2.model = "models/engines/transaxial_l.mdl"
	Gear2TL2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TL2.category = "CVT Transaxial"
	Gear2TL2.weight = 100
	Gear2TL2.switch = 0.6
	Gear2TL2.maxtq = 10000
	Gear2TL2.doubleclutch = false
	Gear2TL2.gears = 2
	Gear2TL2.geartable = {}
		Gear2TL2.geartable[-1] = 0.2
		Gear2TL2.geartable[0] = 0
		Gear2TL2.geartable[1] = 0.1
		Gear2TL2.geartable[2] = -0.1
		Gear2TL2.geartable[3] = 0.13
		Gear2TL2.geartable[4] = 0.8
		Gear2TL2.geartable[5] = 6500
		Gear2TL2.geartable[6] = 5500
		Gear2TL2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TL2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TL2.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-L2"] = Gear2TL2

local Gear2LS2 = {}
	Gear2LS2.id = "2Gear-L-S2"
	Gear2LS2.ent = "acf_gearbox2"
	Gear2LS2.type = "Mobility2"
	Gear2LS2.name = "CVT, Small"
	Gear2LS2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LS2.model = "models/engines/linear_s.mdl"
	Gear2LS2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LS2.category = "CVT Inline"
	Gear2LS2.weight = 10
	Gear2LS2.switch = 0.3
	Gear2LS2.maxtq = 800
	Gear2LS2.doubleclutch = false
	Gear2LS2.gears = 2
	Gear2LS2.geartable = {}
		Gear2LS2.geartable[-1] = 0.2
		Gear2LS2.geartable[0] = 0
		Gear2LS2.geartable[1] = 0.1
		Gear2LS2.geartable[2] = -0.1
		Gear2LS2.geartable[3] = 0.13
		Gear2LS2.geartable[4] = 0.8
		Gear2LS2.geartable[5] = 6500
		Gear2LS2.geartable[6] = 5500
		Gear2LS2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LS2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LS2.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-S2"] = Gear2LS2

local Gear2LM2 = {}
	Gear2LM2.id = "2Gear-L-M2"
	Gear2LM2.ent = "acf_gearbox2"
	Gear2LM2.type = "Mobility2"
	Gear2LM2.name = "CVT, Medium"
	Gear2LM2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LM2.model = "models/engines/linear_m.mdl"
	Gear2LM2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LM2.category = "CVT Inline"
	Gear2LM2.weight = 50
	Gear2LM2.switch = 0.4
	Gear2LM2.maxtq = 1600
	Gear2LM2.doubleclutch = false
	Gear2LM2.gears = 2
	Gear2LM2.geartable = {}
		Gear2LM2.geartable[-1] = 0.2
		Gear2LM2.geartable[0] = 0
		Gear2LM2.geartable[1] = 0.1
		Gear2LM2.geartable[2] = -0.1
		Gear2LM2.geartable[3] = 0.13
		Gear2LM2.geartable[4] = 0.8
		Gear2LM2.geartable[5] = 6500
		Gear2LM2.geartable[6] = 5500
		Gear2LM2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LM2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LM2.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-M2"] = Gear2LM2

local Gear2LL2 = {}
	Gear2LL2.id = "2Gear-L-L2"
	Gear2LL2.ent = "acf_gearbox2"
	Gear2LL2.type = "Mobility2"
	Gear2LL2.name = "CVT, Large"
	Gear2LL2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LL2.model = "models/engines/linear_l.mdl"
	Gear2LL2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LL2.category = "CVT Inline"
	Gear2LL2.weight = 100
	Gear2LL2.switch = 0.6
	Gear2LL2.maxtq = 10000
	Gear2LL2.doubleclutch = false
	Gear2LL2.gears = 2
	Gear2LL2.geartable = {}
		Gear2LL2.geartable[-1] = 0.2
		Gear2LL2.geartable[0] = 0
		Gear2LL2.geartable[1] = 0.1
		Gear2LL2.geartable[2] = -0.1
		Gear2LL2.geartable[3] = 0.13
		Gear2LL2.geartable[4] = 0.8
		Gear2LL2.geartable[5] = 6500
		Gear2LL2.geartable[6] = 5500
		Gear2LL2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LL2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LL2.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-L2"] = Gear2LL2

--dual
local Gear2TS3 = {}
	Gear2TS3.id = "2Gear-T-S3"
	Gear2TS3.ent = "acf_gearbox2"
	Gear2TS3.type = "Mobility2"
	Gear2TS3.name = "CVT, Small, Dual Clutch"
	Gear2TS3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TS3.model = "models/engines/transaxial_s.mdl"
	Gear2TS3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TS3.category = "CVT Transaxial"
	Gear2TS3.weight = 40
	Gear2TS3.switch = 0.3
	Gear2TS3.maxtq = 800
	Gear2TS3.doubleclutch = true
	Gear2TS3.gears = 2
	Gear2TS3.geartable = {}
		Gear2TS3.geartable[-1] = 0.2
		Gear2TS3.geartable[0] = 0
		Gear2TS3.geartable[1] = 0.1
		Gear2TS3.geartable[2] = -0.1
		Gear2TS3.geartable[3] = 0.13
		Gear2TS3.geartable[4] = 0.8
		Gear2TS3.geartable[5] = 6500
		Gear2TS3.geartable[6] = 5500
		Gear2TS3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TS3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TS3.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-S3"] = Gear2TS3

local Gear2TM3 = {}
	Gear2TM3.id = "2Gear-T-M3"
	Gear2TM3.ent = "acf_gearbox2"
	Gear2TM3.type = "Mobility2"
	Gear2TM3.name = "CVT, Medium, Dual Clutch"
	Gear2TM3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TM3.model = "models/engines/transaxial_m.mdl"
	Gear2TM3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TM3.category = "CVT Transaxial"
	Gear2TM3.weight = 70
	Gear2TM3.switch = 0.4
	Gear2TM3.maxtq = 1600
	Gear2TM3.doubleclutch = true
	Gear2TM3.gears = 2
	Gear2TM3.geartable = {}
		Gear2TM3.geartable[-1] = 0.2
		Gear2TM3.geartable[0] = 0
		Gear2TM3.geartable[1] = 0.1
		Gear2TM3.geartable[2] = -0.1
		Gear2TM3.geartable[3] = 0.13
		Gear2TM3.geartable[4] = 0.8
		Gear2TM3.geartable[5] = 6500
		Gear2TM3.geartable[6] = 5500
		Gear2TM3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TM3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TM3.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-M3"] = Gear2TM3

local Gear2TL3 = {}
	Gear2TL3.id = "2Gear-T-L3"
	Gear2TL3.ent = "acf_gearbox2"
	Gear2TL3.type = "Mobility2"
	Gear2TL3.name = "CVT, Large, Dual Clutch"
	Gear2TL3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2TL3.model = "models/engines/transaxial_l.mdl"
	Gear2TL3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2TL3.category = "CVT Transaxial"
	Gear2TL3.weight = 100
	Gear2TL3.switch = 0.6
	Gear2TL3.maxtq = 10000
	Gear2TL3.doubleclutch = true
	Gear2TL3.gears = 2
	Gear2TL3.geartable = {}
		Gear2TL3.geartable[-1] = 0.2
		Gear2TL3.geartable[0] = 0
		Gear2TL3.geartable[1] = 0.1
		Gear2TL3.geartable[2] = -0.1
		Gear2TL3.geartable[3] = 0.13
		Gear2TL3.geartable[4] = 0.8
		Gear2TL3.geartable[5] = 6500
		Gear2TL3.geartable[6] = 5500
		Gear2TL3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2TL3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2TL3.guiupdate = function() return end
	end
Mobility2Table["2Gear-T-L3"] = Gear2TL3

local Gear2LS3 = {}
	Gear2LS3.id = "2Gear-L-S3"
	Gear2LS3.ent = "acf_gearbox2"
	Gear2LS3.type = "Mobility2"
	Gear2LS3.name = "CVT, Small, Dual Clutch"
	Gear2LS3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LS3.model = "models/engines/linear_s.mdl"
	Gear2LS3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LS3.category = "CVT Inline"
	Gear2LS3.weight = 10
	Gear2LS3.switch = 0.3
	Gear2LS3.maxtq = 800
	Gear2LS3.doubleclutch = true
	Gear2LS3.gears = 2
	Gear2LS3.geartable = {}
		Gear2LS3.geartable[-1] = 0.2
		Gear2LS3.geartable[0] = 0
		Gear2LS3.geartable[1] = 0.1
		Gear2LS3.geartable[2] = -0.1
		Gear2LS3.geartable[3] = 0.13
		Gear2LS3.geartable[4] = 0.8
		Gear2LS3.geartable[5] = 6500
		Gear2LS3.geartable[6] = 5500
		Gear2LS3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LS3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LS3.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-S3"] = Gear2LS3

local Gear2LM3 = {}
	Gear2LM3.id = "2Gear-L-M3"
	Gear2LM3.ent = "acf_gearbox2"
	Gear2LM3.type = "Mobility2"
	Gear2LM3.name = "CVT, Medium, Dual Clutch"
	Gear2LM3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LM3.model = "models/engines/linear_m.mdl"
	Gear2LM3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LM3.category = "CVT Inline"
	Gear2LM3.weight = 50
	Gear2LM3.switch = 0.4
	Gear2LM3.maxtq = 1600
	Gear2LM3.doubleclutch = true
	Gear2LM3.gears = 2
	Gear2LM3.geartable = {}
		Gear2LM3.geartable[-1] = 0.2
		Gear2LM3.geartable[0] = 0
		Gear2LM3.geartable[1] = 0.1
		Gear2LM3.geartable[2] = -0.1
		Gear2LM3.geartable[3] = 0.13
		Gear2LM3.geartable[4] = 0.8
		Gear2LM3.geartable[5] = 6500
		Gear2LM3.geartable[6] = 5500
		Gear2LM3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LM3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LM3.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-M3"] = Gear2LM3

local Gear2LL3 = {}
	Gear2LL3.id = "2Gear-L-L3"
	Gear2LL3.ent = "acf_gearbox2"
	Gear2LL3.type = "Mobility2"
	Gear2LL3.name = "CVT, Large, Dual Clutch"
	Gear2LL3.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2LL3.model = "models/engines/linear_l.mdl"
	Gear2LL3.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2LL3.category = "CVT Inline"
	Gear2LL3.weight = 100
	Gear2LL3.switch = 0.6
	Gear2LL3.maxtq = 10000
	Gear2LL3.doubleclutch = true
	Gear2LL3.gears = 2
	Gear2LL3.geartable = {}
		Gear2LL3.geartable[-1] = 0.2
		Gear2LL3.geartable[0] = 0
		Gear2LL3.geartable[1] = 0.1
		Gear2LL3.geartable[2] = -0.1
		Gear2LL3.geartable[3] = 0.13
		Gear2LL3.geartable[4] = 0.8
		Gear2LL3.geartable[5] = 6500
		Gear2LL3.geartable[6] = 5500
		Gear2LL3.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2LL3.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2LL3.guiupdate = function() return end
	end
Mobility2Table["2Gear-L-L3"] = Gear2LL3

--straight
local Gear2SS2 = {}
	Gear2SS2.id = "2Gear-S-S2"
	Gear2SS2.ent = "acf_gearbox2"
	Gear2SS2.type = "Mobility2"
	Gear2SS2.name = "CVT, Small"
	Gear2SS2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2SS2.model = "models/engines/t5small.mdl"
	Gear2SS2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2SS2.category = "CVT Straight"
	Gear2SS2.weight = 100
	Gear2SS2.switch = 0.6
	Gear2SS2.maxtq = 10000
	Gear2SS2.doubleclutch = false
	Gear2SS2.gears = 2
	Gear2SS2.geartable = {}
		Gear2SS2.geartable[-1] = 0.2
		Gear2SS2.geartable[0] = 0
		Gear2SS2.geartable[1] = 0.1
		Gear2SS2.geartable[2] = -0.1
		Gear2SS2.geartable[3] = 0.13
		Gear2SS2.geartable[4] = 0.8
		Gear2SS2.geartable[5] = 6500
		Gear2SS2.geartable[6] = 5500
		Gear2SS2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2SS2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2SS2.guiupdate = function() return end
	end
Mobility2Table["2Gear-S-S2"] = Gear2SS2

local Gear2SM2 = {}
	Gear2SM2.id = "2Gear-S-M2"
	Gear2SM2.ent = "acf_gearbox2"
	Gear2SM2.type = "Mobility2"
	Gear2SM2.name = "CVT, Medium"
	Gear2SM2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2SM2.model = "models/engines/t5med.mdl"
	Gear2SM2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2SM2.category = "CVT Straight"
	Gear2SM2.weight = 100
	Gear2SM2.switch = 0.6
	Gear2SM2.maxtq = 10000
	Gear2SM2.doubleclutch = false
	Gear2SM2.gears = 2
	Gear2SM2.geartable = {}
		Gear2SM2.geartable[-1] = 0.2
		Gear2SM2.geartable[0] = 0
		Gear2SM2.geartable[1] = 0.1
		Gear2SM2.geartable[2] = -0.1
		Gear2SM2.geartable[3] = 0.13
		Gear2SM2.geartable[4] = 0.8
		Gear2SM2.geartable[5] = 6500
		Gear2SM2.geartable[6] = 5500
		Gear2SM2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2SM2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2SM2.guiupdate = function() return end
	end
Mobility2Table["2Gear-S-M2"] = Gear2SM2

local Gear2SL2 = {}
	Gear2SL2.id = "2Gear-S-L2"
	Gear2SL2.ent = "acf_gearbox2"
	Gear2SL2.type = "Mobility2"
	Gear2SL2.name = "CVT, Large"
	Gear2SL2.desc = "CVT Gearbox, Automatic 1 speed"
	Gear2SL2.model = "models/engines/t5large.mdl"
	Gear2SL2.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear2SL2.category = "CVT Straight"
	Gear2SL2.weight = 100
	Gear2SL2.switch = 0.6
	Gear2SL2.maxtq = 10000
	Gear2SL2.doubleclutch = false
	Gear2SL2.gears = 2
	Gear2SL2.geartable = {}
		Gear2SL2.geartable[-1] = 0.2
		Gear2SL2.geartable[0] = 0
		Gear2SL2.geartable[1] = 0.1
		Gear2SL2.geartable[2] = -0.1
		Gear2SL2.geartable[3] = 0.13
		Gear2SL2.geartable[4] = 0.8
		Gear2SL2.geartable[5] = 6500
		Gear2SL2.geartable[6] = 5500
		Gear2SL2.geartable[7] = 2500		--Declutch rpm
	if ( CLIENT ) then
		Gear2SL2.guicreate = (function( Panel, Table ) ACFGearbox2GUICreate( Table ) end or nil)
		Gear2SL2.guiupdate = function() return end
	end
Mobility2Table["2Gear-S-L2"] = Gear2SL2

--#############################################################################################################################
--#############################################################################################################################
--Chips

local EngineCV1 = {}
	EngineCV1.id = "Chip-V1"
	EngineCV1.ent = "acf_chips"
	EngineCV1.type = "Mobility2"
	EngineCV1.name = "Chip V2"
	EngineCV1.desc = "Increase engine power"
	EngineCV1.model = "models/jaanus/wiretool/wiretool_gate.mdl"
	EngineCV1.category = "Chips"
	EngineCV1.weight = 1
	EngineCV1.modtable = {}
		EngineCV1.modtable[1] = 60		--Torque Adding
		EngineCV1.modtable[2] = 1000	--RpmMax Adding
		EngineCV1.modtable[3] = 1000	--RpmLimit Adding
	if ( CLIENT ) then
		EngineCV1.guicreate = (function( Panel, Table ) ACFChipsGUICreate( Table ) end or nil)
		EngineCV1.guiupdate = function() return end
	end
Mobility2Table["Chip-V1"] = EngineCV1

--#############################################################################################################################
--Chips VTEC

local EngineCV2 = {}
	EngineCV2.id = "Chip-V2"
	EngineCV2.ent = "acf_vtec"
	EngineCV2.type = "Mobility2"
	EngineCV2.name = "Chip Vtec V2"
	EngineCV2.desc = "This chip Active the normal chip by rpm to make a VTEC"
	EngineCV2.model = "models/jaanus/wiretool/wiretool_gate.mdl"
	EngineCV2.category = "Chips Vtec"
	EngineCV2.weight = 1
	EngineCV2.modtable = {}
		EngineCV2.modtable[1] = 4500	--Rpm Kick
	if ( CLIENT ) then
		EngineCV2.guicreate = (function( Panel, Table ) ACFVtecGUICreate( Table ) end or nil)
		EngineCV2.guiupdate = function() return end
	end
Mobility2Table["Chip-V2"] = EngineCV2

--#############################################################################################################################
--Nos Bottle

local EngineNos = {}
	EngineNos.id = "NosBottle"
	EngineNos.ent = "acf_nos"
	EngineNos.type = "Mobility2"
	EngineNos.name = "Nos Bottle"
	EngineNos.desc = "Increase engine power. More Torque will take more time before Usable."
	EngineNos.model = "models/props_junk/garbage_plasticbottle003a.mdl"
	EngineNos.category = "N2O Boost Bottle"
	EngineNos.sound = "/ambient/machines/steam_release_2.wav"
	EngineNos.weight = 10
	EngineNos.rpmadd = 1000
	EngineNos.modtable = {}
		EngineNos.modtable[1] = 60	--Torque adding
	if ( CLIENT ) then
		EngineNos.guicreate = (function( Panel, Table ) ACFNosGUICreate( Table ) end or nil)
		EngineNos.guiupdate = function() return end
	end
Mobility2Table["NosBottle"] = EngineNos

--###################################################################################################################################
--Automatic Gearbox
--4speed
local Gear4TMA = {}
	Gear4TMA.id = "4Gear-T-MA"
	Gear4TMA.ent = "acf_gearbox3"
	Gear4TMA.type = "Mobility2"
	Gear4TMA.name = "4s, Auto, Transaxial, Medium"
	Gear4TMA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TMA.model = "models/engines/transaxial_m.mdl"
	Gear4TMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TMA.category = "Auto Transaxial 4speed"
	Gear4TMA.weight = 70
	Gear4TMA.switch = 0.1
	Gear4TMA.maxtq = 4000
	Gear4TMA.gears = 4
	Gear4TMA.doubleclutch = false
	Gear4TMA.geartable = {}
		Gear4TMA.geartable[-1] = 0.3	--final
		Gear4TMA.geartable[0] = 0		--unknow
		Gear4TMA.geartable[1] = 0.1		--Gear1
		Gear4TMA.geartable[2] = 0.2		--Gear2
		Gear4TMA.geartable[3] = 0.3		--Gear3
		Gear4TMA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TMA.geartable[7] = 2000	--Declutch Rpm
		Gear4TMA.geartable[8] = 4500	--Rpm Minimum
		Gear4TMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TMA.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-MA"] = Gear4TMA

local Gear4TSA = {}
	Gear4TSA.id = "4Gear-T-SA"
	Gear4TSA.ent = "acf_gearbox3"
	Gear4TSA.type = "Mobility2"
	Gear4TSA.name = "4s, Auto, Transaxial, Small"
	Gear4TSA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TSA.model = "models/engines/transaxial_s.mdl"
	Gear4TSA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TSA.category = "Auto Transaxial 4speed"
	Gear4TSA.weight = 40
	Gear4TSA.switch = 0.1
	Gear4TSA.maxtq = 1000
	Gear4TSA.gears = 4
	Gear4TSA.doubleclutch = false
	Gear4TSA.geartable = {}
		Gear4TSA.geartable[-1] = 0.3	--final
		Gear4TSA.geartable[0] = 0		--unknow
		Gear4TSA.geartable[1] = 0.1		--Gear1
		Gear4TSA.geartable[2] = 0.2		--Gear2
		Gear4TSA.geartable[3] = 0.3		--Gear3
		Gear4TSA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TSA.geartable[7] = 2000	--Declutch Rpm
		Gear4TSA.geartable[8] = 4500	--Rpm Minimum
		Gear4TSA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TSA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TSA.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-SA"] = Gear4TSA

local Gear4TLA = {}
	Gear4TLA.id = "4Gear-T-LA"
	Gear4TLA.ent = "acf_gearbox3"
	Gear4TLA.type = "Mobility2"
	Gear4TLA.name = "4s, Auto, Transaxial, Large"
	Gear4TLA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TLA.model = "models/engines/transaxial_l.mdl"
	Gear4TLA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TLA.category = "Auto Transaxial 4speed"
	Gear4TLA.weight = 200
	Gear4TLA.switch = 0.1
	Gear4TLA.maxtq = 10000
	Gear4TLA.gears = 4
	Gear4TLA.doubleclutch = false
	Gear4TLA.geartable = {}
		Gear4TLA.geartable[-1] = 0.3	--final
		Gear4TLA.geartable[0] = 0		--unknow
		Gear4TLA.geartable[1] = 0.1		--Gear1
		Gear4TLA.geartable[2] = 0.2		--Gear2
		Gear4TLA.geartable[3] = 0.3		--Gear3
		Gear4TLA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TLA.geartable[7] = 2000	--Declutch Rpm
		Gear4TLA.geartable[8] = 4500	--Rpm Minimum
		Gear4TLA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TLA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TLA.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-LA"] = Gear4TLA

--4speed DUAL
local Gear4TMAD = {}
	Gear4TMAD.id = "4Gear-T-MAD"
	Gear4TMAD.ent = "acf_gearbox3"
	Gear4TMAD.type = "Mobility2"
	Gear4TMAD.name = "4s, Auto, Transaxial, Medium, Dual"
	Gear4TMAD.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TMAD.model = "models/engines/transaxial_m.mdl"
	Gear4TMAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TMAD.category = "Auto Transaxial 4speed"
	Gear4TMAD.weight = 70
	Gear4TMAD.switch = 0.1
	Gear4TMAD.maxtq = 4000
	Gear4TMAD.gears = 4
	Gear4TMAD.doubleclutch = true
	Gear4TMAD.geartable = {}
		Gear4TMAD.geartable[-1] = 0.3	--final
		Gear4TMAD.geartable[0] = 0		--unknow
		Gear4TMAD.geartable[1] = 0.1		--Gear1
		Gear4TMAD.geartable[2] = 0.2		--Gear2
		Gear4TMAD.geartable[3] = 0.3		--Gear3
		Gear4TMAD.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TMAD.geartable[7] = 2000	--Declutch Rpm
		Gear4TMAD.geartable[8] = 4500	--Rpm Minimum
		Gear4TMAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TMAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TMAD.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-MAD"] = Gear4TMAD

local Gear4TSAD = {}
	Gear4TSAD.id = "4Gear-T-SAD"
	Gear4TSAD.ent = "acf_gearbox3"
	Gear4TSAD.type = "Mobility2"
	Gear4TSAD.name = "4s, Auto, Transaxial, Small, Dual"
	Gear4TSAD.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TSAD.model = "models/engines/transaxial_s.mdl"
	Gear4TSAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TSAD.category = "Auto Transaxial 4speed"
	Gear4TSAD.weight = 40
	Gear4TSAD.switch = 0.1
	Gear4TSAD.maxtq = 1000
	Gear4TSAD.gears = 4
	Gear4TSAD.doubleclutch = true
	Gear4TSAD.geartable = {}
		Gear4TSAD.geartable[-1] = 0.3	--final
		Gear4TSAD.geartable[0] = 0		--unknow
		Gear4TSAD.geartable[1] = 0.1		--Gear1
		Gear4TSAD.geartable[2] = 0.2		--Gear2
		Gear4TSAD.geartable[3] = 0.3		--Gear3
		Gear4TSAD.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TSAD.geartable[7] = 2000	--Declutch Rpm
		Gear4TSAD.geartable[8] = 4500	--Rpm Minimum
		Gear4TSAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TSAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TSAD.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-SAD"] = Gear4TSAD

local Gear4TLAD = {}
	Gear4TLAD.id = "4Gear-T-LAD"
	Gear4TLAD.ent = "acf_gearbox3"
	Gear4TLAD.type = "Mobility2"
	Gear4TLAD.name = "4s, Auto, Transaxial, Large, Dual"
	Gear4TLAD.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4TLAD.model = "models/engines/transaxial_l.mdl"
	Gear4TLAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4TLAD.category = "Auto Transaxial 4speed"
	Gear4TLAD.weight = 200
	Gear4TLAD.switch = 0.1
	Gear4TLAD.maxtq = 10000
	Gear4TLAD.gears = 4
	Gear4TLAD.doubleclutch = true
	Gear4TLAD.geartable = {}
		Gear4TLAD.geartable[-1] = 0.3	--final
		Gear4TLAD.geartable[0] = 0		--unknow
		Gear4TLAD.geartable[1] = 0.1		--Gear1
		Gear4TLAD.geartable[2] = 0.2		--Gear2
		Gear4TLAD.geartable[3] = 0.3		--Gear3
		Gear4TLAD.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4TLAD.geartable[7] = 2000	--Declutch Rpm
		Gear4TLAD.geartable[8] = 4500	--Rpm Minimum
		Gear4TLAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4TLAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4TLAD.guiupdate = function() return end
	end
Mobility2Table["4Gear-T-LAD"] = Gear4TLAD

--4speed straight
local Gear4SMA = {}
	Gear4SMA.id = "4Gear-S-MA"
	Gear4SMA.ent = "acf_gearbox3"
	Gear4SMA.type = "Mobility2"
	Gear4SMA.name = "4s, Auto, Straight, Medium"
	Gear4SMA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4SMA.model = "models/engines/t5med.mdl"
	Gear4SMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4SMA.category = "Auto Straight 4speed"
	Gear4SMA.weight = 70
	Gear4SMA.switch = 0.1
	Gear4SMA.maxtq = 4000
	Gear4SMA.gears = 4
	Gear4SMA.doubleclutch = false
	Gear4SMA.geartable = {}
		Gear4SMA.geartable[-1] = 0.3	--final
		Gear4SMA.geartable[0] = 0		--unknow
		Gear4SMA.geartable[1] = 0.1		--Gear1
		Gear4SMA.geartable[2] = 0.2		--Gear2
		Gear4SMA.geartable[3] = 0.3		--Gear3
		Gear4SMA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4SMA.geartable[7] = 2000	--Declutch Rpm
		Gear4SMA.geartable[8] = 4500	--Rpm Minimum
		Gear4SMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4SMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4SMA.guiupdate = function() return end
	end
Mobility2Table["4Gear-S-MA"] = Gear4SMA

local Gear4SSA = {}
	Gear4SSA.id = "4Gear-S-SA"
	Gear4SSA.ent = "acf_gearbox3"
	Gear4SSA.type = "Mobility2"
	Gear4SSA.name = "4s, Auto, Straight, Small"
	Gear4SSA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4SSA.model = "models/engines/t5small.mdl"
	Gear4SSA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4SSA.category = "Auto Straight 4speed"
	Gear4SSA.weight = 40
	Gear4SSA.switch = 0.1
	Gear4SSA.maxtq = 1000
	Gear4SSA.gears = 4
	Gear4SSA.doubleclutch = false
	Gear4SSA.geartable = {}
		Gear4SSA.geartable[-1] = 0.3	--final
		Gear4SSA.geartable[0] = 0		--unknow
		Gear4SSA.geartable[1] = 0.1		--Gear1
		Gear4SSA.geartable[2] = 0.2		--Gear2
		Gear4SSA.geartable[3] = 0.3		--Gear3
		Gear4SSA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4SSA.geartable[7] = 2000	--Declutch Rpm
		Gear4SSA.geartable[8] = 4500	--Rpm Minimum
		Gear4SSA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4SSA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4SSA.guiupdate = function() return end
	end
Mobility2Table["4Gear-S-SA"] = Gear4SSA

local Gear4SLA = {}
	Gear4SLA.id = "4Gear-S-LA"
	Gear4SLA.ent = "acf_gearbox3"
	Gear4SLA.type = "Mobility2"
	Gear4SLA.name = "4s, Auto, Straight, Large"
	Gear4SLA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4SLA.model = "models/engines/t5large.mdl"
	Gear4SLA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4SLA.category = "Auto Straight 4speed"
	Gear4SLA.weight = 200
	Gear4SLA.switch = 0.1
	Gear4SLA.maxtq = 10000
	Gear4SLA.gears = 4
	Gear4SLA.doubleclutch = false
	Gear4SLA.geartable = {}
		Gear4SLA.geartable[-1] = 0.3	--final
		Gear4SLA.geartable[0] = 0		--unknow
		Gear4SLA.geartable[1] = 0.1		--Gear1
		Gear4SLA.geartable[2] = 0.2		--Gear2
		Gear4SLA.geartable[3] = 0.3		--Gear3
		Gear4SLA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4SLA.geartable[7] = 2000	--Declutch Rpm
		Gear4SLA.geartable[8] = 4500	--Rpm Minimum
		Gear4SLA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4SLA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4SLA.guiupdate = function() return end
	end
Mobility2Table["4Gear-S-LA"] = Gear4SLA

--4 Speed Inline
local Gear4IMA = {}
	Gear4IMA.id = "4Gear-I-MA"
	Gear4IMA.ent = "acf_gearbox3"
	Gear4IMA.type = "Mobility2"
	Gear4IMA.name = "4s, Auto, Inline, Medium"
	Gear4IMA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4IMA.model = "models/engines/linear_m.mdl"
	Gear4IMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4IMA.category = "Auto Inline 4speed"
	Gear4IMA.weight = 70
	Gear4IMA.switch = 0.1
	Gear4IMA.maxtq = 4000
	Gear4IMA.gears = 4
	Gear4IMA.doubleclutch = false
	Gear4IMA.geartable = {}
		Gear4IMA.geartable[-1] = 0.3	--final
		Gear4IMA.geartable[0] = 0		--unknow
		Gear4IMA.geartable[1] = 0.1		--Gear1
		Gear4IMA.geartable[2] = 0.2		--Gear2
		Gear4IMA.geartable[3] = 0.3		--Gear3
		Gear4IMA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4IMA.geartable[7] = 2000	--Declutch Rpm
		Gear4IMA.geartable[8] = 4500	--Rpm Minimum
		Gear4IMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4IMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4IMA.guiupdate = function() return end
	end
Mobility2Table["4Gear-I-MA"] = Gear4IMA

local Gear4ISA = {}
	Gear4ISA.id = "4Gear-I-SA"
	Gear4ISA.ent = "acf_gearbox3"
	Gear4ISA.type = "Mobility2"
	Gear4ISA.name = "4s, Auto, Inline, Small"
	Gear4ISA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4ISA.model = "models/engines/linear_s.mdl"
	Gear4ISA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4ISA.category = "Auto Inline 4speed"
	Gear4ISA.weight = 40
	Gear4ISA.switch = 0.1
	Gear4ISA.maxtq = 1000
	Gear4ISA.gears = 4
	Gear4ISA.doubleclutch = false
	Gear4ISA.geartable = {}
		Gear4ISA.geartable[-1] = 0.3	--final
		Gear4ISA.geartable[0] = 0		--unknow
		Gear4ISA.geartable[1] = 0.1		--Gear1
		Gear4ISA.geartable[2] = 0.2		--Gear2
		Gear4ISA.geartable[3] = 0.3		--Gear3
		Gear4ISA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4ISA.geartable[7] = 2000	--Declutch Rpm
		Gear4ISA.geartable[8] = 4500	--Rpm Minimum
		Gear4ISA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4ISA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4ISA.guiupdate = function() return end
	end
Mobility2Table["4Gear-I-SA"] = Gear4ISA

local Gear4ILA = {}
	Gear4ILA.id = "4Gear-I-LA"
	Gear4ILA.ent = "acf_gearbox3"
	Gear4ILA.type = "Mobility2"
	Gear4ILA.name = "4s, Auto, Inline, Large"
	Gear4ILA.desc = "A medium sized, 4 speed gearbox, automatic gearbox."
	Gear4ILA.model = "models/engines/linear_l.mdl"
	Gear4ILA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear4ILA.category = "Auto Inline 4speed"
	Gear4ILA.weight = 200
	Gear4ILA.switch = 0.1
	Gear4ILA.maxtq = 10000
	Gear4ILA.gears = 4
	Gear4ILA.doubleclutch = false
	Gear4ILA.geartable = {}
		Gear4ILA.geartable[-1] = 0.3	--final
		Gear4ILA.geartable[0] = 0		--unknow
		Gear4ILA.geartable[1] = 0.1		--Gear1
		Gear4ILA.geartable[2] = 0.2		--Gear2
		Gear4ILA.geartable[3] = 0.3		--Gear3
		Gear4ILA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear4ILA.geartable[7] = 2000	--Declutch Rpm
		Gear4ILA.geartable[8] = 4500	--Rpm Minimum
		Gear4ILA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear4ILA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear4ILA.guiupdate = function() return end
	end
Mobility2Table["4Gear-I-LA"] = Gear4ILA

--6 Speed
local Gear6TSA = {}
	Gear6TSA.id = "6Gear-T-SA"
	Gear6TSA.ent = "acf_gearbox3"
	Gear6TSA.type = "Mobility2"
	Gear6TSA.name = "6s, Auto, Transaxial, Small"
	Gear6TSA.desc = "A small 6 speed gearbox, automatic gearbox."
	Gear6TSA.model = "models/engines/transaxial_s.mdl"
	Gear6TSA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TSA.category = "Auto Transaxial 6speed"
	Gear6TSA.weight = 40
	Gear6TSA.switch = 0.15
	Gear6TSA.maxtq = 1000
	Gear6TSA.gears = 6
	Gear6TSA.doubleclutch = false
	Gear6TSA.geartable = {}
		Gear6TSA.geartable[-1] = 0.3	--final
		Gear6TSA.geartable[0] = 0		--unknow
		Gear6TSA.geartable[1] = 0.1		--Gear1
		Gear6TSA.geartable[2] = 0.2		--Gear2
		Gear6TSA.geartable[3] = 0.3		--Gear3
		Gear6TSA.geartable[4] = 0.4		--Gear4
		Gear6TSA.geartable[5] = 0.5		--Gear5
		Gear6TSA.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TSA.geartable[7] = 2000	--Declutch Rpm
		Gear6TSA.geartable[8] = 4500	--Rpm Minimum
		Gear6TSA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TSA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TSA.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-SA"] = Gear6TSA

local Gear6TMA = {}
	Gear6TMA.id = "6Gear-T-MA"
	Gear6TMA.ent = "acf_gearbox3"
	Gear6TMA.type = "Mobility2"
	Gear6TMA.name = "6s, Auto, Transaxial, Medium"
	Gear6TMA.desc = "A medium duty 6 speed gearbox with a limited torque rating, automatic gearbox."
	Gear6TMA.model = "models/engines/transaxial_m.mdl"
	Gear6TMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TMA.category = "Auto Transaxial 6speed"
	Gear6TMA.weight = 70
	Gear6TMA.switch = 0.1
	Gear6TMA.maxtq = 4000
	Gear6TMA.gears = 6
	Gear6TMA.doubleclutch = false
	Gear6TMA.geartable = {}
		Gear6TMA.geartable[-1] = 0.3	--final
		Gear6TMA.geartable[0] = 0		--unknow
		Gear6TMA.geartable[1] = 0.1		--Gear1
		Gear6TMA.geartable[2] = 0.2		--Gear2
		Gear6TMA.geartable[3] = 0.3		--Gear3
		Gear6TMA.geartable[4] = 0.4		--Gear4
		Gear6TMA.geartable[5] = 0.5		--Gear5
		Gear6TMA.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TMA.geartable[7] = 2000	--Declutch Rpm
		Gear6TMA.geartable[8] = 4500	--Rpm Minimum
		Gear6TMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TMA.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-MA"] = Gear6TMA


local Gear6TLA = {}
	Gear6TLA.id = "6Gear-T-LA"
	Gear6TLA.ent = "acf_gearbox3"
	Gear6TLA.type = "Mobility2"
	Gear6TLA.name = "6s, Auto, Transaxial, Large"
	Gear6TLA.desc = "A large 6 speed gearbox, automatic gearbox."
	Gear6TLA.model = "models/engines/transaxial_l.mdl"
	Gear6TLA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TLA.category = "Auto Transaxial 6speed"
	Gear6TLA.weight = 200
	Gear6TLA.switch = 0.3
	Gear6TLA.maxtq = 10000
	Gear6TLA.gears = 6
	Gear6TLA.doubleclutch = false
	Gear6TLA.geartable = {}
		Gear6TLA.geartable[-1] = 0.3	--final
		Gear6TLA.geartable[0] = 0		--unknow
		Gear6TLA.geartable[1] = 0.1		--Gear1
		Gear6TLA.geartable[2] = 0.2		--Gear2
		Gear6TLA.geartable[3] = 0.3		--Gear3
		Gear6TLA.geartable[4] = 0.4		--Gear4
		Gear6TLA.geartable[5] = 0.5		--Gear5
		Gear6TLA.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TLA.geartable[7] = 2000	--Declutch Rpm
		Gear6TLA.geartable[8] = 4500	--Rpm Minimum
		Gear6TLA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TLA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TLA.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-LA"] = Gear6TLA

--6 Speed dual
local Gear6TSAD = {}
	Gear6TSAD.id = "6Gear-T-SA"
	Gear6TSAD.ent = "acf_gearbox3"
	Gear6TSAD.type = "Mobility2"
	Gear6TSAD.name = "6s, Auto, Transaxial, Small, Dual"
	Gear6TSAD.desc = "A small 6 speed gearbox, automatic gearbox."
	Gear6TSAD.model = "models/engines/transaxial_s.mdl"
	Gear6TSAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TSAD.category = "Auto Transaxial 6speed"
	Gear6TSAD.weight = 40
	Gear6TSAD.switch = 0.15
	Gear6TSAD.maxtq = 1000
	Gear6TSAD.gears = 6
	Gear6TSAD.doubleclutch = true
	Gear6TSAD.geartable = {}
		Gear6TSAD.geartable[-1] = 0.3	--final
		Gear6TSAD.geartable[0] = 0		--unknow
		Gear6TSAD.geartable[1] = 0.1		--Gear1
		Gear6TSAD.geartable[2] = 0.2		--Gear2
		Gear6TSAD.geartable[3] = 0.3		--Gear3
		Gear6TSAD.geartable[4] = 0.4		--Gear4
		Gear6TSAD.geartable[5] = 0.5		--Gear5
		Gear6TSAD.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TSAD.geartable[7] = 2000	--Declutch Rpm
		Gear6TSAD.geartable[8] = 4500	--Rpm Minimum
		Gear6TSAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TSAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TSAD.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-SA"] = Gear6TSAD

local Gear6TMAD = {}
	Gear6TMAD.id = "6Gear-T-MA"
	Gear6TMAD.ent = "acf_gearbox3"
	Gear6TMAD.type = "Mobility2"
	Gear6TMAD.name = "6s, Auto, Transaxial, Medium, Dual"
	Gear6TMAD.desc = "A medium duty 6 speed gearbox, automatic gearbox."
	Gear6TMAD.model = "models/engines/transaxial_m.mdl"
	Gear6TMAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TMAD.category = "Auto Transaxial 6speed"
	Gear6TMAD.weight = 70
	Gear6TMAD.switch = 0.1
	Gear6TMAD.maxtq = 4000
	Gear6TMAD.gears = 6
	Gear6TMAD.doubleclutch = true
	Gear6TMAD.geartable = {}
		Gear6TMAD.geartable[-1] = 0.3	--final
		Gear6TMAD.geartable[0] = 0		--unknow
		Gear6TMAD.geartable[1] = 0.1		--Gear1
		Gear6TMAD.geartable[2] = 0.2		--Gear2
		Gear6TMAD.geartable[3] = 0.3		--Gear3
		Gear6TMAD.geartable[4] = 0.4		--Gear4
		Gear6TMAD.geartable[5] = 0.5		--Gear5
		Gear6TMAD.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TMAD.geartable[7] = 2000	--Declutch Rpm
		Gear6TMAD.geartable[8] = 4500	--Rpm Minimum
		Gear6TMAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TMAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TMAD.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-MA"] = Gear6TMAD


local Gear6TLAD = {}
	Gear6TLAD.id = "6Gear-T-LA"
	Gear6TLAD.ent = "acf_gearbox3"
	Gear6TLAD.type = "Mobility2"
	Gear6TLAD.name = "6s, Auto, Transaxial, Large, Dual"
	Gear6TLAD.desc = "A large 6 speed gearbox, automatic gearbox."
	Gear6TLAD.model = "models/engines/transaxial_l.mdl"
	Gear6TLAD.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6TLAD.category = "Auto Transaxial 6speed"
	Gear6TLAD.weight = 200
	Gear6TLAD.switch = 0.3
	Gear6TLAD.maxtq = 10000
	Gear6TLAD.gears = 6
	Gear6TLAD.doubleclutch = true
	Gear6TLAD.geartable = {}
		Gear6TLAD.geartable[-1] = 0.3	--final
		Gear6TLAD.geartable[0] = 0		--unknow
		Gear6TLAD.geartable[1] = 0.1		--Gear1
		Gear6TLAD.geartable[2] = 0.2		--Gear2
		Gear6TLAD.geartable[3] = 0.3		--Gear3
		Gear6TLAD.geartable[4] = 0.4		--Gear4
		Gear6TLAD.geartable[5] = 0.5		--Gear5
		Gear6TLAD.geartable[6] = -0.1	--Gear6 (reverse)
		Gear6TLAD.geartable[7] = 2000	--Declutch Rpm
		Gear6TLAD.geartable[8] = 4500	--Rpm Minimum
		Gear6TLAD.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6TLAD.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6TLAD.guiupdate = function() return end
	end
Mobility2Table["6Gear-T-LA"] = Gear6TLAD

--6speed straight
local Gear6SMA = {}
	Gear6SMA.id = "6Gear-S-MA"
	Gear6SMA.ent = "acf_gearbox3"
	Gear6SMA.type = "Mobility2"
	Gear6SMA.name = "6s, Auto, Straight, Medium"
	Gear6SMA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6SMA.model = "models/engines/t5med.mdl"
	Gear6SMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6SMA.category = "Auto Straight 6speed"
	Gear6SMA.weight = 70
	Gear6SMA.switch = 0.1
	Gear6SMA.maxtq = 4000
	Gear6SMA.gears = 6
	Gear6SMA.doubleclutch = false
	Gear6SMA.geartable = {}
		Gear6SMA.geartable[-1] = 0.3	--final
		Gear6SMA.geartable[0] = 0		--unknow
		Gear6SMA.geartable[1] = 0.1		--Gear1
		Gear6SMA.geartable[2] = 0.2		--Gear2
		Gear6SMA.geartable[3] = 0.3		--Gear3
		Gear6SMA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6SMA.geartable[7] = 2000	--Declutch Rpm
		Gear6SMA.geartable[8] = 4500	--Rpm Minimum
		Gear6SMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6SMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6SMA.guiupdate = function() return end
	end
Mobility2Table["6Gear-S-MA"] = Gear6SMA

local Gear6SSA = {}
	Gear6SSA.id = "6Gear-S-SA"
	Gear6SSA.ent = "acf_gearbox3"
	Gear6SSA.type = "Mobility2"
	Gear6SSA.name = "6s, Auto, Straight, Small"
	Gear6SSA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6SSA.model = "models/engines/t5small.mdl"
	Gear6SSA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6SSA.category = "Auto Straight 6speed"
	Gear6SSA.weight = 40
	Gear6SSA.switch = 0.1
	Gear6SSA.maxtq = 1000
	Gear6SSA.gears = 6
	Gear6SSA.doubleclutch = false
	Gear6SSA.geartable = {}
		Gear6SSA.geartable[-1] = 0.3	--final
		Gear6SSA.geartable[0] = 0		--unknow
		Gear6SSA.geartable[1] = 0.1		--Gear1
		Gear6SSA.geartable[2] = 0.2		--Gear2
		Gear6SSA.geartable[3] = 0.3		--Gear3
		Gear6SSA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6SSA.geartable[7] = 2000	--Declutch Rpm
		Gear6SSA.geartable[8] = 4500	--Rpm Minimum
		Gear6SSA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6SSA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6SSA.guiupdate = function() return end
	end
Mobility2Table["6Gear-S-SA"] = Gear6SSA

local Gear6SLA = {}
	Gear6SLA.id = "6Gear-S-LA"
	Gear6SLA.ent = "acf_gearbox3"
	Gear6SLA.type = "Mobility2"
	Gear6SLA.name = "6s, Auto, Straight, Large"
	Gear6SLA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6SLA.model = "models/engines/t5large.mdl"
	Gear6SLA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6SLA.category = "Auto Straight 6speed"
	Gear6SLA.weight = 200
	Gear6SLA.switch = 0.1
	Gear6SLA.maxtq = 10000
	Gear6SLA.gears = 6
	Gear6SLA.doubleclutch = false
	Gear6SLA.geartable = {}
		Gear6SLA.geartable[-1] = 0.3	--final
		Gear6SLA.geartable[0] = 0		--unknow
		Gear6SLA.geartable[1] = 0.1		--Gear1
		Gear6SLA.geartable[2] = 0.2		--Gear2
		Gear6SLA.geartable[3] = 0.3		--Gear3
		Gear6SLA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6SLA.geartable[7] = 2000	--Declutch Rpm
		Gear6SLA.geartable[8] = 4500	--Rpm Minimum
		Gear6SLA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6SLA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6SLA.guiupdate = function() return end
	end
Mobility2Table["6Gear-S-LA"] = Gear6SLA

--6 Speed Inline
local Gear6IMA = {}
	Gear6IMA.id = "6Gear-I-MA"
	Gear6IMA.ent = "acf_gearbox3"
	Gear6IMA.type = "Mobility2"
	Gear6IMA.name = "6s, Auto, Inline, Medium"
	Gear6IMA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6IMA.model = "models/engines/linear_m.mdl"
	Gear6IMA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6IMA.category = "Auto Inline 6speed"
	Gear6IMA.weight = 70
	Gear6IMA.switch = 0.1
	Gear6IMA.maxtq = 4000
	Gear6IMA.gears = 6
	Gear6IMA.doubleclutch = false
	Gear6IMA.geartable = {}
		Gear6IMA.geartable[-1] = 0.3	--final
		Gear6IMA.geartable[0] = 0		--unknow
		Gear6IMA.geartable[1] = 0.1		--Gear1
		Gear6IMA.geartable[2] = 0.2		--Gear2
		Gear6IMA.geartable[3] = 0.3		--Gear3
		Gear6IMA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6IMA.geartable[7] = 2000	--Declutch Rpm
		Gear6IMA.geartable[8] = 4500	--Rpm Minimum
		Gear6IMA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6IMA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6IMA.guiupdate = function() return end
	end
Mobility2Table["6Gear-I-MA"] = Gear6IMA

local Gear6ISA = {}
	Gear6ISA.id = "6Gear-I-SA"
	Gear6ISA.ent = "acf_gearbox3"
	Gear6ISA.type = "Mobility2"
	Gear6ISA.name = "6s, Auto, Inline, Small"
	Gear6ISA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6ISA.model = "models/engines/linear_s.mdl"
	Gear6ISA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6ISA.category = "Auto Inline 6speed"
	Gear6ISA.weight = 40
	Gear6ISA.switch = 0.1
	Gear6ISA.maxtq = 1000
	Gear6ISA.gears = 6
	Gear6ISA.doubleclutch = false
	Gear6ISA.geartable = {}
		Gear6ISA.geartable[-1] = 0.3	--final
		Gear6ISA.geartable[0] = 0		--unknow
		Gear6ISA.geartable[1] = 0.1		--Gear1
		Gear6ISA.geartable[2] = 0.2		--Gear2
		Gear6ISA.geartable[3] = 0.3		--Gear3
		Gear6ISA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6ISA.geartable[7] = 2000	--Declutch Rpm
		Gear6ISA.geartable[8] = 4500	--Rpm Minimum
		Gear6ISA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6ISA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6ISA.guiupdate = function() return end
	end
Mobility2Table["6Gear-I-SA"] = Gear6ISA

local Gear6ILA = {}
	Gear6ILA.id = "6Gear-I-LA"
	Gear6ILA.ent = "acf_gearbox3"
	Gear6ILA.type = "Mobility2"
	Gear6ILA.name = "6s, Auto, Inline, Large"
	Gear6ILA.desc = "A medium sized, 6 speed gearbox, automatic gearbox."
	Gear6ILA.model = "models/engines/linear_l.mdl"
	Gear6ILA.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
	Gear6ILA.category = "Auto Inline 6speed"
	Gear6ILA.weight = 200
	Gear6ILA.switch = 0.1
	Gear6ILA.maxtq = 10000
	Gear6ILA.gears = 6
	Gear6ILA.doubleclutch = false
	Gear6ILA.geartable = {}
		Gear6ILA.geartable[-1] = 0.3	--final
		Gear6ILA.geartable[0] = 0		--unknow
		Gear6ILA.geartable[1] = 0.1		--Gear1
		Gear6ILA.geartable[2] = 0.2		--Gear2
		Gear6ILA.geartable[3] = 0.3		--Gear3
		Gear6ILA.geartable[6] = -0.1	--Gear4 (reverse)
		Gear6ILA.geartable[7] = 2000	--Declutch Rpm
		Gear6ILA.geartable[8] = 4500	--Rpm Minimum
		Gear6ILA.geartable[9] = 6500	--Rpm Maximum
	if ( CLIENT ) then
		Gear6ILA.guicreate = (function( Panel, Table ) ACFGearbox3GUICreate( Table ) end or nil)
		Gear6ILA.guiupdate = function() return end
	end
Mobility2Table["6Gear-I-LA"] = Gear6ILA




--###################################################################################################################################



list.Set( "ACFEnts", "Mobility2", Mobility2Table )	--end mobility listing