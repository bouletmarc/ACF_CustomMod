--------------------------------------
--	Set Vars
--------------------------------------
DecodedDupeTableHeadEnt = {}		--HeadEnt table
DecodedDupeTableConstraints = {}	--Constraints table
DecodedDupeTableEntities = {}		--**Sub** Entities table
--------------------------------------
--	Reload values
--------------------------------------
function ReloadValues()
	DecodedDupeTableHeadEnt = {}
	DecodedDupeTableConstraints = {}
	DecodedDupeTableEntities = {}
	
	DupeFixer.EntitiesIDList = {}
	DupeFixer.EnginesListChanged = ""
	DupeFixer.AllowedMode = 0
	DupeFixer.AddedSorted = 0
	DupeFixer.CurrentFile = 0
	DupeFixer.FileTableNotSorted = {}
	DupeFixer.LastFolder = ""
	DupeFixer.OldEngine = ""
	
	--DupeFixer.Version = "Advanced Duplicator2"	--if you want too also
	DupeFixer.Folder = ""	
	DupeFixer.Selected = ""
	
	DupeFixer.Load:SetDisabled(true)
	DupeFixer.Save:SetDisabled(true)
	
	DupeFixer.FoundText:SetText("")
	
	DupeFixer.SaveText:SetText("")
	
	--Reload files list
	UpdateComboBox()
	
	--Reload Display
	acfmenupanelfixer:UpdateDisplay()
end
-------------------------------------------
--	Get Duplicator Version for SubFolder
-------------------------------------------
function GetDuplicatorVersion()
	if DupeFixer.Version == "Advanced Duplicator" then
		DupeFixer.SubFolder = "adv_duplicator"
	elseif DupeFixer.Version == "Advanced Duplicator2" then
		DupeFixer.SubFolder = "advdupe2"
	end
	return true
end
--------------------------------------
--	Get/Set File Selected Text
--------------------------------------
function SelectionText()
	local txt = ""
	if DupeFixer.Selected != "" then
		DupeFixer.BottomText:SetTextColor(Color(0,200,0,255))
		if DupeFixer.Folder == "" then
			txt = DupeFixer.Selected.." Selected!"
		else
			txt = DupeFixer.Folder.."/"..DupeFixer.Selected.." Selected!"
		end
	else
		DupeFixer.BottomText:SetTextColor(Color(200,0,0,255))
		if DupeFixer.Folder == "" then
			txt = "Select a File/Folder"
		else
			txt = "Select a File"
		end
	end
	DupeFixer.BottomText:SetText(txt)
	DupeFixer.BottomText:SizeToContents()
end
--------------------------------------
--	Get/Set Selection for Folder
--------------------------------------
function SelectionFolder()
	--Set folder
	if DupeFixer.Folder != "" then
		DupeFixer.FolderComboBox:SetValue(DupeFixer.Folder)
	else
		DupeFixer.FolderComboBox:SetValue(".NOON SELECTED")
	end
	
	--Set load button
	if DupeFixer.Selected != "" then
		DupeFixer.Load:SetDisabled(false)
	else
		DupeFixer.Load:SetDisabled(true)
		DupeFixer.Save:SetDisabled(true)
	end
	
	SelectionText()
end
--------------------------------------
--	Set Not Loaded
--------------------------------------
function NotLoaded()
	DupeFixer.Save:SetDisabled(true)
	DupeFixer.BottomText:SetTextColor(Color(200,0,0,255))
	DupeFixer.BottomText:SetText(DupeFixer.Selected.." NOT Loaded!")
	DupeFixer.BottomText:SizeToContents()
end
--------------------------------------
--	Set Loaded
--------------------------------------
function Loaded()
	DupeFixer.BottomText:SetText(DupeFixer.Selected.." Loaded!")
	DupeFixer.BottomText:SetTextColor(Color(0,200,0,255))
	DupeFixer.BottomText:SizeToContents()
