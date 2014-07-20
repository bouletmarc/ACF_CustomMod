
-- This loads the files in the engine, gearbox, fuel, and gun folders!
-- Go edit those files instead of this one.

AddCSLuaFile()

local GunClasses = {}
local GunTable = {}
local MobilityTable = {}
local FuelTankTable = {}

-- setup base classes
local gun_base = {
	ent = "acf_gun",
	type = "Guns"
}

local engine_base = {
	ent = "acf_engine",
	type = "Mobility"
}

local gearbox_base = {
	ent = "acf_gearbox",
	type = "Mobility",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}

local fueltank_base = {
	ent = "acf_fueltank",
	type = "Mobility"
}

--##############################
--##	setup base			####
--##############################
--engine maker
local enginemaker_base = {
	ent = "acf_enginemaker",
	type = "Mobility"
}
--chips
local chips_base = {
	ent = "acf_chips",
	type = "Mobility"
}
--nos
local nos_base = {
	ent = "acf_nos",
	type = "Mobility"
}
--cvt
local cvt_base = {
	ent = "acf_gearboxcvt",
	type = "Mobility",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--airplane
local air_base = {
	ent = "acf_gearboxair",
	type = "Mobility",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--automatic
local auto_base = {
	ent = "acf_gearboxauto",
	type = "Mobility",
	sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
}
--radiator
local rads_base = {
	ent = "acf_rads",
	type = "Mobility"
}

--##############################
--##		set gui			####
--##############################
if CLIENT then
	gun_base.guicreate = function( Panel, Table ) ACFGunGUICreate( Table ) end or nil
	gun_base.guiupdate = function() return end
	engine_base.guicreate = function( panel, tbl ) ACFEngineGUICreate( tbl ) end or nil
	engine_base.guiupdate = function() return end
	gearbox_base.guicreate = function( panel, tbl ) ACFGearboxGUICreate( tbl ) end or nil
	gearbox_base.guiupdate = function() return end
	fueltank_base.guicreate = function( panel, tbl ) ACFFuelTankGUICreate( tbl ) end or nil
	fueltank_base.guiupdate = function( panel, tbl ) ACFFuelTankGUIUpdate( tbl ) end or nil
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
function ACF_defineGunClass( id, data )
	data.id = id
	GunClasses[ id ] = data
end

function ACF_defineGun( id, data )
	data.id = id
	data.round.id = id
	table.Inherit( data, gun_base )
	GunTable[ id ] = data
end

function ACF_DefineEngine( id, data )
	data.id = id
	table.Inherit( data, engine_base )
	MobilityTable[ id ] = data
end

function ACF_DefineGearbox( id, data )
	data.id = id
	table.Inherit( data, gearbox_base )
	MobilityTable[ id ] = data
end

function ACF_DefineFuelTank( id, data )
	data.id = id
	table.Inherit( data, fueltank_base )
	MobilityTable[ id ] = data
end

function ACF_DefineFuelTankSize( id, data )
	data.id = id
	table.Inherit( data, fueltank_base )
	FuelTankTable[ id ] = data
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
local guns = file.Find( "acf/shared/guns/*.lua", "LUA" )
for k, v in pairs( guns ) do
	AddCSLuaFile( "acf/shared/guns/" .. v )
	include( "acf/shared/guns/" .. v )
end

local engines = file.Find( "acf/shared/engines/*.lua", "LUA" )
for k, v in pairs( engines ) do
	AddCSLuaFile( "acf/shared/engines/" .. v )
	include( "acf/shared/engines/" .. v )
end

local gearboxes = file.Find( "acf/shared/gearboxes/*.lua", "LUA" )
for k, v in pairs( gearboxes ) do
	AddCSLuaFile( "acf/shared/gearboxes/" .. v )
	include( "acf/shared/gearboxes/" .. v )
end

local fueltanks = file.Find( "acf/shared/fueltanks/*.lua", "LUA" )
for k, v in pairs( fueltanks ) do
	AddCSLuaFile( "acf/shared/fueltanks/" .. v )
	include( "acf/shared/fueltanks/" .. v )
end
--custom files
local custom = file.Find( "acf/shared/customs/*.lua", "LUA" )
for k, v in pairs( custom ) do
	AddCSLuaFile( "acf/shared/customs/" .. v )
	include( "acf/shared/customs/" .. v )
end

-- now that the mobility table is populated, throw it in the acf ents list
list.Set( "ACFClasses", "GunClass", GunClasses )
list.Set( "ACFEnts", "Guns", GunTable )
list.Set( "ACFEnts", "Mobility", MobilityTable )
list.Set( "ACFEnts", "FuelTanks", FuelTankTable )
