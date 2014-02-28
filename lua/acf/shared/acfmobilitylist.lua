
-- This now loads the files in the engines and gearboxes folders!
-- Go edit those files instead of this one.

AddCSLuaFile()

local MobilityTable = {}
local FuelTankTable = {}

-- setup base engine/gearbox tables so we're not repeating a bunch of unnecessary shit
local engine_base = {}
engine_base.ent = "acf_engine"
engine_base.type = "Mobility"
/*engine_base.powerband = function( rpm ) -- should return a percentage (0-1) of peak torque available
	math.max( math.min( rpm / self.PeakMinRPM, ( self.LimitRPM - rpm ) / ( self.LimitRPM - self.PeakMaxRPM ), 1 ), 0 )
end*/

local gearbox_base = {}
gearbox_base.ent = "acf_gearbox"
gearbox_base.type = "Mobility"
gearbox_base.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"

local fueltank_base = {}
fueltank_base.ent = "acf_fueltank"
fueltank_base.type = "Mobility"

--##############################
--##	setup base			####
--##############################
--engine maker
local enginemaker_base = {}
	enginemaker_base.ent = "acf_enginemaker"
	enginemaker_base.type = "Mobility"
--chips
local chips_base = {}
	chips_base.ent = "acf_chips"
	chips_base.type = "Mobility"
--vtec
local vtec_base = {}
	vtec_base.ent = "acf_vtec"
	vtec_base.type = "Mobility"
--nos
local nos_base = {}
	nos_base.ent = "acf_nos"
	nos_base.type = "Mobility"
--cvt
local cvt_base = {}
	cvt_base.ent = "acf_gearboxcvt"
	cvt_base.type = "Mobility"
	cvt_base.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"
--automatic
--local auto_base = {}
	--auto_base.ent = "acf_gearbox3"
	--auto_base.type = "Mobility"
	--auto_base.sound = "vehicles/junker/jnk_fourth_cruise_loop2.wav"

--##############################
--##		set gui			####
--##############################
if CLIENT then
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
	--vtec
	vtec_base.guicreate = function( panel, tbl ) ACFVtecGUICreate( tbl ) end or nil
	vtec_base.guiupdate = function() return end
	--nos
	nos_base.guicreate = function( panel, tbl ) ACFNosGUICreate( tbl ) end or nil
	nos_base.guiupdate = function() return end
	--CVT
	cvt_base.guicreate = function( panel, tbl ) ACFGearboxCVTGUICreate( tbl ) end or nil
	cvt_base.guiupdate = function() return end
	--automatic
	--auto_base.guicreate = function( panel, tbl ) ACFGearbox3GUICreate( tbl ) end or nil
	--auto_base.guiupdate = function() return end
end

--##############################
--##	define functions	####
--##############################
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
--vtec
function ACF_DefineVtec( id, data )
	data.id = id
	table.Inherit( data, vtec_base )
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
--auto
/*function ACF_DefineAutomatic( id, data )
	data.id = id
	table.Inherit( data, auto_base )
	MobilityTable[ id ] = data
end*/

--##############################
--##	search and load		####
--##############################
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
list.Set( "ACFEnts", "Mobility", MobilityTable )
list.Set( "ACFEnts", "FuelTanks", FuelTankTable )
