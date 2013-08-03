// Made by Bouletmarc.

local StartBrowserPanel = nil

// Open the Sound Browser.
local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetPos(80,80)
	StartBrowserPanel:SetSize(450, 450)

	StartBrowserPanel:SetMinWidth(440)
	StartBrowserPanel:SetMinHeight(440)
	
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("ACF Help Menu")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(430, 430)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
		--#### text ##
		MainText = ButtonsSidePanel:Add("DLabel")
		MainText:SetText("Original ACF Help Menu")
		MainText:SetTextColor(Color(0,255,0,255))
		MainText:SetPos(150,15)
		MainText:SetFont( "DefaultBold" )
		MainText:SizeToContents()
		
		
		WireModText1 = ButtonsSidePanel:Add("DLabel")
		WireModText1:SetText("WireMod Part :")
		WireModText1:SetTextColor(Color(255,0,0,255))
		WireModText1:SetPos(40,40)
		WireModText1:SetFont( "DefaultBold" )
		WireModText1:SizeToContents()
		
		local WireLine1 = "- Active should be wired to something with (0-1) value. \n- Throttle should be wired to something with (0-100) value\n- Clutch should be wired to (0-1)\n- Brake should be wired to (0-20) too high value make spazz\n\n- Gear should be wired to you Gear Number Value or\n-- if you use GearUp and GearDown, theses one should\n-- be wired a button (0-1) to Increase or Decrease Gear.\n"
		
		WireModText2 = ButtonsSidePanel:Add("DLabel")
		WireModText2:SetText(WireLine1)
		WireModText2:SetTextColor(Color(0,0,255,255))
		WireModText2:SetPos(20,60)
		WireModText2:SetFont( "DefaultBold" )
		WireModText2:SizeToContents()
		
		LinkingText1 = ButtonsSidePanel:Add("DLabel")
		LinkingText1:SetText("Linking Part :")
		LinkingText1:SetTextColor(Color(255,0,0,255))
		LinkingText1:SetPos(40,200)
		LinkingText1:SetFont( "DefaultBold" )
		LinkingText1:SizeToContents()
		
		local LinkingLine1 = 	"**To LINK an entity you must RIGHT clic on both**\n**To UNLINK an entity you must hold -E- and right clic\n\n- Engine must be linked to Gearbox and FuelTank\n- Gearbox's must be linked to Wheels (regular prop's)\n- Gun must be linked to the Ammo Box\n"
		
		LinkingText2 = ButtonsSidePanel:Add("DLabel")
		LinkingText2:SetText(LinkingLine1)
		LinkingText2:SetTextColor(Color(0,0,255,255))
		LinkingText2:SetPos(20,220)
		LinkingText2:SetFont( "DefaultBold" )
		LinkingText2:SizeToContents()
		
		Close = ButtonsSidePanel:Add("DButton") // The play button.
		Close:SetText("Close")
		Close:SetTextColor(Color(255,0,0,255))
		Close:SetPos(350,340)
		Close:SetWide(80)
		Close:SetTall(40)
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
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

concommand.Add("acf_help1_browser_open", OpenSartBrowser)