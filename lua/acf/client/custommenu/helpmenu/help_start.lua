// Made by Bouletmarc.

local StartBrowserPanel = nil

local function CreateSoundBrowser()
	--###########################################
	--loading
	local Redcolor = 0
	local Greencolor = 0
	local Bluecolor = 0
	if file.Exists("acf/menucolor.txt", "DATA") then
		local MenuColor = file.Read("acf/menucolor.txt")
		local MenuColorTable = {}
		for w in string.gmatch(MenuColor, "([^,]+)") do
			table.insert(MenuColorTable, w)
		end
		Redcolor = tonumber(MenuColorTable[1])
		Greencolor = tonumber(MenuColorTable[2])
		Bluecolor = tonumber(MenuColorTable[3])
	else
		Redcolor = 0
		Greencolor = 0
		Bluecolor = 200
	end
	--###########################################

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetSize(250, 400)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(250)
	StartBrowserPanel:SetMinHeight(400)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( false )
	StartBrowserPanel:SetTitle("ACF Help Menu")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
		SVNText1 = ButtonsSidePanel:Add("DLabel")
		SVNText1:SetText("First make sure you have \n   ACF Custom Installed. \n\n          Here the SVN :")
		SVNText1:SetTextColor(Color(0,255,0,255))
		SVNText1:SetPos(45,20)
		SVNText1:SetFont( "DefaultBold" )
		SVNText1:SizeToContents()
		
		SVNText2 = ButtonsSidePanel:Add( "DTextEntry" )
		SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
		SVNText2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNText2:SetPos( 10,80 )
		SVNText2:SetWide( 220 )
		SVNText2.OnTextChanged = function( )
			if SVNText2:GetValue() != "https://github.com/bouletmarc/ACF_CustomMod/trunk" then
				SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
			end
		end
		
		SVNCopy = ButtonsSidePanel:Add("DButton")
		SVNCopy:SetText("Copy SVN link")
		SVNCopy:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNCopy:SetPos( 65, 110 )
		SVNCopy:SetWide(ButtonsSidePanel:GetWide() / 2.2 - 2.2)
		SVNCopy:SetTall( 30 )
		SVNCopy.DoClick = function()
			SetClipboardText("https://github.com/bouletmarc/ACF_CustomMod/trunk")
		end
		
		HelpHormal = ButtonsSidePanel:Add("DButton")
		HelpHormal:SetText("Help me with ACF")
		HelpHormal:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpHormal:SetPos( 20, 170 )
		HelpHormal:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		HelpHormal:SetTall( 40 )
		HelpHormal.DoClick = function()
			RunConsoleCommand("acf_help1_browser_open")
			StartBrowserPanel:Close()
		end
		
		BMText1 = ButtonsSidePanel:Add("DLabel")
		BMText1:SetText("Made by Bouletmarc\n      (B0ul3Tm@rc)")
		BMText1:SetTextColor(Color(0,255,0,255))
		BMText1:SetPos(60,320)
		BMText1:SetFont( "DefaultBold" )
		BMText1:SizeToContents()
		
	StartBrowserPanel.OnClose = function()

	end

	StartBrowserPanel:InvalidateLayout(true)
	
end

local function OpenSartBrowser(pl, cmd, args)
	if (!IsValid(StartBrowserPanel)) then
		CreateSoundBrowser()
	end

	StartBrowserPanel:SetVisible(true)
	StartBrowserPanel:MakePopup()
	StartBrowserPanel:InvalidateLayout(true)

	WireLib.Timedcall(function(StartBrowserPanel)
		if (!IsValid(StartBrowserPanel)) then return end

		StartBrowserPanel:InvalidateLayout(true)

	end, StartBrowserPanel)
end

concommand.Add("acf_help_browser_open", OpenSartBrowser)