end
--------------------------------------
--	Decode Table
--------------------------------------
function DecodeTableACF(tbl)
	--Reload
	DecodedDupeTableHeadEnt = {}
	DecodedDupeTableConstraints = {}
	DecodedDupeTableEntities = {}
	
	for k, v in pairs(tbl) do
		if k == "HeadEnt" then
			DecodedDupeTableHeadEnt[k] = v
		elseif k == "Constraints" then
			DecodedDupeTableConstraints[k] = v
		elseif k == "Entities" then
			--Make sub table
			for _, t in pairs(v) do
				if DecodedDupeTableEntities[_] != t then
					DecodedDupeTableEntities[_]=  t
				end
			end
		end
	end
	return true
end
-----------------------------------------
--	Replace Engine&Gearbox Bad values
-----------------------------------------
function ChangeBadValues()
	--Replace CVT&Automatic gearboxes Id
	if DupeFixer.FoundCVT or DupeFixer.FoundAuto or DupeFixer.FoundManual then
		for k, v in pairs(DecodedDupeTableEntities) do
			for key, value in pairs(v) do
				local IDTable = {}
				if key == "Id" and string.find(value, "-") then
					for w in string.gmatch(tostring(value), "([^-]+)") do
						table.insert(IDTable, w)
					end
					if IDTable[2] then	--make sure its inline, transaxial or straight
						if IDTable[2] == "L" or IDTable[2] == "T" or IDTable[2] == "ST" then
							local SubIDTable = string.ToTable(IDTable[3])
							local ChangedString
							local ChangedStringFinal = ""
							if SubIDTable[3] != nil then
								ChangedString = SubIDTable[1]..SubIDTable[3]
							else
								ChangedString = SubIDTable[1]
							end
							ChangedStringFinal = tostring(IDTable[1].."-"..IDTable[2].."-"..ChangedString)
							--Change it
							DecodedDupeTableEntities[k][key] = ChangedStringFinal
						end
					end
				end
			end
		end
	end
	--Add&replace used table airplane gearbox with original
	if DupeFixer.FoundAir then
		for k, v in pairs(DecodedDupeTableEntities) do
			for key, value in pairs(v) do
				--Add data
				if value == "acf_gearbox_air" or value == "acf_gearboxair" then
					DecodedDupeTableEntities[k]["Gear0"] = 0.5
					DecodedDupeTableEntities[k]["Gear1"] = 0.1
					DecodedDupeTableEntities[k]["Gear2"] = 0.2
					DecodedDupeTableEntities[k]["Gear3"] = 0.3
					DecodedDupeTableEntities[k]["Gear4"] = 0.4
					DecodedDupeTableEntities[k]["Gear5"] = 0.5
					DecodedDupeTableEntities[k]["Gear6"] = -0.1
				--make it 6speed
				elseif value == "air_gearbox-s" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-S"
				elseif value == "air_gearbox-m" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-M"
				elseif value == "air_gearbox-l" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-L"
				--change clutch models to straight
				elseif value == "air_gearbox2-t" or value == "air_gearbox2-s" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-S"
					DecodedDupeTableEntities[k]["Model"] = "models/engines/t5small.mdl"
				elseif value == "air_gearbox2-m" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-M"
					DecodedDupeTableEntities[k]["Model"] = "models/engines/t5med.mdl"
				elseif value == "air_gearbox2-b" then
					DecodedDupeTableEntities[k]["Id"] = "6Gear-ST-L"
					DecodedDupeTableEntities[k]["Model"] = "models/engines/t5large.mdl"
				end
			end
		end
	end
	
	--Replace Engines&Gearboxes ID's
	for k, v in pairs(DecodedDupeTableEntities) do
		for key, value in pairs(v) do
			--engines
			if value == "acf_engine_custom" or value == "acf_engine_maker" or value == "acf_enginemaker" then
				DecodedDupeTableEntities[k][key] = "acf_engine"
			--gearboxes
			elseif value == "acf_gearbox_cvt" or value == "acf_gearbox_auto" or value == "acf_gearbox_air" or value == "acf_gearbox_manual" then
				DecodedDupeTableEntities[k][key] = "acf_gearbox"
			--old gearboxes ids
			elseif value == "acf_gearboxcvt" or value == "acf_gearboxauto" or value == "acf_gearboxair" then
				DecodedDupeTableEntities[k][key] = "acf_gearbox"
			end
		end
	end
	
	--Remove not used engines table with acf original
	if DupeFixer.FoundCustom or DupeFixer.FoundMaker then
		for k, v in pairs(DecodedDupeTableEntities) do
			for key, value in pairs(v) do
				--Remove Engine Maker Mods
				if key == "Mod1" or key == "Mod2" or key == "Mod3" or key == "Mod4" or key == "Mod5" then
					DecodedDupeTableEntities[k][key] = nil
				elseif key == "Mod6" or key == "Mod7" or key == "Mod8" or key == "Mod9" or key == "Mod10" then
					DecodedDupeTableEntities[k][key] = nil
				elseif key == "Mod11" or key == "Mod12" or key == "Mod13" or key == "Mod14" or key == "Mod15" then
					DecodedDupeTableEntities[k][key] = nil
				--Remove Link&Wire Inputs
				elseif key == "EntityMods" then
					for key2, value2 in pairs(value) do
						--Remove Link
						if key2 == "ExtraLink" then
							DecodedDupeTableEntities[k][key][key2] = nil
						--Remove Wire Inputs
						elseif key2 == "WireDupeInfo" then
							for key3, value3 in pairs(value2) do
								if key3 == "Wires" then
									for key4, value4 in pairs(value3) do --wires
										if key4 == "TqAdd" or key4 == "RpmAdd" or key4 == "FlywheelMass" then
											DecodedDupeTableEntities[k][key][key2][key3][key4] = nil
										elseif key4 == "Override" or key4 == "Idle" or key4 == "Disable Cutoff" then
											DecodedDupeTableEntities[k][key][key2][key3][key4] = nil
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
--------------------------------------
--	Save Unlocker
--------------------------------------
function SaveUnlocker()
	local SaveUnlockerTable = {}
	--unlock by engine change done
	if DupeFixer.EngineFound then
		for k, v in pairs(acfmenupanelfixer["CData"]) do
			if string.find(k, "EngineTextDone") then
				if acfmenupanelfixer["CData"][k]:GetText() == "REMPLACEMENT DONE" then
					table.insert(SaveUnlockerTable, "true")
				elseif acfmenupanelfixer["CData"][k]:GetText() == "DONE-SAME ID" then
					table.insert(SaveUnlockerTable, "true")
				elseif acfmenupanelfixer["CData"][k]:GetText() == "NOT DONE" then
					table.insert(SaveUnlockerTable, "false")
				else
					table.insert(SaveUnlockerTable, "false")
				end
			end
		end
	end
	--unlock with gearbox
	if DupeFixer.GearboxFound then
		table.insert(SaveUnlockerTable, "true")
	end
	--final unlocker
	local FinalUnlocker = {}
	for k, v in pairs(SaveUnlockerTable) do
		if v == "false" then
			FinalUnlocker[1] = true
		end
	end
	--lock/unlock button
	if FinalUnlocker[1] != nil then
		DupeFixer.Save:SetDisabled(true)
		DupeFixer.SaveText:SetText("")
	else
		DupeFixer.Save:SetDisabled(false)
		DupeFixer.SaveText:SetText("***PLEASE SAVE!***")
		DupeFixer.SaveText:SetTextColor(Color(200,0,0,255))
		DupeFixer.SaveText:SizeToContents()
	end
