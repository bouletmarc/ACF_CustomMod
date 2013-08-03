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

	SoundBrowserPanel:SetSizable(false)
	SoundBrowserPanel:SetDeleteOnClose( false )
	SoundBrowserPanel:SetTitle("Engine Menu V3.3 - SAVE MENU")
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
	
		--quick load
		--TabFavourites2:Clear()
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
		TabFavourites2:AddItem("10. Fuel : "..GetConVarString("acfmenu_data11"), "string")
		TabFavourites2:AddItem("11. Use Fuel : "..GetConVarString("acfmenu_data12"), "number")
		TabFavourites2:AddItem("12. EngineType : "..GetConVarString("acfmenu_data13"), "string")

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
			RunConsoleCommand("acf_engine3_browser_open")
			SoundBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton") // The play button.
		NextButton:SetText("Done")
		NextButton:SetTextColor(Color(0,0,255,255))
		NextButton:SetPos(360,10)
		NextButton:SetWide(80)
		NextButton:SetTall(60)
		NextButton.DoClick = function()
			SoundBrowserPanel:Close()
		end
		
		--#### text ##
		SaveText1 = ButtonsSidePanel:Add("DLabel")
		SaveText1:SetText("Save Menu")
		SaveText1:SetTextColor(Color(0,255,0,255))
		SaveText1:SetPos(180,30)
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

concommand.Add("acf_engine4_browser_open", OpenSoundBrowser)