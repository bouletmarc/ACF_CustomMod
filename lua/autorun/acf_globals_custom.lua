ACFCUSTOM = {}
--##############
ACFCUSTOM.VersionCustom = 9.21
ACFCUSTOM.Version2 = 105
ACFCUSTOM.CurrentVersion2 = 0
print("[[ ACF Custom Loaded ]]")

--Customs Cvars
CreateConVar('sbox_max_acf_modding', 1)
CreateConVar('sbox_max_acf_extra', 12)
CreateConVar('sbox_max_acf_maker', 12)

AddCSLuaFile()
AddCSLuaFile( "acf/client/cl_acfcustom_gui.lua" )
--Loading Customs Files
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

if SERVER then
	util.AddNetworkString( "ACFCUSTOM_Notify" )
elseif CLIENT then
	--Loading Customs Files
	local customfiles2 = file.Find( "acf/client/custommenu/*.lua", "LUA" )
	local customfileshelpmenu2 = file.Find( "acf/client/custommenu/helpmenu/*.lua", "LUA" )
	local customfilesenginemaker2 = file.Find( "acf/client/custommenu/enginemaker/*.lua", "LUA" )
	for k, v in pairs( customfiles2 ) do
		include( "acf/client/custommenu/" .. v )
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

--Notify
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

--Updating Checking
function ACFCUSTOM_UpdateChecking( )
	print("[ACF] Checking for updates....")
	http.Fetch("https://github.com/bouletmarc/ACF_CustomMod/",function(contents,size)
		local rev2 = tonumber(string.match( contents, "history\"></span>\n%s*(%d+)\n%s*</span>" ))
		if rev2 and ACFCUSTOM.Version2 >= rev2 then
			print("[ACF] ACF Custom Is Up To Date, Latest Version: "..rev2)
		elseif !rev2 then
			print("[ACF] No Internet Connection Detected! ACF Custom Update Check Failed")
			rev2 = ACFCUSTOM.Version2
		else
			print("[ACF] A newer version of ACF Custom is available! Version: "..rev2..", You have Version: "..ACFCUSTOM.Version2)
			if CLIENT then chat.AddText( Color( 255, 0, 0 ), "A newer version of ACF Custom is available!" ) end
		end
		ACFCUSTOM.CurrentVersion2 = rev2
	end, function() end)
end
ACFCUSTOM_UpdateChecking( )
