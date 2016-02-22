--------------------------------------
--	Dupe Encoder Code
--------------------------------------
--Modules
local hasModule = false
if(SERVER)then
	if(system.IsWindows())then
		hasModule = file.Exists("lua/bin/gmsv_ad2filestream_win32.dll", "GAME")
		print(hasModule)
		if(!hasModule)then
			print("[AdvDupe2Notify]\tMODULE NOT INSTALLED CORRECTLY. SAVING WILL BE SLOW.")
		else
			require("ad2filestream")
		end
	end
end
--------------------------------------
--	Set Vars
--------------------------------------
local format = string.format
local char = string.char
local concat = table.concat
local compress = util.Compress
local AD2FF = "AD2F%s\n%s\n%s"
local REVISION = 4
local tables,tablesLookup
local len
local buff
--------------------------------------
--	GenerateDupeStamp
--------------------------------------
function GenerateDupeStamp()
	local stamp = {}
	stamp.name = LocalPlayer():GetName()
	stamp.time = os.date("%I:%M %p")
	stamp.date = os.date("%d %B %Y")
	stamp.timezone = os.date("%z")
	hook.Call("AdvDupe2_StampGenerated",GAMEMODE,stamp)
	return stamp
end
--------------------------------------
--	MakeInfo
--------------------------------------
local function makeInfo(tbl)
	local info = ""
	for k,v in pairs(tbl) do
		info = concat{info,k,"\1",v,"\1"}
	end
	return info.."\2"
end
--------------------------------------
--	NoSerializer
--------------------------------------
local function noserializer() end
local enc = {}
for i=1,255 do enc[i] = noserializer end
--------------------------------------
--	isArray
--------------------------------------
local function isArray(tbl)
	local ret = true
	local m = 0
	
	for k, v in pairs(tbl) do
		m = m + 1
		if k ~= m or enc[TypeID(v)]==noserializer then
			ret = false
			break
		end
	end
	return ret
end
--------------------------------------
--	write
--------------------------------------
local function write(obj)
	enc[TypeID(obj)](obj)
end
-------------------------------------------------
--	Dupe Encoder Code, no Windows or no Modules
-------------------------------------------------
if(not system.IsWindows() or not hasModule)then
	enc[TYPE_TABLE] = function(obj) --table
		tables = tables + 1
		if not tablesLookup[obj] then
			tablesLookup[obj] = tables
		else
			buff:WriteByte(247)
			buff:WriteShort(tablesLookup[obj])
			return
		end
		
		if isArray(obj) then
			buff:WriteByte(254)
			for i,v in pairs(obj) do
				write(v)
			end
		else
			buff:WriteByte(255)
			for k,v in pairs(obj) do
				if(enc[TypeID(v)]!=noserializer)then
					write(k)
					write(v)
				end
			end
		end
		buff:WriteByte(0)
	end
	enc[TYPE_BOOL] = function(obj) --boolean
		buff:WriteByte(obj and 253 or 252)
	end
	enc[TYPE_NUMBER] = function(obj) --number
		buff:WriteByte(251)
		buff:WriteDouble(obj)
	end
	enc[TYPE_VECTOR] = function(obj) --vector
		buff:WriteByte(250)
		buff:WriteDouble(obj.x)
		buff:WriteDouble(obj.y)
		buff:WriteDouble(obj.z)
	end
	enc[TYPE_ANGLE] = function(obj) --angle
		buff:WriteByte(249)
		buff:WriteDouble(obj.p)
		buff:WriteDouble(obj.y)
		buff:WriteDouble(obj.r)
	end
	enc[TYPE_STRING] = function(obj) --string
		len = #obj
		if len > 0 and len < 247 then
			buff:WriteByte(len)
			buff:Write(obj)
		else
			buff:WriteByte(248)
			buff:Write(obj)
			buff:WriteByte(0)
		end
		
	end
--------------------------------------------
--	Dupe Encoder Code Windows or Modules
--------------------------------------------
else
	enc[TYPE_TABLE] = function(obj) --table
		tables = tables + 1
		if not tablesLookup[obj] then
			tablesLookup[obj] = tables
		else
			AdvDupe2_WriteByte(247)
			AdvDupe2_WriteShort(tablesLookup[obj])
			return
		end
		
		if isArray(obj) then
			AdvDupe2_WriteByte(254)
			for i,v in pairs(obj) do
				write(v)
			end
		else
			AdvDupe2_WriteByte(255)
			for k,v in pairs(obj) do
				if(enc[TypeID(v)]!=noserializer)then
					write(k)
					write(v)
				end
			end
		end
		AdvDupe2_WriteByte(0)
	end
	enc[TYPE_BOOL] = function(obj) --boolean
		AdvDupe2_WriteByte(obj and 253 or 252)
	end
	enc[TYPE_NUMBER] = function(obj) --number
		AdvDupe2_WriteByte(251)
		AdvDupe2_WriteDouble(obj)
	end
	enc[TYPE_VECTOR] = function(obj) --vector
		AdvDupe2_WriteByte(250)
		AdvDupe2_WriteDouble(obj.x)
		AdvDupe2_WriteDouble(obj.y)
		AdvDupe2_WriteDouble(obj.z)
	end
	enc[TYPE_ANGLE] = function(obj) --angle
		AdvDupe2_WriteByte(249)
		AdvDupe2_WriteDouble(obj.p)
		AdvDupe2_WriteDouble(obj.y)
		AdvDupe2_WriteDouble(obj.r)
	end
	enc[TYPE_STRING] = function(obj) --string
		len = #obj
		if len > 0 and len < 247 then
			AdvDupe2_WriteByte(len)
			AdvDupe2_WriteString(obj)
		else
			AdvDupe2_WriteByte(248)
			AdvDupe2_WriteString(obj)
			AdvDupe2_WriteByte(0)
		end
	end
end
--------------------------------------
--	Serilize Dupe
--------------------------------------
local function serialize(tbl)
	tables = 0
	tablesLookup = {}

	buff = file.Open("ad2temp.txt", "wb", "DATA")
	write(tbl)
	buff:Close()

	buff = file.Open("ad2temp.txt","rb","DATA")
	local ret = buff:Read(buff:Size())
	buff:Close()
	return ret
end
--------------------------------------
--	Encode Dupe
--------------------------------------
function EncodeACF(callback, ...)
	--Remake table
	local EndTable = {}
	EndTable["HeadEnt"] = DecodedDupeTableHeadEnt["HeadEnt"]
	EndTable["Constraints"] = DecodedDupeTableConstraints["Constraints"]
	EndTable["Entities"] = {}
	for k, v in pairs(DecodedDupeTableEntities) do
		EndTable["Entities"][k] = v
	end
	
	local encodedTable = compress(serialize(EndTable))
	
	local info = GenerateDupeStamp()
	
	info.check = "\r\n\t\n"
	info.size = #encodedTable
	
	callback(AD2FF:format(char(REVISION), makeInfo(info), encodedTable),...)
end