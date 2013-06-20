// Made by Bouletmarc.

local StartBrowserPanel = nil

// Open the Sound Browser.
local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetPos(350,125)
	StartBrowserPanel:SetSize(250, 400)

	StartBrowserPanel:SetMinWidth(250)
	StartBrowserPanel:SetMinHeight(400)
	
	StartBrowserPanel:SetDeleteOnClose( false )
	StartBrowserPanel:SetTitle("Start Menu V2.0")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
	
		BMImage = ButtonsSidePanel:Add("DImage")
		BMImage:SetImage( "VGUI/menus/menu.vmt" )
		BMImage:SetPos( 50, 10 )
		--BMImage:SetWide( 128 )
		--BMImage:SetTall( 128 )
		BMImage:SizeToContents() // make the control the same size as the image.
		
		
		CreateEng = ButtonsSidePanel:Add("DButton") // The play button.
		CreateEng:SetText("Create New Engine")
		CreateEng:SetTextColor(Color(0,0,255,255))
		CreateEng:SetPos( 20, 150 )
		CreateEng:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		CreateEng:SetTall( 40 )
		CreateEng.DoClick = function()
			RunConsoleCommand("acf_engine_browser_open")
			StartBrowserPanel:Close()
		end
		
		EditEng = ButtonsSidePanel:Add("DButton") // The play button.
		EditEng:SetText("Customizing existing engine -SOON-")
		EditEng:SetTextColor(Color(0,0,255,255))
		EditEng:SetPos( 20, 200 )
		EditEng:SetDisabled( true )--disabled
		EditEng:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		EditEng:SetTall( 40 )
		EditEng.DoClick = function()
			RunConsoleCommand("acf_engineload_browser_open")
			StartBrowserPanel:Close()
		end
		
		LoadEng = ButtonsSidePanel:Add("DButton") // The play button.
		LoadEng:SetText("Load/Edit Engine BETA")
		LoadEng:SetTextColor(Color(0,0,255,255))
		LoadEng:SetPos( 20, 250 )
		--LoadEng:SetDisabled( true )--disabled
		LoadEng:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		LoadEng:SetTall( 40 )
		LoadEng.DoClick = function()
			RunConsoleCommand("acf_engineloadcustom_browser_open")
			StartBrowserPanel:Close()
		end
		
		/*CreateGear = ButtonsSidePanel:Add("DButton") // The play button.
		CreateGear:SetText("Create New Gearbox")
		CreateGear:SetTextColor(Color(0,0,255,255))
		CreateGear:SetPos( 20, 180 )
		CreateGear:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		CreateGear:SetTall( 40 )
		CreateGear.DoClick = function()
			RunConsoleCommand("acf_sound_browser_open")
			StartBrowserPanel:Close()
		end
		
		LoadGear = ButtonsSidePanel:Add("DButton") // The play button.
		LoadGear:SetText("Load/Edit Gearbox")
		LoadGear:SetTextColor(Color(0,0,255,255))
		LoadGear:SetPos( 20, 230 )
		LoadGear:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		LoadGear:SetTall( 40 )
		LoadGear.DoClick = function()
			RunConsoleCommand("acf_sound_browser_open")
			StartBrowserPanel:Close()
		end*/
		
		OpenAdv = ButtonsSidePanel:Add("DButton") // The play button.
		OpenAdv:SetText("Open Advanced Menu")
		OpenAdv:SetTextColor(Color(250,0,0,255))
		OpenAdv:SetPos( 20,300 )
		OpenAdv:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		OpenAdv:SetTall( 50 )
		OpenAdv.DoClick = function()
			RunConsoleCommand("acf_sound_browser_open")
			StartBrowserPanel:Close()
		end

	StartBrowserPanel.OnClose = function() // Set effects back and mute when closing.
		--###
	end

	StartBrowserPanel:InvalidateLayout(true)
	
end

--###################################################################################################

// Open the Sound Browser.
local function OpenSartBrowser(pl, cmd, args)
	if (!IsValid(StartBrowserPanel)) then
		CreateSoundBrowser()
	end

	StartBrowserPanel:SetVisible(true)
	StartBrowserPanel:MakePopup()
	StartBrowserPanel:InvalidateLayout(true)

	//Replaces the timer, doesn't get paused in singleplayer.
	WireLib.Timedcall(function(StartBrowserPanel)
		if (!IsValid(StartBrowserPanel)) then return end

		StartBrowserPanel:InvalidateLayout(true)

	end, StartBrowserPanel)
end

concommand.Add("acf_start_browser_open", OpenSartBrowser)