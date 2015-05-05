--------------------------------------
--	Set vars
--------------------------------------
ACFCUSTOM = {}
ACFCUSTOM.VersionCustom = 10.0
ACFCUSTOM.Version = 110
ACFCUSTOM.CurrentVersion = 0
ACFCUSTOM.EngineMakerVersion = 5.0
ACFC = {}
ACFC.R = 0
ACFC.G = 0
ACFC.B = 200
print("[[ ACF Custom Loaded ]]")
--------------------------------------
--	Cvars
--------------------------------------
CreateConVar('sbox_max_acf_modding', 1)
CreateConVar('sbox_max_acf_extra', 12)
CreateConVar('sbox_max_acf_maker', 12)
--------------------------------------
--	Loading Files
--------------------------------------
AddCSLuaFile()
AddCSLuaFile( "acf/client/cl_acfcustom_gui.lua" )
local customfiles = file.Find( "acf/client/custommenu/*.lua", "LUA" )
local customfileshelpmenu = file.Find( "acf/client/custommenu/helpmenu/*.lua", "LUA" )
local customfilesenginemaker = file.Find( "acf/client/custommenu/enginemaker/*.lua", "LUA" )
for k, v in pairs( customfiles ) do
	AddCSLuaFile( "acf/client/custommenu/" .. v )
end
for k, v in pairs( customfileshelpmenu ) do
	AddCSLuaFile( "acf/client/custommenu/helpmenu/" .. v )
end
for k, v in pairs( customfilesenginemaker ) do
	AddCSLuaFile( "acf/client/custommenu/enginemaker/" .. v )
end
--------------------------------------
--	Loading Files Client/Server side
--------------------------------------
if SERVER then
	util.AddNetworkString( "ACFCUSTOM_Notify" )
elseif CLIENT then
	local customfiles2 = file.Find( "acf/client/custommenu/*.lua", "LUA" )
	local customfileshelpmenu2 = file.Find( "acf/client/custommenu/helpmenu/*.lua", "LUA" )
	local customfilesenginemaker2 = file.Find( "acf/client/custommenu/enginemaker/*.lua", "LUA" )
	for k, v in pairs( customfiles2 ) do
		if v != "acf_dupefixer.lua" then
			include( "acf/client/custommenu/" .. v )
		end
	end
	for k, v in pairs( customfileshelpmenu2 ) do
		include( "acf/client/custommenu/helpmenu/" .. v )
	end
	for k, v in pairs( customfilesenginemaker2 ) do
		include( "acf/client/custommenu/enginemaker/" .. v )
	end
end
include("acf/shared/acfloadercustom.lua")

ACFCUSTOM.Weapons = list.Get("ACFCUSTOMEnts")
--------------------------------------
--	Notify
--------------------------------------
if SERVER then
	function ACFCUSTOM_SendNotify( ply, success, msg )
		net.Start( "ACFCUSTOM_Notify" )
			net.WriteBit( success )
			net.WriteString( msg or "" )
		net.Send( ply )
	end
else
	local function ACFCUSTOM_Notify()
		local Type = NOTIFY_ERROR
		if tobool( net.ReadBit() ) then Type = NOTIFY_GENERIC end
		
		GAMEMODE:AddNotify( net.ReadString(), Type, 7 )
	end
	net.Receive( "ACFCUSTOM_Notify", ACFCUSTOM_Notify )
end
--------------------------------------
--	ACF tool category
--------------------------------------
if CLIENT then
	ACFCUSTOM.CustomToolCategory = CreateClientConVar( "acf_tool_category", 0, true, false );

	if( ACFCUSTOM.CustomToolCategory:GetBool() ) then
		language.Add( "spawnmenu.tools.acf", "ACF" );
		hook.Add( "AddToolMenuTabs", "CreateACFCategory", function()
			spawnmenu.AddToolCategory( "Main", "ACF", "#spawnmenu.tools.acf" );
		end );
	end
end
--------------------------------------
--	Check for Updates
--------------------------------------
function ACFCUSTOM_UpdateChecking( )
	print("[ACF] Checking for updates....")
	http.Fetch("https://github.com/bouletmarc/ACF_CustomMod/",function(contents,size)
		local rev = tonumber(string.match( contents, "history\"></span>\n%s*(%d+)\n%s*</span>" ))
		if rev and ACFCUSTOM.Version >= rev then
			print("[ACF] ACF Custom Is Up To Date, Latest Version: "..rev)
		elseif !rev then
			print("[ACF] No Internet Connection Detected! ACF Custom Update Check Failed")
			rev = ACFCUSTOM.Version
		else
			print("[ACF] A newer version of ACF Custom is available! Version: "..rev..", You have Version: "..ACFCUSTOM.Version)
			if CLIENT then chat.AddText( Color( 255, 0, 0 ), "A newer version of ACF Custom is available!" ) end
		end
		ACFCUSTOM.CurrentVersion = rev
	end, function() end)
end
ACFCUSTOM_UpdateChecking( )
--------------------------------------
--	Initial Colors Loading
--------------------------------------
if file.Exists("acf/menucolor.txt", "DATA") then
	local MenuColor = file.Read("acf/menucolor.txt")
	local MenuColorTable = {}
	for w in string.gmatch(MenuColor, "([^,]+)") do
		table.insert(MenuColorTable, w)
	end
	ACFC.R = tonumber(MenuColorTable[1])
	ACFC.G = tonumber(MenuColorTable[2])
	ACFC.B = tonumber(MenuColorTable[3])
end