end
--------------------------------------
--	Set Found Text
--------------------------------------
function SetFoundText()
	--Reload spacing
	MenuSpacing = DupeFixer.InitialSpacing
	--Set vars
	local S1 = ""
	local S2 = ""
	local S3 = ""
	local S4 = ""
	local S5 = ""
	local S6 = ""
	--Set string
	if DupeFixer.FoundCustom then
		S1 = "ENGINE CUSTOM FOUND!\n"
		MenuSpacing = MenuSpacing + 15
	end
	if DupeFixer.FoundMaker then
		S2 = "ENGINE MAKER FOUND!\n"
		MenuSpacing = MenuSpacing + 15
	end
	if DupeFixer.FoundCVT then
		S3 = "GEARBOX CVT FOUND AND CHANGED!\n"
		MenuSpacing = MenuSpacing + 15
	end
	if DupeFixer.FoundAuto then
		S4 = "GEARBOX AUTOMATIC FOUND AND CHANGED!\n"
		MenuSpacing = MenuSpacing + 15
	end
	if DupeFixer.FoundAir then
		S5 = "GEARBOX AIR FOUND AND CHANGED!\n"
		MenuSpacing = MenuSpacing + 15
	end
	if DupeFixer.FoundManual then
		S6 = "GEARBOX MANUAL FOUND AND CHANGED!\n"
		MenuSpacing = MenuSpacing + 15
	end
	--Set color & text
	if DupeFixer.EngineFound or DupeFixer.GearboxFound then
		DupeFixer.FoundText:SetText(S1..S2..S3..S4..S5..S6)
		DupeFixer.FoundText:SetTextColor(Color(0,200,0,255))
	elseif not DupeFixer.EngineFound and not DupeFixer.GearboxFound then
		DupeFixer.FoundText:SetText("NOHING FOUND!")
		DupeFixer.FoundText:SetTextColor(Color(200,0,0,255))
	end
	--resize to content
	DupeFixer.FoundText:SizeToContents()
	
	if DupeFixer.GearboxFound and not DupeFixer.EngineFound then
		--Change not used values in acf original
		ChangeBadValues()
		--Run save unlocker when gearbox found
		SaveUnlocker()
	end
	--Position again DPanelList
	if PositionPanel() then
		return true
	end
