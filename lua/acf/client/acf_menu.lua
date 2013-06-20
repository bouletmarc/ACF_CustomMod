// A sound browser for the sound emitter and the expression 2 editor.
// Made by Grocel.

local max_char_count = 200 //File length limit

local SoundBrowserPanel = nil
local TabFileBrowser = nil
local TabModelBrowser = nil
local TabFavourites = nil
local TabFavourites2 = nil
local SoundObj = nil
local SoundObjNoEffect = nil

// Set the volume of the sound.
local function SetSoundVolume(volume)
	if(!SoundObj) then return end

	SoundObj:ChangeVolume(tonumber(volume) or 1, 0.1)
end

// Set the pitch of the sound.
local function SetSoundPitch(pitch)
	if(!SoundObj) then return end

	SoundObj:ChangePitch(tonumber(pitch) or 100, 0.1)
end

// Play the given sound, if no sound is given then mute a playing sound.
local function PlaySound(file, volume, pitch)
	if(SoundObj) then
		SoundObj:Stop()
		SoundObj = nil
	end

	if (!file or file == "") then return end

	local ply = LocalPlayer()
	if (!IsValid(ply)) then return end

	util.PrecacheSound(file)

	SoundObj = CreateSound(ply, file)
	if(SoundObj) then
		SoundObj:PlayEx(tonumber(volume) or 1, tonumber(pitch) or 100)
	end
end

// Play the given sound without effects, if no sound is given then mute a playing sound.
local function PlaySoundNoEffect(file)
	if(SoundObjNoEffect) then
		SoundObjNoEffect:Stop()
		SoundObjNoEffect = nil
	end

	if (!file or file == "") then return end

	local ply = LocalPlayer()
	if (!IsValid(ply)) then return end

	util.PrecacheSound(file)

	SoundObjNoEffect = CreateSound(ply, file)
	if(SoundObjNoEffect) then
		SoundObjNoEffect:PlayEx(1, 100)
	end
end

 // Output the infos about the given sound.
 local function GetFileInfos(strfile)
	if (!isstring(strfile) or strfile == "") then return end

	//local nduration = SoundDuration(strfile) //getting the duration is very slow.
	//if(nduration) then
	//	nduration = math.Round(nduration * 1000) / 1000
	//end

	local nsize = tonumber(file.Size("sound/" .. strfile, "GAME") or "-1")
	local strformat = string.lower(string.GetExtensionFromFilename(strfile) or "n/a")

	return nsize, strformat, nduration
end

local function FormatSize(nsize, nduration)
	if (!nsize) then return end
	nduration = nduration or 0

	//Negative filessizes aren't Valid.
	if (nsize < 0) then return end

	return nsize, string.NiceSize(nsize) //math.Round((nsize / 1024) * 1000) / 1000
end

local function FormatLength(nduration, nsize)
	if (!nduration) then return end
	nsize = nsize or 0

	//Negative durations aren't Valid.
	if (nduration < 0) then return end

	local nm = math.floor(nduration / 60)
	local ns = math.floor(nduration % 60)
	local nms = (nduration % 1) * 1000
	return nduration, (string.format("%01d", nm)..":"..string.format("%02d", ns).."."..string.format("%03d", nms))
end
 
// Output the infos about the given sound. Used for the info text.
 local function GetInfoString(strfile, tabdata)
	local nsize, strformat, nduration = GetFileInfos(strfile)
	if (!nsize) then return "" end

	nduration = SoundDuration(strfile) //Get the duration for the info text only.
	if(nduration) then
		nduration = math.Round(nduration * 1000) / 1000
	end

	local nduration, strduration = FormatLength(nduration, nsize)
	local strlength = "\n\rLength: "..(strduration and (strduration.." ("..nduration .." Seconds)") or "n/a")

	if (tabdata[1] == "property") then
		return ("Name: "..strfile..strlength.."\n\rType: "..tabdata[1])
	end

	local nsizeB, strsize = FormatSize(nsize, nduration)
	local strSize = "\n\rSize: "..(strsize and (strsize.." ("..nsizeB .." Bytes)") or "n/a")

	return ("Name: "..strfile..strlength..strSize.."\n\rType: "..(tabdata[1] or "file").."\n\rFormat: "..strformat)
end

local function SetupSoundemitter(strSound)
	// Setup the Soundemitter stool with the soundpath.
	RunConsoleCommand("wire_soundemitter_sound", strSound)

end

local function SetupModelemitter(strModel)
	// Setup the Soundemitter stool with the soundpath.
	RunConsoleCommand("wire_soundemitter_model", strModel)

end

local function SetupClipboard(strSound)
	// Copy the soundpath to Clipboard.
	SetClipboardText(strSound)
end

local function SetupClipboard2(strModel)
	// Copy the soundpath to Clipboard.
	SetClipboardText(strModel)
end

