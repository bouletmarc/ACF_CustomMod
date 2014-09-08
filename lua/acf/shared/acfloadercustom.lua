
-- This loads the files in the engine, gearbox, fuel, and gun folders!
-- Go edit those files instead of this one.

AddCSLuaFile()

local MobilityTable = {}

-- setup base classes
local enginecustom_base = {
	ent = "acf_engine_custom",
	type = "MobilityCustom"
}
--engine maker
local enginemaker_base = {
	ent = "acf_enginemaker",
	type = "MobilityCustom"
}
--chips
local chips_base = {
	ent = "acf_chips",
	type = "MobilityCustom"
}
--nos
local nos_base = {
	ent = "acf_nos",
	type = "MobilityCustom"
}
--cvt
local cvt_base = {
	ent = "acf_gearboxcvt",
	type = "MobilityCustom",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--airplane
local air_base = {
	ent = "acf_gearboxair",
	type = "MobilityCustom",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--automatic
local auto_base = {
	ent = "acf_gearboxauto",
	type = "MobilityCustom",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--radiator
local rads_base = {
	ent = "acf_rads",
	type = "MobilityCustom"
}

--##############################
--##		set gui			####
--##############################
if CLIENT then
	enginecustom_base.guicreate = function( panel, tbl ) ACFEngineCustomGUICreate( tbl ) end or nil
	enginecustom_base.guiupdate = function() return end
	--engine maker
	enginemaker_base.guicreate = function( panel, tbl ) ACFEngineMakerGUICreate( tbl ) end or nil
	enginemaker_base.guiupdate = function() return end
	--chips
	chips_base.guicreate = function( panel, tbl ) ACFChipsGUICreate( tbl ) end or nil
	chips_base.guiupdate = function() return end
	--nos
	nos_base.guicreate = function( panel, tbl ) ACFNosGUICreate( tbl ) end or nil
	nos_base.guiupdate = function() return end
	--CVT
	cvt_base.guicreate = function( panel, tbl ) ACFGearboxCVTGUICreate( tbl ) end or nil
	cvt_base.guiupdate = function() return end
	--Airplane
	air_base.guicreate = function( panel, tbl ) ACFGearboxAirGUICreate( tbl ) end or nil
	air_base.guiupdate = function() return end
	--automatic
	auto_base.guicreate = function( panel, tbl ) ACFGearboxAutoGUICreate( tbl ) end or nil
	auto_base.guiupdate = function() return end
	--radiator
	rads_base.guicreate = function( panel, tbl ) ACFRadsGUICreate( tbl ) end or nil
	rads_base.guiupdate = function() return end
end

--##############################
--##	define functions	####
--##############################
function ACF_DefineEngine( id, data )
	data.id = id
	table.Inherit( data, enginecustom_base )
	MobilityTable[ id ] = data
end
--engine maker
function ACF_DefineEngineMaker( id, data )
	data.id = id
	table.Inherit( data, enginemaker_base )
	MobilityTable[ id ] = data
end
--chips
function ACF_DefineChips( id, data )
	data.id = id
	table.Inherit( data, chips_base )
	MobilityTable[ id ] = data
end
--nos
function ACF_DefineNos( id, data )
	data.id = id
	table.Inherit( data, nos_base )
	MobilityTable[ id ] = data
end
--cvt
function ACF_DefineCvt( id, data )
	data.id = id
	table.Inherit( data, cvt_base )
	MobilityTable[ id ] = data
end
--airplane
function ACF_DefineGearboxAir( id, data )
	data.id = id
	table.Inherit( data, air_base )
	MobilityTable[ id ] = data
end
--automatic
function ACF_DefineAutomatic( id, data )
	data.id = id
	table.Inherit( data, auto_base )
	MobilityTable[ id ] = data
end
--radiator
function ACF_DefineRads( id, data )
	data.id = id
	table.Inherit( data, rads_base )
	MobilityTable[ id ] = data
end

--##############################
--##	search and load		####
--##############################
local engines = file.Find( "acf/shared/enginescustom/*.lua", "LUA" )
for k, v in pairs( engines ) do
	AddCSLuaFile( "acf/shared/enginescustom/" .. v )
	include( "acf/shared/enginescustom/" .. v )
end
--custom files
local custom = file.Find( "acf/shared/customs/*.lua", "LUA" )
for k, v in pairs( custom ) do
	AddCSLuaFile( "acf/shared/customs/" .. v )
	include( "acf/shared/customs/" .. v )
end

-- now that the mobility table is populated, throw it in the acf ents list
list.Set( "ACFCUSTOMEnts", "MobilityCustom", MobilityTable )
