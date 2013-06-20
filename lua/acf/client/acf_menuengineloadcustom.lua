// A sound browser for the sound emitter and the expression 2 editor.
// Made by Grocel.

local max_char_count = 200 //File length limit

local SoundBrowserPanel = nil
local TabFavourites2 = nil

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
	if (isstring(path) and path ~= "") then
		soundemitter = true
	end

	SoundBrowserPanel = vgui.Create("DFrame") // The main frame.
	SoundBrowserPanel:SetPos(130,60)
	SoundBrowserPanel:SetSize(480, 460)

	SoundBrowserPanel:SetMinWidth(450)
	SoundBrowserPanel:SetMinHeight(450)

	SoundBrowserPanel:SetSizable(true)
	SoundBrowserPanel:SetDeleteOnClose( false )
	SoundBrowserPanel:SetTitle("Engine Menu V3.3 - LOAD MENU")
	SoundBrowserPanel:SetVisible(false)
	SoundBrowserPanel:SetCookieName( "wire_sound_browser" )
	SoundBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.

	TabFavourites2 = vgui.Create("acf_list2editor") // The favourites manager.
	
	local BrowserTabs = SoundBrowserPanel:Add("DPropertySheet") // The tabs.
	BrowserTabs:DockMargin(5, 5, 5, 5)
	BrowserTabs:Dock(FILL)
	BrowserTabs:AddSheet("Settings", TabFavourites2, "icon16/disk.png", false, false, "Current Settings.")
	
	file.CreateDir("engineslists/created")
	TabFavourites2:SetRootPath("engineslists/created")
	
	TabFavourites2.DoClick = function(parent, item, data)
		local newString = ""
		if string.find(item, "0. Name : ") then 
			newString = string.gsub(item,"0. Name : ","")
			RunConsoleCommand( "acfmenu_data10", newString )
		elseif string.find(item, "1. Model : ") then 
			newString = string.gsub(item,"1. Model : ","")
			strModel = newString
			RunConsoleCommand("wire_soundemitter_model", strModel)
		elseif string.find(item, "2. Sound : ") then 
			newString = string.gsub(item,"2. Sound : ","")
			strSound = newString
			RunConsoleCommand("wire_soundemitter_sound", strSound)
		elseif string.find(item, "3. Torque : ") then 
			newString = string.gsub(item,"3. Torque : ","")
			RunConsoleCommand( "acfmenu_data3", newString )
		elseif string.find(item, "4. Idle : ") then 
			newString = string.gsub(item,"4. Idle : ","")
			RunConsoleCommand( "acfmenu_data4", newString )
		elseif string.find(item, "5. Peak Min : ") then 
			newString = string.gsub(item,"5. Peak Min : ","")
			RunConsoleCommand( "acfmenu_data5", newString )
		elseif string.find(item, "6. Peak Max : ") then 
			newString = string.gsub(item,"6. Peak Max : ","")
			RunConsoleCommand( "acfmenu_data6", newString )
		elseif string.find(item, "7. Limit : ") then 
			newString = string.gsub(item,"7. Limit : ","")
			RunConsoleCommand( "acfmenu_data7", newString )
		elseif string.find(item, "8. Flywheel : ") then 
			newString = string.gsub(item,"8. Flywheel : ","")
			RunConsoleCommand( "acfmenu_data8", newString )
		elseif string.find(item, "9. Weight : ") then 
			newString = string.gsub(item,"9. Weight : ","")
			RunConsoleCommand( "acfmenu_data9", newString )
		else return end
	end
		--########

	--Button Panel
	local ButtonsSidePanel = SoundBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(5, 5, 5, 5)
	ButtonsSidePanel:Dock(BOTTOM)
	ButtonsSidePanel:SetTall(80)
	ButtonsSidePanel:SetWide(SoundBrowserPanel:GetWide())
	ButtonsSidePanel:SetDrawBackground(true)
		--button
		BackButton	= ButtonsSidePanel:Add("DButton") // The play button.
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(0,0,155,255))
		BackButton:SetPos(40,20)
		BackButton:SetWide(60)
		BackButton:SetTall(40)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_start_browser_open")
			SoundBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton") // The play button.
		NextButton:SetText("Next")
		NextButton:SetTextColor(Color(0,0,255,255))
		NextButton:SetPos(360,10)
		NextButton:SetWide(80)
		NextButton:SetTall(60)
		NextButton.DoClick = function()
			RunConsoleCommand("acf_engineloaded_browser_open")
			SoundBrowserPanel:Close()
		end
		
		--#### text ##
		SaveText1 = ButtonsSidePanel:Add("DLabel")
		SaveText1:SetText("Load Menu Beta, click on each \n lines to load value's")
		SaveText1:SetTextColor(Color(0,255,0,255))
		SaveText1:SetPos(150,20)
		SaveText1:SetFont( "DefaultBold" )
		SaveText1:SizeToContents()
		--####

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

	if (!IsValid(TabFavourites2)) then return end

	//Replaces the timer, doesn't get paused in singleplayer.
	WireLib.Timedcall(function(SoundBrowserPanel, TabFavourites2, path)
		if (!IsValid(SoundBrowserPanel)) then return end
		if (!IsValid(TabFavourites2)) then return end

		local soundemitter = false
		if (isstring(path) and path ~= "") then
			soundemitter = true
		end

		SoundBrowserPanel.Soundemitter = soundemitter

		SoundBrowserPanel:InvalidateLayout(true)

		if (!soundemitter) then
			path = SoundBrowserPanel:GetCookie("wire_soundfile", "") // load last session
		end
		TabFavourites2:SetOpenFile(path)
	end, SoundBrowserPanel, ModelBrowserPanel, TabFavourites2, path)
end

concommand.Add("acf_engineloadcustom_browser_open", OpenSoundBrowser)