local function Sendmenu(strSound, SoundEmitter, nSoundVolume, nSoundPitch) // Open a sending and setup menu on right click on a sound file.
	if isstring(strSound) and strSound ~= "" then
		local Menu = DermaMenu()
		local MenuItem = nil
		local gray = 30

		if (SoundEmitter) then

			//Setup soundemitter
				MenuItem = Menu:AddOption("Setup Engine sound", function()
					SetupSoundemitter(strSound)
				end)
				MenuItem:SetImage("icon16/sound.png")

			//Copy to clipboard
				MenuItem = Menu:AddOption("Copy to clipboard", function()
					SetupClipboard(strSound)
				end)
				MenuItem:SetImage("icon16/page_paste.png")

			else

			//Copy to clipboard
				MenuItem = Menu:AddOption("Copy to clipboard", function()
					SetupClipboard(strSound)
				end)
				MenuItem:SetImage("icon16/page_paste.png")

			//Setup soundemitter
				MenuItem = Menu:AddOption("Setup Engine sound", function()
					SetupSoundemitter(strSound)
				end)
				MenuItem:SetImage("icon16/sound.png")

		end

		Menu:AddSpacer()

		if (IsValid(TabFavourites)) then
			// Add the soundpath to the favourites.
			if (TabFavourites:ItemInList(strSound)) then

				//Remove from favourites
					MenuItem = Menu:AddOption("Remove from favourites", function()
						TabFavourites:RemoveItem(strSound)
					end)
					MenuItem:SetImage("icon16/bin_closed.png")

			else

				//Add to favourites
					MenuItem = Menu:AddOption("Add to favourites", function()
						TabFavourites:AddItem(strSound, "file")
					end)
					MenuItem:SetImage("icon16/star.png")
					local max_item_count = 512
					local count = TabFavourites.TabfileCount
					if (count >= max_item_count) then
						MenuItem:SetTextColor(Color(gray,gray,gray,255)) // custom disabling
						MenuItem.DoClick = function() end

						MenuItem:SetToolTip("The favourites list is Full! It can't hold more than "..max_item_count.." items!")
					end

			end
		end

		Menu:AddSpacer()

		//Print to console
			MenuItem = Menu:AddOption("Print to console", function()
				// Print the soundpath in the Console/HUD.
				local ply = LocalPlayer()
				if (!IsValid(ply)) then return end

				ply:PrintMessage( HUD_PRINTTALK, strSound)
			end)
			MenuItem:SetImage("icon16/monitor_go.png")

		//Print to Chat
			MenuItem = Menu:AddOption("Print to Chat", function()
				// Say the the soundpath.
				RunConsoleCommand("say", strSound)
			end)
			MenuItem:SetImage("icon16/group_go.png")

			local max_char_chat_count = 110 // chat has a ~128 char limit, varies depending on char wide.
			local len = #strSound
			if (len > max_char_chat_count) then
				local gray = 50
				MenuItem:SetTextColor(Color(gray,gray,gray,255)) // custom disabling
				MenuItem.DoClick = function() end

				MenuItem:SetToolTip("The filepath ("..len.." chars) is too long to print in chat. It should be shorter than "..max_char_chat_count.." chars!")
			end

		Menu:AddSpacer()

		//Play
			MenuItem = Menu:AddOption("Play", function()
				PlaySound(strSound, nSoundVolume, nSoundPitch)
				PlaySoundNoEffect()
			end)
			MenuItem:SetImage("icon16/control_play.png")

		//Play without effects
			MenuItem = Menu:AddOption("Play without effects", function()
				PlaySound()
				PlaySoundNoEffect(strSound)
			end)
			MenuItem:SetImage("icon16/control_play_blue.png")

		Menu:Open()
	end
end

--################################################################################
local function Sendmenu2(strModel, ModelEmitter) // Open a sending and setup menu on right click on a sound file.
	if isstring(strModel) and strModel ~= "" then
		local Menu = DermaMenu()
		local MenuItem = nil
		local gray = 30

		if (ModelEmitter) then

			//Setup soundemitter
				MenuItem = Menu:AddOption("Setup Engine Model", function()
					SetupModelemitter(strModel)
				end)
				MenuItem:SetImage("icon16/sound.png")

			//Copy to clipboard
				MenuItem = Menu:AddOption("Copy to clipboard", function()
					SetupClipboard2(strModel)
				end)
				MenuItem:SetImage("icon16/page_paste.png")

			else

			//Copy to clipboard
				MenuItem = Menu:AddOption("Copy to clipboard", function()
					SetupClipboard2(strModel)
				end)
				MenuItem:SetImage("icon16/page_paste.png")

			//Setup soundemitter
				MenuItem = Menu:AddOption("Setup Engine Model", function()
					SetupModelemitter(strModel)
				end)
				MenuItem:SetImage("icon16/sound.png")

		end

		Menu:AddSpacer()

		//Print to console
			MenuItem = Menu:AddOption("Print to console", function()
				// Print the soundpath in the Console/HUD.
				local ply = LocalPlayer()
				if (!IsValid(ply)) then return end

				ply:PrintMessage( HUD_PRINTTALK, strModel)
			end)
			MenuItem:SetImage("icon16/monitor_go.png")

		//Print to Chat
			MenuItem = Menu:AddOption("Print to Chat", function()
				// Say the the soundpath.
				RunConsoleCommand("say", strModel)
			end)
			MenuItem:SetImage("icon16/group_go.png")

			local max_char_chat_count = 110 // chat has a ~128 char limit, varies depending on char wide.
			local len = #strModel
			if (len > max_char_chat_count) then
				local gray = 50
				MenuItem:SetTextColor(Color(gray,gray,gray,255)) // custom disabling
				MenuItem.DoClick = function() end

				MenuItem:SetToolTip("The filepath ("..len.." chars) is too long to print in chat. It should be shorter than "..max_char_chat_count.." chars!")
			end

		Menu:Open()
	end
