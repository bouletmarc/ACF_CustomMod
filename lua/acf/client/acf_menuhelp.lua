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
	StartBrowserPanel:SetTitle("ACF Help Menu")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
		--#### text ##
		SVNText1 = ButtonsSidePanel:Add("DLabel")
		SVNText1:SetText("First make sure you have \n   ACF Custom Installed. \n\n          Here the SVN :")
		SVNText1:SetTextColor(Color(0,255,0,255))
		SVNText1:SetPos(45,20)
		SVNText1:SetFont( "DefaultBold" )
		SVNText1:SizeToContents()
		--####
		SVNText2 = ButtonsSidePanel:Add( "DTextEntry" )
		SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
		SVNText2:SetTextColor(Color(0,0,200,255))
		SVNText2:SetPos( 10,80 )
		SVNText2:SetWide( 220 )
		SVNText2.OnTextChanged = function( )
			if SVNText2:GetValue() != "https://github.com/bouletmarc/ACF_CustomMod/trunk" then
				SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
			end
		end
		
		SVNCopy = ButtonsSidePanel:Add("DButton") // The play button.
		SVNCopy:SetText("Copy SVN link")
		SVNCopy:SetTextColor(Color(0,200,0,255))
		SVNCopy:SetPos( 65, 110 )
		SVNCopy:SetWide(ButtonsSidePanel:GetWide() / 2.2 - 2.2)
		SVNCopy:SetTall( 30 )
		SVNCopy.DoClick = function()
			SetClipboardText("https://github.com/bouletmarc/ACF_CustomMod/trunk")
		end
		
		HelpHormal = ButtonsSidePanel:Add("DButton") // The play button.
		HelpHormal:SetText("Help me with Normal ACF -SOON-")
		HelpHormal:SetTextColor(Color(0,0,255,255))
		HelpHormal:SetPos( 20, 170 )
		HelpHormal:SetDisabled( true )--disabled
		HelpHormal:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		HelpHormal:SetTall( 60 )
		HelpHormal.DoClick = function()
			RunConsoleCommand("acf_help1_browser_open")
			StartBrowserPanel:Close()
		end
		
		HelpCustom = ButtonsSidePanel:Add("DButton") // The play button.
		HelpCustom:SetText("Help me with Custom ACF -SOON-")
		HelpCustom:SetTextColor(Color(0,0,255,255))
		HelpCustom:SetPos( 20, 240 )
		HelpCustom:SetDisabled( true )--disabled
		HelpCustom:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		HelpCustom:SetTall( 60 )
		HelpCustom.DoClick = function()
			RunConsoleCommand("acf_help2_browser_open")
			StartBrowserPanel:Close()
		end
		
		BMText1 = ButtonsSidePanel:Add("DLabel")
		BMText1:SetText("Made by Bouletmarc\n      (B0ul3Tm@rc)")
		BMText1:SetTextColor(Color(0,255,0,255))
		BMText1:SetPos(60,320)
		BMText1:SetFont( "DefaultBold" )
		BMText1:SizeToContents()
		
		--############

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

concommand.Add("acf_help_browser_open", OpenSartBrowser)