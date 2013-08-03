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
	StartBrowserPanel:SetTitle("Engine Menu V3.3 - FUEL MENU")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################	
		MainTitle = ButtonsSidePanel:Add( "DLabel" )
		MainTitle:SetText( "Fuel Setup :" )
		MainTitle:SetFont( "DefaultBold" )
		MainTitle:SetTextColor(Color(0,0,200,255))
		MainTitle:SetPos( 20,50 )
		MainTitle:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		
		--########################
		--## First Load Setting ##
		--########################
		RunConsoleCommand( "acfmenu_data11", "Petrol" )
		RunConsoleCommand( "acfmenu_data12", 1 )
		RunConsoleCommand( "acfmenu_data13", "GenericPetrol" )
		
		
		--##############
		--## Checkbox ##
		--##############
		CheckBoxPetrol = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxPetrol:SetPos( 20,120 )
			CheckBoxPetrol:SetText( "Petrol" )
			CheckBoxPetrol:SetTextColor(Color(0,0,200,255))
			CheckBoxPetrol:SetChecked( true )
			CheckBoxPetrol.OnChange = function( )
				RunConsoleCommand( "acfmenu_data11", "Petrol" )
				RunConsoleCommand( "acfmenu_data13", "GenericPetrol" )
				if CheckBoxDisel:GetChecked() then CheckBoxDisel:SetChecked( false ) end
			end
			
		CheckBoxDisel = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxDisel:SetPos( 20,160 )
			CheckBoxDisel:SetText( "Disel" )
			CheckBoxDisel:SetTextColor(Color(0,0,200,255))
			CheckBoxDisel:SetChecked( false )
			CheckBoxDisel.OnChange = function( )
				RunConsoleCommand( "acfmenu_data11", "Disel" )
				RunConsoleCommand( "acfmenu_data13", "GenericDisel" )
				if CheckBoxPetrol:GetChecked() then CheckBoxPetrol:SetChecked( false ) end
			end
			
		BackButton	= ButtonsSidePanel:Add("DButton") // The play button.
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(0,0,155,255))
		BackButton:SetPos( 20, 280 )
		BackButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.8)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_start_browser_open")
			StartBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton") // The play button.
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(0,0,255,255))
		NextButton:SetPos( 20, 320 )
		NextButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.5)
		NextButton:SetTall( 40 )
		NextButton.DoClick = function()
			RunConsoleCommand("acf_engine_browser_open")
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

concommand.Add("acf_enginefuel_browser_open", OpenSartBrowser)