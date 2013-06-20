// A sound browser for the sound emitter and the expression 2 editor.
// Made by Grocel.

local max_char_count = 200 //File length limit

local SoundBrowserPanel = nil
local TabFileBrowser = nil
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

local function SetupClipboard(strSound)
	// Copy the soundpath to Clipboard.
	SetClipboardText(strSound)
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
	SoundBrowserPanel:SetPos(250,80)
	SoundBrowserPanel:SetSize(450, 500)

	SoundBrowserPanel:SetMinWidth(400)
	SoundBrowserPanel:SetMinHeight(450)

	SoundBrowserPanel:SetSizable(true)
	SoundBrowserPanel:SetDeleteOnClose( false )
	SoundBrowserPanel:SetTitle("Engine Menu V3.3 - SOUND MENU")
	SoundBrowserPanel:SetVisible(false)
	SoundBrowserPanel:SetCookieName( "wire_sound_browser" )
	SoundBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.

	TabFileBrowser = vgui.Create("acf_filebrowser") // The file tree browser.
	// Todo: Add a tab with a sound property browser. sound.GetTable() needed.
	
	--#############################################################
	
	local BrowserTabs = SoundBrowserPanel:Add("DPropertySheet") // The tabs.
	BrowserTabs:DockMargin(5, 5, 5, 5)
	BrowserTabs:Dock(FILL)
	BrowserTabs:AddSheet("Sounds Browser", TabFileBrowser, "icon16/folder.png", false, false, "Browse your sound folder.")

	local SoundInfoText = nil
	TabFileBrowser:SetRootName("sound")
	TabFileBrowser:SetRootPath("sound")
	TabFileBrowser:SetWildCard("GAME")
	TabFileBrowser:SetFileTyps({"*.mp3","*.wav"})

	//TabFileBrowser:AddColumns("Type", "Size", "Length") //getting the duration is very slow.
	local Columns = TabFileBrowser:AddColumns("Format", "Size")
	Columns[1]:SetFixedWidth(40)
	Columns[1]:SetWide(40)
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
	Buttons2Panel:SetTall(30)
	Buttons2Panel:SetDrawBackground(false)
	
	SoundText = Buttons2Panel:Add("DLabel")
	SoundText:DockMargin(5, 0, 5, 0)
	SoundText:Dock(LEFT)
	SoundText:SetText( "Sound : ".."Choose a Sound" )
	SoundText:SetFont( "DefaultBold" )
	SoundText:SetWide(280)
	SoundText:SetTall(10)
	SoundText:SetTextColor(Color(150,0,0,255))
	

	SoundInfoText = InfoPanel:Add("DTextEntry") // The info text.
	SoundInfoText:Dock(FILL)
	SoundInfoText:DockMargin(4, 4, 4, 0)
	SoundInfoText:SetMultiline(true)
	SoundInfoText:SetEnterAllowed(true)
	SoundInfoText:SetVerticalScrollbarEnabled(true)
	SoundInfoText:SetCursorColor(Color(0,0,255,255))
	SoundInfoText:SetHighlightColor(Color(0,255,0,200))
	SoundInfoText:SetTextColor(Color(0,0,200,255))

	local ButtonsPanel = Buttons2Panel:Add("DPanel") // The buttons.
	ButtonsPanel:DockMargin(4, 0, 4, 0)
	ButtonsPanel:Dock(RIGHT)
	ButtonsPanel:SetWide(InfoPanel:GetTall() * 1)
	ButtonsPanel:SetDrawBackground(false)
	
	local ButtonsPanel2 = InfoPanel:Add("DPanel") // The buttons.
	ButtonsPanel2:DockMargin(4, 10, 4, 10)
	ButtonsPanel2:Dock(RIGHT)
	ButtonsPanel2:SetWide(InfoPanel:GetTall() * 1)
	ButtonsPanel2:SetDrawBackground(false)

	local PlayStopPanel = ButtonsPanel:Add("DPanel") // Play and stop.
	PlayStopPanel:DockMargin(2, 0, 2, 0)
	PlayStopPanel:Dock(TOP)
	PlayStopPanel:SetTall(20)
	PlayStopPanel:SetDrawBackground(false)

	local PlayButton = PlayStopPanel:Add("DButton") // The play button.
	PlayButton:SetText("Play")
	PlayButton:SetTextColor(Color(150,0,0,255))
	PlayButton:Dock(LEFT)
	PlayButton:SetWide(PlayStopPanel:GetWide() / 2 - 2.5)
	PlayButton:SetTall(20)
	PlayButton.DoClick = function()
		PlaySound(strSound, nSoundVolume, nSoundPitch)
		PlaySoundNoEffect()
	end

	local StopButton = PlayStopPanel:Add("DButton") // The stop button.
	StopButton:SetText("Stop")
	StopButton:SetTextColor(Color(150,0,0,255))
	StopButton:Dock(RIGHT)
	StopButton:SetWide(PlayButton:GetWide())
	StopButton:SetTall(20)
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
	
	BackButton	= ButtonsPanel2:Add("DButton") // The play button.
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(0,0,100,255))
		BackButton:Dock( BOTTOM )
		BackButton:SetTall(35)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_engine2_browser_open")
			SoundBrowserPanel:Close()
		end

	local SoundemitterButton = ButtonsPanel2:Add("DButton") // The soundemitter button. Hidden in e2 mode.
	SoundemitterButton:SetText("Next Step")
	SoundemitterButton:SetTextColor(Color(0,0,255,255))
	SoundemitterButton:DockMargin(0, 2, 0, 0)
	SoundemitterButton:SetTall(35)
	SoundemitterButton:Dock(BOTTOM)
	SoundemitterButton.DoClick = function(btn)
		RunConsoleCommand("acf_engine4_browser_open")
		SoundBrowserPanel:Close()
	end

	SoundBrowserPanel.PerformLayout = function(self, ...)
		SoundemitterButton:SetVisible( true )
		/*ClipboardButton:SetVisible(!self.Soundemitter)*/

		TunePitchSlider:SetWide(TunePanel:GetWide() / 2 - 4)
		TuneVolumeSlider:SetWide(TunePanel:GetWide() / 2 - 4)

		ButtonsPanel:SetWide(InfoPanel:GetTall() * 1)
		PlayStopPanel:SetTall(InfoPanel:GetTall() / 3 - 2.5)
		PlayButton:SetWide(PlayStopPanel:GetWide() / 2 - 2.5)
		StopButton:SetWide(PlayButton:GetWide())

		if (self.Soundemitter) then
			SoundemitterButton:SetTall(PlayStopPanel:GetTall() - 1.8)
		else
			/*ClipboardButton:SetTall(PlayStopPanel:GetTall() - 2)*/
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
	end, SoundBrowserPanel, TabFileBrowser, path)
end

concommand.Add("acf_engine3_browser_open", OpenSoundBrowser)