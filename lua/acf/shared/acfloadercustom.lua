--------------------------------------
--	Initialize
--------------------------------------
AddCSLuaFile()

local MobilityTable = {}
--------------------------------------
--	Setup classes
--------------------------------------
--custom engines
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
--turbo
local turbo_base = {
	ent = "acf_turbo",
	type = "MobilityCustom"
}
--supercharger
local supercharger_base = {
	ent = "acf_supercharger",
	type = "MobilityCustom"
}
--------------------------------------
--	Setup GUI
--------------------------------------
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
	--turbo
	turbo_base.guicreate = function( panel, tbl ) ACFTurboGUICreate( tbl ) end or nil
	turbo_base.guiupdate = function() return end
	--supercharger
	supercharger_base.guicreate = function( panel, tbl ) ACFSuperchargerGUICreate( tbl ) end or nil
	supercharger_base.guiupdate = function() return end
end
--------------------------------------
--	Setup Functions
--------------------------------------
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
--turbo
function ACF_DefineTurbo( id, data )
	data.id = id
	table.Inherit( data, turbo_base )
	MobilityTable[ id ] = data
end
--supercharger
function ACF_DefineSupercharger( id, data )
	data.id = id
	table.Inherit( data, supercharger_base )
	MobilityTable[ id ] = data
end
-------------------------------------
--	Search&Load
--------------------------------------
--Original Engines
local engines = file.Find( "acf/shared/engines/*.lua", "LUA" )
for k, v in pairs( engines ) do
	if v != "electric.lua" or v != "special.lua" or v != "turbine.lua" then
		AddCSLuaFile( "acf/shared/engines/" .. v )
		include( "acf/shared/engines/" .. v )
	end
end
--Custom Engines
local customengines = file.Find( "acf/shared/enginescustom/*.lua", "LUA" )
for k, v in pairs( customengines ) do
	AddCSLuaFile( "acf/shared/enginescustom/" .. v )
	include( "acf/shared/enginescustom/" .. v )
end
--custom files
local custom = file.Find( "acf/shared/customs/*.lua", "LUA" )
for k, v in pairs( custom ) do
	AddCSLuaFile( "acf/shared/customs/" .. v )
	include( "acf/shared/customs/" .. v )
end
--------------------------------------
--	Setup list
--------------------------------------
list.Set( "ACFCUSTOMEnts", "MobilityCustom", MobilityTable )