end
--------------------------------------
--	Check for Engine&Gearbox
--------------------------------------
function CheckEntities(tbl, EnableSorted, CurrentFileName)
	if DecodeTableACF(tbl) then
		--Check For Engine Custom, Engine Maker or Gearboxes
		DupeFixer.FoundCustom = false
		DupeFixer.FoundMaker = false
		DupeFixer.FoundCVT = false
		DupeFixer.FoundAuto = false
		DupeFixer.FoundAir = false
		DupeFixer.FoundManual = false
		
		DupeFixer.EngineFound = false
		DupeFixer.GearboxFound = false
		
		for k, v in pairs(DecodedDupeTableEntities) do
			for key, value in pairs(v) do
				--check for engines
				if value == "acf_engine_custom" then
					DupeFixer.FoundCustom = true
					DupeFixer.EngineFound = true
				elseif value == "acf_engine_maker" or value == "acf_enginemaker" then
					DupeFixer.FoundMaker = true
					DupeFixer.EngineFound = true
				--check for gearboxes
				elseif value == "acf_gearbox_cvt" or value == "acf_gearboxcvt" then
					DupeFixer.FoundCVT = true
					DupeFixer.GearboxFound = true
				elseif value == "acf_gearbox_auto" or value == "acf_gearboxauto" then
					DupeFixer.FoundAuto = true
					DupeFixer.GearboxFound = true
				elseif value == "acf_gearbox_air" or value == "acf_gearboxair" then
					DupeFixer.FoundAir = true
					DupeFixer.GearboxFound = true
				elseif value == "acf_gearbox_manual" then
					DupeFixer.FoundManual = true
					DupeFixer.GearboxFound = true
				end
			end
		end
		
		if EnableSorted then
			AddSortedFinal(CurrentFileName)
		else
			--set loaded
			Loaded()
			--set found text
			if SetFoundText() then
				if DupeFixer.EngineFound then
					--Create id's available list
					local GetListing = list.Get("ACFCUSTOMEnts")
					local ListingTable = {}
					for ID,Table in pairs(GetListing) do
						ListingTable[ID] = {}
						for EntID,Data in pairs(Table) do
							table.insert(ListingTable[ID], Data)
						end
					end
					
					--Search for same id's
					for k, v in pairs(ListingTable["MobilityCustom"]) do
						for key, value in pairs(DecodedDupeTableEntities) do
							for key2, value2 in pairs(value) do
								if value2 == v.id then
									table.insert(DupeFixer.EntitiesIDList, v.id)
								end
							end
						end
					end
					
					--Create bottom display
					DupeFixerMenuCreate()
				end
			end
		end
	end