end
--################################################################################

// Save the file path. It should be cross session.
// It's used when opening the browser in the e2 editor.
local function SaveFilePath(panel, file)
	if (!IsValid(panel)) then return end
	if (panel.Soundemitter) then return end

	panel:SetCookie("wire_soundfile", file)
end

// Open the Sound Browser.
local function CreateSoundBrowser(path)
	local soundemitter = false
	local modelemitter = false
	if (isstring(path) and path ~= "") then
		soundemitter = true
		modelemitter = true
	end

	local strSound = ""
	local strModel = ""
	local nSoundVolume = 1
	local nSoundPitch = 100

	SoundBrowserPanel = vgui.Create("DFrame") // The main frame.
	SoundBrowserPanel:SetPos(50,25)
	SoundBrowserPanel:SetSize(850, 500)

	SoundBrowserPanel:SetMinWidth(750)
	SoundBrowserPanel:SetMinHeight(500)

	SoundBrowserPanel:SetSizable(true)
	SoundBrowserPanel:SetDeleteOnClose( false )
	SoundBrowserPanel:SetTitle("Engine Menu V4.2 Advanced")
	SoundBrowserPanel:SetVisible(false)
	SoundBrowserPanel:SetCookieName( "wire_sound_browser" )
	SoundBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.

	TabFileBrowser = vgui.Create("acf_filebrowser") // The file tree browser.
	TabFavourites = vgui.Create("acf_listeditor") // The favourites manager.
	TabModelBrowser = vgui.Create("acf_modelbrowser") // The file tree browser.
	TabFavourites2 = vgui.Create("acf_list2editor") // The favourites manager.
	// Todo: Add a tab with a sound property browser. sound.GetTable() needed.
	
	local ButtonsSidePanel = SoundBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 0, 4, 0)
	ButtonsSidePanel:Dock(RIGHT)
	ButtonsSidePanel:SetWide( 200 )
	ButtonsSidePanel:SetDrawBackground(false)
	local ButtonsSidePanel2 = ButtonsSidePanel:Add("DPanel") // The buttons.
	ButtonsSidePanel2:DockMargin(4, 0, 4, 0)
	ButtonsSidePanel2:Dock(TOP)
	ButtonsSidePanel2:SetWide( 200 )
	ButtonsSidePanel2:SetHeight( 200 )
	ButtonsSidePanel2:SetDrawBackground(true)
	--####################
		DisplayModel3 = ButtonsSidePanel2:Add("DModelPanel")
		DisplayModel3:SetModel( strModel )
		DisplayModel3:SetCamPos( Vector( 250 , 500 , 250 ) )
		DisplayModel3:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel3:SetFOV( 15 )
		DisplayModel3:SetSize( 200 , 200 )
		DisplayModel3.LayoutEntity = function( panel , entity ) end
		
		EngineNameTitle = ButtonsSidePanel:Add( "DLabel" )
			EngineNameTitle:SetText( "Engine Name :" )
			EngineNameTitle:SetFont( "DefaultBold" )
			EngineNameTitle:SetTextColor(Color(0,0,200,255))
			EngineNameTitle:SetPos( 5,205 )
			EngineNameTitle:SetWide( 210 )
		
		EngineName = ButtonsSidePanel:Add( "DTextEntry" )
			EngineName:SetText( "PUT NAME HERE" )
			EngineName:SetTextColor(Color(200,0,0,255))
			EngineName:SetPos( 5,220 )
			EngineName:SetWide( 210 )
			EngineName.OnTextChanged = function( )
				if EngineName:GetValue() == "" then
					EngineName:SetText( "PUT NAME HERE" )
					EngineName:SetTextColor(Color(200,0,0,255))
					RunConsoleCommand( "acfmenu_data10", EngineName:GetValue() )
				else
					RunConsoleCommand( "acfmenu_data10", EngineName:GetValue() )
					EngineName:SetTextColor(Color(0,0,200,255))
				end
			end
			
		PowerText = ButtonsSidePanel:Add( "DLabel" )
			ValueText = math.floor(100 * 100 / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ ".."100 RPM")
			PowerText:SetTextColor(Color(0,0,200,255))
			PowerText:SetPos( 5,250 )
			PowerText:SizeToContents()

	
		SliderT = ButtonsSidePanel:Add( "DNumSlider" )
			SliderT:SetText( "Torque" )
			SliderT:SetMin( 40 )
			SliderT:SetMax( 3000 )
			SliderT:SetDecimals( 0 )
			SliderT:SetValue( 250 )
			RunConsoleCommand( "acfmenu_data3", SliderT:GetValue() )
			SliderT:SetPos( 5,260 )
			SliderT:SetWide( 210 )
			SliderT.Label:SetWide(50)
			SliderT.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data3", val )
				ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
				ValueText2 = math.Round(ValueText*1.34)
				PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
				PowerText:SizeToContents()
			end
			
		SliderIdle = ButtonsSidePanel:Add( "DNumSlider" )
			SliderIdle:SetText( "Idle Rpm" )
			SliderIdle:SetMin( 400 )
			SliderIdle:SetMax( 2500 )
			SliderIdle:SetDecimals( 0 )
			SliderIdle:SetValue( 1000 )
			RunConsoleCommand( "acfmenu_data4", SliderIdle:GetValue() )
			SliderIdle:SetPos( 5,290 )
			SliderIdle:SetWide( 210 )
			SliderIdle.Label:SetWide(50)
			SliderIdle.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data4", val )
				if(SliderIdle:GetValue() > SliderPeakMin:GetValue()) then
					SliderPeakMin:SetValue( SliderIdle:GetValue() )
					RunConsoleCommand( "acfmenu_data5", SliderPeakMin:GetValue() )
				end
			end
			
		SliderPeakMin = ButtonsSidePanel:Add( "DNumSlider" )
			SliderPeakMin:SetText( "Peak Min" )
			SliderPeakMin:SetMin( 1000 )
			SliderPeakMin:SetMax( 4500 )
			SliderPeakMin:SetDecimals( 0 )
			SliderPeakMin:SetValue( 2500 )
			RunConsoleCommand( "acfmenu_data5", SliderPeakMin:GetValue() )
			SliderPeakMin:SetPos( 5,320 )
			SliderPeakMin:SetWide( 210 )
			SliderPeakMin.Label:SetWide(50)
			SliderPeakMin.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data5", val )
				if(SliderPeakMin:GetValue() > SliderPeakMax:GetValue()) then
					SliderPeakMax:SetValue( SliderPeakMin:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
				end
				if(SliderPeakMin:GetValue() < SliderIdle:GetValue()) then
					SliderIdle:SetValue( SliderPeakMin:GetValue() )
					RunConsoleCommand( "acfmenu_data4", SliderIdle:GetValue() )
				end
			end
			
		SliderPeakMax = ButtonsSidePanel:Add( "DNumSlider" )
			SliderPeakMax:SetText( "Peak Max" )
			SliderPeakMax:SetMin( 4000 )
			SliderPeakMax:SetMax( 12000 )
			SliderPeakMax:SetDecimals( 0 )
			SliderPeakMax:SetValue( 6500 )
			RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
			SliderPeakMax:SetPos( 5,350 )
			SliderPeakMax:SetWide( 210 )
			SliderPeakMax.Label:SetWide(50)
			SliderPeakMax.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data6", val )
				ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
				ValueText2 = math.Round(ValueText*1.34)
				PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
				PowerText:SizeToContents()
				if(SliderPeakMax:GetValue() > SliderLimit:GetValue()) then
					SliderLimit:SetValue( SliderPeakMax:GetValue() )
					RunConsoleCommand( "acfmenu_data7", SliderLimit:GetValue() )
				end
				if(SliderPeakMax:GetValue() < SliderPeakMin:GetValue()) then
					SliderPeakMin:SetValue( SliderPeakMax:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMin:GetValue() )
				end
			end
			ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
			PowerText:SizeToContents()
			
		SliderLimit = ButtonsSidePanel:Add( "DNumSlider" )
			SliderLimit:SetText( "Limit Rpm" )
			SliderLimit:SetMin( 4000 )
			SliderLimit:SetMax( 12000 )
			SliderLimit:SetDecimals( 0 )
			SliderLimit:SetValue( 7000 )
			RunConsoleCommand( "acfmenu_data7", SliderLimit:GetValue() )
			SliderLimit:SetPos( 5,380 )
			SliderLimit:SetWide( 210 )
			SliderLimit.Label:SetWide(50)
			SliderLimit.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data7", val )
				if(SliderLimit:GetValue() < SliderPeakMax:GetValue()) then
					SliderPeakMax:SetValue( SliderLimit:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
				end
			end
			
		SliderFly = ButtonsSidePanel:Add( "DNumSlider" )
			SliderFly:SetText( "Flywheel Mass" )
			SliderFly:SetMin( 0.01 )
			SliderFly:SetMax( 4 )
			SliderFly:SetDecimals( 2 )
			SliderFly:SetValue( 0.15 )
			RunConsoleCommand( "acfmenu_data8", SliderFly:GetValue() )
			SliderFly:SetPos( 5,410 )
			SliderFly:SetWide( 210 )
			SliderFly.Label:SetWide(60)
			SliderFly.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data8", val )
			end
			
		SliderWeight = ButtonsSidePanel:Add( "DNumSlider" )
			SliderWeight:SetText( "Weight" )
			SliderWeight:SetMin( 50 )
			SliderWeight:SetMax( 400 )
			SliderWeight:SetDecimals( 0 )
			SliderWeight:SetValue( 150 )
			RunConsoleCommand( "acfmenu_data9", SliderWeight:GetValue() )
			SliderWeight:SetPos( 5,440 )
			SliderWeight:SetWide( 210 )
			SliderWeight.Label:SetWide(50)
			SliderWeight.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data9", val )
			end
			
			
	--#############################################################
	
	local BrowserTabs = SoundBrowserPanel:Add("DPropertySheet") // The tabs.
	BrowserTabs:DockMargin(5, 5, 5, 5)
	BrowserTabs:Dock(FILL)
	BrowserTabs:AddSheet("Sounds Browser", TabFileBrowser, "icon16/folder.png", false, false, "Browse your sound folder.")
	BrowserTabs:AddSheet("Favourites Sounds", TabFavourites, "icon16/star.png", false, false, "View your favourites sounds.")
	BrowserTabs:AddSheet("Models Browser", TabModelBrowser, "icon16/folder.png", false, false, "Browse your model folder.")
	BrowserTabs:AddSheet("Favourites Settings", TabFavourites2, "icon16/star.png", false, false, "View your favourites settings.")

	local SoundInfoText = nil
	TabFileBrowser:SetRootName("sound")
	TabFileBrowser:SetRootPath("sound")
	TabFileBrowser:SetWildCard("GAME")
	TabFileBrowser:SetFileTyps({"*.mp3","*.wav"})

	//TabFileBrowser:AddColumns("Type", "Size", "Length") //getting the duration is very slow.
	local Columns = TabFileBrowser:AddColumns("Format", "Size")
	Columns[1]:SetFixedWidth(70)
	Columns[1]:SetWide(70)
	Columns[2]:SetFixedWidth(70)
	Columns[2]:SetWide(70)

	TabFileBrowser.LineData = function(self, id, strfile, ...)
		if (#strfile > max_char_count) then return nil, true end // skip and hide to long filenames.

		local nsize, strformat, nduration = GetFileInfos(strfile)
		if (!nsize) then return end

		local nsizeB, strsize = FormatSize(nsize, nduration)
		local nduration, strduration = FormatLength(nduration, nsize)

		//return {strformat, strsize or "n/a", strduration or "n/a"} //getting the duration is very slow.
		return {strformat, strsize or "n/a"}
	end

	TabFileBrowser.OnLineAdded = function(self, id, line, strfile, ...)

	end


	TabFileBrowser.DoDoubleClick = function(parent, file)
		PlaySound(file, nSoundVolume, nSoundPitch)
		PlaySoundNoEffect()
		SaveFilePath(SoundBrowserPanel, file)

		strSound = file
		-- auto send
		SetupSoundemitter(strSound)
	end

	TabFileBrowser.DoClick = function(parent, file)
		SaveFilePath(SoundBrowserPanel, file)

		strSound = file
		if (!IsValid(SoundInfoText)) then return end
		SoundInfoText:SetText(GetInfoString(file, {"file"}))
		if (!IsValid(SoundText)) then return end
		SoundText:SetText( "Sound : "..strSound )
		SoundText:SetTextColor(Color(0,0,150,255))
		-- auto send
		SetupSoundemitter(strSound)
	end

	TabFileBrowser.DoRightClick = function(parent, file)
		Sendmenu(file, SoundBrowserPanel.Soundemitter, nSoundVolume, nSoundPitch)
		SaveFilePath(SoundBrowserPanel, file)

		strSound = file
		-- auto send
		SetupSoundemitter(strSound)
	end


	file.CreateDir("soundlists")
	TabFavourites:SetRootPath("soundlists")

	TabFavourites.DoClick = function(parent, item, data)
		if(file.Exists("sound/"..item, "GAME")) then
			TabFileBrowser:SetOpenFile(item)
		end

		strSound = item
		if (!IsValid(SoundInfoText)) then return end
		SoundInfoText:SetText(GetInfoString(item, data))
		--if (!IsValid(SoundText)) then return end
		SoundText:SetText( "Sound : "..strSound )
		SoundText:SetTextColor(Color(0,0,150,255))
		-- auto send
		SetupSoundemitter(strSound)
	end

	TabFavourites.DoDoubleClick = function(parent, item, data)
		if(file.Exists("sound/"..item, "GAME")) then
			TabFileBrowser:SetOpenFile(item)
		end

		PlaySound(item, nSoundVolume, nSoundPitch)
		PlaySoundNoEffect()
		strSound = item
		-- auto send
		SetupSoundemitter(strSound)
	end

	TabFavourites.DoRightClick = function(parent, item, data)
		if(file.Exists("sound/"..item, "GAME")) then
			TabFileBrowser:SetOpenFile(item)
		end

		Sendmenu(item, SoundBrowserPanel.Soundemitter, nSoundVolume, nSoundPitch)
		strSound = item
		-- auto send
		SetupSoundemitter(strSound)
	end
	
	--################################################################################
	
	TabModelBrowser:SetRootName("Acf Models")
	TabModelBrowser:SetRootPath("models/engines")
	TabModelBrowser:SetWildCard("GAME")
	TabModelBrowser:SetFileTyps({"*.mdl"})

	//TabModelBrowser:AddColumns("Type", "Size", "Length") //getting the duration is very slow.
	local Columns = TabModelBrowser:AddColumns("Format", "Size")
	Columns[1]:SetFixedWidth(70)
	Columns[1]:SetWide(70)
	Columns[2]:SetFixedWidth(70)
	Columns[2]:SetWide(70)

	TabModelBrowser.LineData = function(self, id, strfile, ...)
		if (#strfile > max_char_count) then return nil, true end // skip and hide to long filenames.

		local nsize, strformat, nduration = GetFileInfos(strfile)
		if (!nsize) then return end

		local nsizeB, strsize = FormatSize(nsize, nduration)
		local nduration, strduration = FormatLength(nduration, nsize)

		//return {strformat, strsize or "n/a", strduration or "n/a"} //getting the duration is very slow.
		return {strformat, strsize or "n/a"}
	end

	TabModelBrowser.OnLineAdded = function(self, id, line, strfile, ...)

	end


	TabModelBrowser.DoDoubleClick = function(parent, file)
		SetupModelemitter(strModel)
		
		strModel = "models/engines/"..file
		-- auto send
		SetupModelemitter(strModel)
	end

	TabModelBrowser.DoClick = function(parent, file)
		SaveFilePath(SoundBrowserPanel, file)

		strModel = "models/engines/"..file
		if (!IsValid(SoundInfoText)) then return end
		SoundInfoText:SetText(GetInfoString(file, {"file"}))
		if (!IsValid(DisplayModel)) then return end
		DisplayModel:SetModel( strModel )
		DisplayModel2:SetModel( strModel )
		DisplayModel3:SetModel( strModel )
		--if (!IsValid(ModelText)) then return end
		ModelText:SetText( "Model : "..strModel )
		ModelText:SetTextColor(Color(0,0,150,255))
		-- auto send
		SetupModelemitter(strModel)
	end

	TabModelBrowser.DoRightClick = function(parent, file)
		Sendmenu2(file, SoundBrowserPanel.Modelemitter)
		SaveFilePath(SoundBrowserPanel, file)

		strModel = "models/engines/"..file
		-- auto send
		SetupModelemitter(strModel)
	end
	
	--#################
	
	file.CreateDir("engineslists/created")
	TabFavourites2:SetRootPath("engineslists/created")

	TabFavourites2.DoClick = function(parent, item, data)
		local newString = ""
		if string.find(item, "0. Name : ") then 
			newString = string.gsub(item,"0. Name : ","")
			RunConsoleCommand( "acfmenu_data10", newString )
			EngineName:SetText(newString)
			EngineName:SetTextColor(Color(0,0,200,255))
		elseif string.find(item, "1. Model : ") then 
			newString = string.gsub(item,"1. Model : ","")
			strModel = newString
			if (!IsValid(SoundInfoText)) then return end
				SoundInfoText:SetText(GetInfoString(strModel, data))
			if (!IsValid(DisplayModel)) then return end
				DisplayModel:SetModel( strModel )
				DisplayModel2:SetModel( strModel )
				DisplayModel3:SetModel( strModel )
			if (!IsValid(ModelText)) then return end
				ModelText:SetText( "Model : "..strModel )
				ModelText:SetTextColor(Color(0,0,150,255))
				SetupModelemitter(strModel)
		elseif string.find(item, "2. Sound : ") then 
			newString = string.gsub(item,"2. Sound : ","")
			strSound = newString
			if (!IsValid(SoundInfoText)) then return end
				SoundInfoText:SetText(GetInfoString(strSound, data))
			if (!IsValid(SoundText)) then return end
				SoundText:SetText( "Sound : "..strSound )
				SoundText:SetTextColor(Color(0,0,150,255))
				SetupSoundemitter(strSound)
		elseif string.find(item, "3. Torque : ") then 
			newString = string.gsub(item,"3. Torque : ","")
			SliderT:SetValue( newString )
			RunConsoleCommand( "acfmenu_data3", newString )
			ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
			PowerText:SizeToContents()
		elseif string.find(item, "4. Idle : ") then 
			newString = string.gsub(item,"4. Idle : ","")
			SliderIdle:SetValue( newString )
			RunConsoleCommand( "acfmenu_data4", newString )
		elseif string.find(item, "5. Peak Min : ") then 
			newString = string.gsub(item,"5. Peak Min : ","")
			SliderPeakMin:SetValue( newString )
			RunConsoleCommand( "acfmenu_data5", newString )
		elseif string.find(item, "6. Peak Max : ") then 
			newString = string.gsub(item,"6. Peak Max : ","")
			SliderPeakMax:SetValue( newString )
			RunConsoleCommand( "acfmenu_data6", newString )
			ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
			PowerText:SizeToContents()
		elseif string.find(item, "7. Limit : ") then 
			newString = string.gsub(item,"7. Limit : ","")
			SliderLimit:SetValue( newString )
			RunConsoleCommand( "acfmenu_data7", newString )
		elseif string.find(item, "8. Flywheel : ") then 
			newString = string.gsub(item,"8. Flywheel : ","")
			SliderFly:SetValue( newString )
			RunConsoleCommand( "acfmenu_data8", newString )
		elseif string.find(item, "9. Weight : ") then 
			newString = string.gsub(item,"9. Weight : ","")
			SliderWeight:SetValue( newString )
			RunConsoleCommand( "acfmenu_data9", newString )
		else return end
		
		
	end

	/*TabFavourites2.DoDoubleClick = function(parent, item, data)
		if(file.Exists("models/engines/"..item, "GAME")) then
			TabModelBrowser:SetOpenFile(item)
		end
		SetupModelemitter(strModel)
		strModel = "models/engines/"..item
	end

	TabFavourites2.DoRightClick = function(parent, item, data)
		if(file.Exists("models/engines/"..item, "GAME")) then
			TabModelBrowser:SetOpenFile(item)
		end

		Sendmenu2(item, SoundBrowserPanel.Modelemitter)
		strSound = "models/engines/"..item
	end*/
	
	--################################################################################
	

	local InfoPanel = SoundBrowserPanel:Add("DPanel") // The bottom part of the frame.
	InfoPanel:DockMargin(5, 0, 5, 0)
	InfoPanel:Dock(BOTTOM)
	InfoPanel:SetTall(100)
	InfoPanel:SetHeight(130)
	InfoPanel:SetDrawBackground(false)
	
	local Buttons2Panel = InfoPanel:Add("DPanel") // The buttons.
	Buttons2Panel:DockMargin(4, 0, 4, 0)
	Buttons2Panel:Dock(TOP)
	Buttons2Panel:SetWide(InfoPanel:GetTall() * 1)
	Buttons2Panel:SetDrawBackground(false)
	
		--##########
		if strSound == "" then 
			strSound = "Choose a Sound" 
			SetupSoundemitter(strSound)
		end
		if strModel == "" then 
			strModel = "Choose a Model" 
			SetupModelemitter(strModel)
		end
		--##########
	
	SoundText = Buttons2Panel:Add("DLabel")
	SoundText:DockMargin(5, 0, 5, 0)
	SoundText:Dock(LEFT)
	SoundText:SetText( "Sound : "..strSound )
	SoundText:SetFont( "DefaultBold" )
	SoundText:SetWide(280)
	SoundText:SetTall(10)
	SoundText:SetTextColor(Color(150,0,0,255))
	
	ModelText = Buttons2Panel:Add("DLabel")
	ModelText:DockMargin(5, 0, 5, 0)
	ModelText:Dock(RIGHT)
	ModelText:SetText( "Model : "..strModel )
	ModelText:SetFont( "DefaultBold" )
	ModelText:SetWide(280)
	ModelText:SetTall(10)
	ModelText:SetTextColor(Color(150,0,0,255))
	
	
	DisplayModel = InfoPanel:Add("DModelPanel")
	DisplayModel:SetModel( strModel )
	DisplayModel:SetCamPos( Vector( 250 , 0 , 0 ) )
	DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
	DisplayModel:SetFOV( 15 )
	DisplayModel:SetSize( 80 , 150 )
	DisplayModel:Dock(LEFT)
	DisplayModel.LayoutEntity = function( panel , entity ) end
	
	DisplayModel2 = InfoPanel:Add("DModelPanel")
	DisplayModel2:SetModel( strModel )
	DisplayModel2:SetCamPos( Vector( 250 , 1000 , 0 ) )
	DisplayModel2:SetLookAt( Vector( 0, 0, 0 ) )
	DisplayModel2:SetFOV( 7 )
	DisplayModel2:SetSize( 80 , 150 )
	DisplayModel2:Dock(LEFT)
	DisplayModel2.LayoutEntity = function( panel , entity ) end
	

	SoundInfoText = InfoPanel:Add("DTextEntry") // The info text.
	SoundInfoText:Dock(FILL)
	SoundInfoText:DockMargin(4, 4, 4, 0)
	SoundInfoText:SetMultiline(true)
	SoundInfoText:SetEnterAllowed(true)
	SoundInfoText:SetVerticalScrollbarEnabled(true)
	SoundInfoText:SetCursorColor(Color(0,0,255,255))
	SoundInfoText:SetHighlightColor(Color(0,255,0,200))
	SoundInfoText:SetTextColor(Color(0,0,200,255))

	local ButtonsPanel = InfoPanel:Add("DPanel") // The buttons.
	ButtonsPanel:DockMargin(4, 4, 4, 4)
	ButtonsPanel:Dock(RIGHT)
	ButtonsPanel:SetWide(InfoPanel:GetTall() * 1)
	ButtonsPanel:SetDrawBackground(false)

	local PlayStopPanel = ButtonsPanel:Add("DPanel") // Play and stop.
	PlayStopPanel:DockMargin(2, 2, 2, 2)
	PlayStopPanel:Dock(TOP)
	PlayStopPanel:SetTall(InfoPanel:GetTall() / 3 - 2.5)
	PlayStopPanel:SetDrawBackground(false)

	local PlayButton = PlayStopPanel:Add("DButton") // The play button.
	PlayButton:SetText("Play")
	PlayButton:SetTextColor(Color(150,0,0,255))
	PlayButton:Dock(LEFT)
	PlayButton:SetWide(PlayStopPanel:GetWide() / 2 - 2.5)
	PlayButton.DoClick = function()
		PlaySound(strSound, nSoundVolume, nSoundPitch)
		PlaySoundNoEffect()
	end

	local StopButton = PlayStopPanel:Add("DButton") // The stop button.
	StopButton:SetText("Stop")
	StopButton:SetTextColor(Color(150,0,0,255))
	StopButton:Dock(RIGHT)
	StopButton:SetWide(PlayButton:GetWide())
	StopButton.DoClick = function()
		PlaySound() // Mute a playing sound by not giving a sound.
		PlaySoundNoEffect()
	end

	local TunePanel = InfoPanel:Add("DPanel") // The effect Sliders.
	TunePanel:DockMargin(0, 2, 0, 0)
	TunePanel:Dock(BOTTOM)
	TunePanel:SetWide(200)
	TunePanel:SetDrawBackground(false)

	local TuneVolumeSlider = TunePanel:Add("DNumSlider") // The volume slider.
	TuneVolumeSlider:DockMargin(2, 0, 0, 0)
	TuneVolumeSlider:Dock(LEFT)
	TuneVolumeSlider:SetText("Volume")
	TuneVolumeSlider:SetDecimals(0)
	TuneVolumeSlider:SetMinMax(0, 100)
	TuneVolumeSlider:SetValue(100)
	TuneVolumeSlider:SetWide(TunePanel:GetWide() / 2.5 - 1)
	TuneVolumeSlider.Label:SetWide(40)
	TuneVolumeSlider.OnValueChanged = function(self, val)
		nSoundVolume = val / 100
		SetSoundVolume(nSoundVolume)
	end

	local TunePitchSlider = TunePanel:Add("DNumSlider") // The pitch slider.
	TunePitchSlider:DockMargin(0, 0, 2, 0)
	TunePitchSlider:Dock(LEFT)
	TunePitchSlider:SetText("Pitch")
	TunePitchSlider:SetDecimals(0)
	TunePitchSlider:SetMinMax(0, 255)
	TunePitchSlider:SetValue(100)
	TunePitchSlider:SetWide(TunePanel:GetWide() / 2.5 - 1)
	TunePitchSlider.Label:SetWide(40)
	TunePitchSlider.OnValueChanged = function(self, val)
		nSoundPitch = val
		SetSoundPitch(nSoundPitch)
	end

	local SoundemitterButton = ButtonsPanel:Add("DButton") // The soundemitter button. Hidden in e2 mode.
	SoundemitterButton:SetText("Save to Favorite")
	SoundemitterButton:SetTextColor(Color(150,0,0,255))
	SoundemitterButton:DockMargin(0, 2, 0, 0)
	SoundemitterButton:SetTall(PlayStopPanel:GetTall() - 1.8)
	SoundemitterButton:Dock(BOTTOM)
	SoundemitterButton.DoClick = function()
		TabFavourites2:AddItem("0. Name : "..GetConVarString("acfmenu_data10"), "string")
		TabFavourites2:AddItem("1. Model : "..GetConVarString("wire_soundemitter_model"), "file")
		TabFavourites2:AddItem("2. Sound : "..GetConVarString("wire_soundemitter_sound"), "file")
		TabFavourites2:AddItem("3. Torque : "..GetConVarString("acfmenu_data3"), "number")
		TabFavourites2:AddItem("4. Idle : "..GetConVarString("acfmenu_data4"), "number")
		TabFavourites2:AddItem("5. Peak Min : "..GetConVarString("acfmenu_data5"), "number")
		TabFavourites2:AddItem("6. Peak Max : "..GetConVarString("acfmenu_data6"), "number")
		TabFavourites2:AddItem("7. Limit : "..GetConVarString("acfmenu_data7"), "number")
		TabFavourites2:AddItem("8. Flywheel : "..GetConVarString("acfmenu_data8"), "number")
		TabFavourites2:AddItem("9. Weight : "..GetConVarString("acfmenu_data9"), "number")
	end

	SoundBrowserPanel.PerformLayout = function(self, ...)
		SoundemitterButton:SetVisible( true )

		TunePitchSlider:SetWide(TunePanel:GetWide() / 2 - 4)
		TuneVolumeSlider:SetWide(TunePanel:GetWide() / 2 - 4)

		ButtonsPanel:SetWide(InfoPanel:GetTall() * 1)
		PlayStopPanel:SetTall(InfoPanel:GetTall() / 3 - 2.5)
		PlayButton:SetWide(PlayStopPanel:GetWide() / 2 - 2.5)
		StopButton:SetWide(PlayButton:GetWide())

		if (self.Soundemitter) then
			SoundemitterButton:SetTall(PlayStopPanel:GetTall() - 1.8)
		end

		DFrame.PerformLayout(self, ...)
	end

	SoundBrowserPanel.OnClose = function() // Set effects back and mute when closing.
		nSoundVolume = 1
		nSoundPitch = 100
		TuneVolumeSlider:SetValue(nSoundVolume * 100)
		TunePitchSlider:SetValue(nSoundPitch)
		PlaySound()
		PlaySoundNoEffect()
	end

	SoundBrowserPanel:InvalidateLayout(true)


--###################################################################################################

	
		SetupModelemitter(strModel)
	
end

--###################################################################################################

// Open the Sound Browser.
local function OpenSoundBrowser(pl, cmd, args)
	local path = args[1] // nil or "" will put the browser in e2 mode else the soundemitter mode is applied.
	
	if (!IsValid(SoundBrowserPanel)) then
		CreateSoundBrowser(path)
	end

	SoundBrowserPanel:SetVisible(true)
	SoundBrowserPanel:MakePopup()
	SoundBrowserPanel:InvalidateLayout(true)

	if (!IsValid(TabFileBrowser)) then return end

	//Replaces the timer, doesn't get paused in singleplayer.
	WireLib.Timedcall(function(SoundBrowserPanel, TabFileBrowser, path)
		if (!IsValid(SoundBrowserPanel)) then return end
		if (!IsValid(TabFileBrowser)) then return end

		local soundemitter = false
		if (isstring(path) and path ~= "") then
			soundemitter = true
		end

		SoundBrowserPanel.Soundemitter = soundemitter

		SoundBrowserPanel:InvalidateLayout(true)

		if (!soundemitter) then
			path = SoundBrowserPanel:GetCookie("wire_soundfile", "") // load last session
		end
		TabFileBrowser:SetOpenFile(path)
	end, SoundBrowserPanel, ModelBrowserPanel, TabFileBrowser, path)
end

concommand.Add("acf_sound_browser_open", OpenSoundBrowser)