end
--------------------------------------
--	Add Files Sorted Final
--------------------------------------
function AddSortedFinal(CurrentFileName)
	if DupeFixer.EngineFound or DupeFixer.GearboxFound then
		--decode name string
		local DecodedNameString = {}
		for w in string.gmatch(tostring(CurrentFileName), "([^/]+)") do
			table.insert(DecodedNameString, w)
		end
		--Add folder list
		local FileName, FileDir = file.Find(DupeFixer.SubFolder.."/*", "DATA")
		for k, v in pairs(FileDir) do
			if v == DecodedNameString[2] and tostring(v) != DupeFixer.LastFolder then
				DupeFixer.LastFolder = tostring(v)
				DupeFixer.FolderComboBox:AddChoice(tostring(v))
			end
		end
		--Add files list
		if DupeFixer.Folder == "" then
			for k, v in pairs(FileName) do
				if v == DecodedNameString[2] then
					DupeFixer.FileListView:AddLine(tostring(v))
				end
			end
		else
			local FolderFileName = file.Find(DupeFixer.SubFolder.."/"..DupeFixer.Folder.."/*", "DATA")
			for k, v in pairs(FolderFileName) do
				if v == DecodedNameString[3] then
					DupeFixer.FileListView:AddLine(tostring(v))
				end
			end
		end
	end
	--return
	AddSorted()
end
--------------------------------------
--	Add Files Sorted
--------------------------------------
function AddSorted(tbl, CurrentFileName)
	--Make a table of all files
	if DupeFixer.AddedSorted == 0 then
		DupeFixer.FolderComboBox:AddChoice(".NOON SELECTED")
		--Add files under folder list
		local FileName, FileDir = file.Find(DupeFixer.SubFolder.."/*", "DATA")
		for k, v in pairs(FileDir) do
			local FolderFileName = file.Find(DupeFixer.SubFolder.."/"..v.."/*", "DATA")
			for key, value in pairs(FolderFileName) do
				table.insert(DupeFixer.FileTableNotSorted, DupeFixer.SubFolder.."/"..v.."/"..value)
			end
		end
		--add files list
		for k, v in pairs(FileName) do
			table.insert(DupeFixer.FileTableNotSorted, DupeFixer.SubFolder.."/"..v)
		end
		
		DupeFixer.AddedSorted = 1
	end
	--Decode file one by one and search values
	if DupeFixer.AddedSorted == 1 then
		DupeFixer.CurrentFile = DupeFixer.CurrentFile + 1
		if DupeFixer.FileTableNotSorted[DupeFixer.CurrentFile] != nil then
			local EnableSorted = true
			DecodeDupeACF(EnableSorted, DupeFixer.FileTableNotSorted[DupeFixer.CurrentFile])
		else
			SelectionFolder()
		end
	end
end
--------------------------------------
--	Add Files Not Sorted
--------------------------------------
function AddNotSorted()
	if GetDuplicatorVersion() then
		--Add folder list
		DupeFixer.FolderComboBox:AddChoice(".NOON SELECTED")
		local FileName, FileDir = file.Find(DupeFixer.SubFolder.."/*", "DATA")
		for k, v in pairs(FileDir) do
			DupeFixer.FolderComboBox:AddChoice(tostring(v))
		end
		
		--Add files list
		if DupeFixer.Folder == "" then
			for k, v in pairs(FileName) do
				DupeFixer.FileListView:AddLine(tostring(v))
			end
		else
			local FolderFileName = file.Find(DupeFixer.SubFolder.."/"..DupeFixer.Folder.."/*", "DATA")
			for k, v in pairs(FolderFileName) do
				DupeFixer.FileListView:AddLine(tostring(v))
			end
		end
		
		SelectionFolder()
	end
end
--------------------------------------
--	Update ComboBox&Text
--------------------------------------
function UpdateComboBox(Sorting)
	--Clear before add files
	DupeFixer.FolderComboBox:Clear(true)
	DupeFixer.FileListView:Clear(true)
	--Add files
	if not Sorting then
		AddNotSorted()
	else
		DupeFixer.FileTableNotSorted = {}
		DupeFixer.LastFolder = ""
		DupeFixer.AddedSorted = 0
		DupeFixer.CurrentFile = 0
		AddSorted()
	end
end
--------------------------------------
--	Check for similar replacement
--------------------------------------
function CheckReplacement(CurrentEngine)
	--clear before adding
	acfmenupanelfixer["CData"]["EngineFoundBox"..CurrentEngine]:Clear(true)
	acfmenupanelfixer["CData"]["EngineFoundBox"..CurrentEngine]:SetValue("Select New Engine ID")
	
	--Check choice allowed engines
	for _, EngineID in pairs(EnginesAllowedTable) do
		local ModelNameFound
		if EngineID == CurrentEngine then
			--Add model of the allowed engine found
			for key, value in pairs(DecodedDupeTableEntities) do
				for key2, value2 in pairs(value) do
					if key2 == "Id" and value2 == CurrentEngine then
						ModelNameFound = DecodedDupeTableEntities[key]["Model"]
					end
				end
			end
			--Check matching engines by models with original acf
			for key, value in pairs(EnginesOriginalTable) do
				local DecodedEngineTable = {}
				for w in string.gmatch(tostring(value), "([^,]+)") do
					table.insert(DecodedEngineTable, w)
				end
				if DecodedEngineTable[2] == ModelNameFound then
					acfmenupanelfixer["CData"]["EngineFoundBox"..CurrentEngine]:AddChoice(DecodedEngineTable[1])
					--Set Same ID
					if DecodedEngineTable[1] == CurrentEngine then
						acfmenupanelfixer["CData"]["EngineFoundBox"..CurrentEngine]:SetValue(DecodedEngineTable[1])
						acfmenupanelfixer["CData"]["EngineTextDone"..CurrentEngine]:SetText("DONE-SAME ID")
						acfmenupanelfixer["CData"]["EngineTextDone"..CurrentEngine]:SetTextColor(Color(0,200,0,255))
						SaveUnlocker()
					end
				end
			end
		end
	end
end
------------------------------------------------
--	Allowed Checkup (used for bottom display)
------------------------------------------------
function AllowedCheckup(EntitiesID)
	--Reload
	DupeFixer.Save:SetDisabled(true)
	DupeFixer.SaveText:SetText("")	
	DupeFixer.AllowedMode = 0
	--Check for any engines custom & maker
	for key, value in pairs(DecodedDupeTableEntities) do
		for key2, value2 in pairs(value) do
			if key2 == "Id" and value2 == EntitiesID then
				if DecodedDupeTableEntities[key]["Class"] == "acf_engine_custom" then
					DupeFixer.AllowedMode = 1
				elseif DecodedDupeTableEntities[key]["Class"] == "acf_engine_maker" then
					DupeFixer.AllowedMode = 1
				elseif DecodedDupeTableEntities[key]["Class"] == "acf_enginemaker" then
					DupeFixer.AllowedMode = 1
				end
			end
		end
	end
	--Not Allowed Check (any engines from unofficial acf)
	for key, value in pairs(EnginesNotAllowedTable) do
		if EntitiesID == value then
			DupeFixer.AllowedMode = 2
		end
	end
	
	return true
end
--------------------------------------
--	Replace Table
--------------------------------------
function ReplaceTable(String)
	local ReplaceTable = {}
	for w in string.gmatch(tostring(String), "([^,]+)") do
		table.insert(ReplaceTable, w)
	end
	for k, v in pairs(DecodedDupeTableEntities) do
		for key, value in pairs(v) do
			if value == ReplaceTable[1] then
				DecodedDupeTableEntities[k][key] = ReplaceTable[2]
				DupeFixer.OldEngine = tostring(ReplaceTable[2])
				SaveUnlocker()
			end
		end	
	end
end
--------------------------------------
--	Save Dupe
--------------------------------------
function SaveDupe(dupe)
	local ChangedName = string.gsub(DupeFixer.Selected, ".txt", "_FIXED.txt")
	local FinalName = ""
	if DupeFixer.Folder != "" then
		FinalName = "advdupe2/"..DupeFixer.Folder.."/"..ChangedName
	else
		FinalName = "advdupe2/"..ChangedName
	end
	file.Write(FinalName, dupe)
	DupeFixer.SaveText:SetText("SAVED AS : "..ChangedName)
	DupeFixer.SaveText:SetTextColor(Color(0,200,0,255))
	DupeFixer.SaveText:SizeToContents()
end