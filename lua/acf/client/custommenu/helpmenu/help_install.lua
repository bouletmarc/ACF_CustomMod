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
	StartBrowserPanel:SetSize(300, 550)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(290)
	StartBrowserPanel:SetMinHeight(540)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("ACF Install Menu by Bouletmarc")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	MainText = StartBrowserPanel:Add("DLabel")
	MainText:SetText("Help with Custom Acf Installation")
	MainText:SetTextColor(Color(0,255,0,255))
	MainText:SetPos(60,35)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(280, 530)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
		HelpInstallText1 = ButtonsSidePanel:Add("DLabel")
		HelpInstallText1:SetText("First Step :")
		HelpInstallText1:SetTextColor(Color(0,170,170,255))
		HelpInstallText1:SetPos(40,40)
		HelpInstallText1:SetFont( "DefaultBold" )
		HelpInstallText1:SizeToContents()
		
		HelpInstallText2 = ButtonsSidePanel:Add("DLabel")
		HelpInstallText2:SetText("Second Step :")
		HelpInstallText2:SetTextColor(Color(0,170,170,255))
		HelpInstallText2:SetPos(40,180)
		HelpInstallText2:SetFont( "DefaultBold" )
		HelpInstallText2:SizeToContents()
		
		HelpInstallText3 = ButtonsSidePanel:Add("DLabel")
		HelpInstallText3:SetText("Third Step :")
		HelpInstallText3:SetTextColor(Color(0,170,170,255))
		HelpInstallText3:SetPos(40,330)
		HelpInstallText3:SetFont( "DefaultBold" )
		HelpInstallText3:SizeToContents()
		--#########################################################################################	
		local HelpInstallLine = ""
		HelpInstallLine = HelpInstallLine .. "FIRST please make sure you got a fresh copy\n"
		HelpInstallLine = HelpInstallLine .. "of acf installed using this SVN Link :\n"
		
		local HelpInstallLine2 = ""
		HelpInstallLine2 = HelpInstallLine2 .. "Then create a new folder on the desktop or\n"
		HelpInstallLine2 = HelpInstallLine2 .. "anywhere you want but NOT in addons folder,\n"
		HelpInstallLine2 = HelpInstallLine2 .. "and use the SVN Link bellow :\n"
		
		local HelpInstallLine3 = ""
		HelpInstallLine3 = HelpInstallLine3 .. "Now Copy all file's from the\n"
		HelpInstallLine3 = HelpInstallLine3 .. "Custom Acf SVN Folder and Paste it to the\n"
		HelpInstallLine3 = HelpInstallLine3 .. "first acf folder, the folder used in the\n"
		HelpInstallLine3 = HelpInstallLine3 .. "'First Step' for the fresh copy. Then put\n"
		HelpInstallLine3 = HelpInstallLine3 .. "or make sure this final modded folder are\n"
		HelpInstallLine3 = HelpInstallLine3 .. "in Gmod addons folder\n"
		--#########################################################################################	
		HelpInstallDesc1 = ButtonsSidePanel:Add("DLabel")
		HelpInstallDesc1:SetText(HelpInstallLine)
		HelpInstallDesc1:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpInstallDesc1:SetPos(20,60)
		HelpInstallDesc1:SetFont( "DefaultBold" )
		HelpInstallDesc1:SizeToContents()
		--#########################################################################################	
		SVNText = ButtonsSidePanel:Add( "DTextEntry" )
		SVNText:SetText( "https://github.com/nrlulz/ACF.git/trunk" )
		SVNText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNText:SetPos( 40,100 )
		SVNText:SetWide( 200 )
		SVNText.OnTextChanged = function( )
			if SVNText:GetValue() != "https://github.com/nrlulz/ACF.git/trunk" then
				SVNText:SetText( "https://github.com/nrlulz/ACF.git/trunk" )
			end
		end
		
		SVNCopy = ButtonsSidePanel:Add("DButton") // The play button.
		SVNCopy:SetText("Copy SVN link")
		SVNCopy:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNCopy:SetPos( 80, 130 )
		SVNCopy:SetWide( 120 )
		SVNCopy:SetTall( 30 )
		SVNCopy.DoClick = function()
			SetClipboardText("https://github.com/nrlulz/ACF.git/trunk")
		end
		--#########################################################################################	
		HelpInstallDesc2 = ButtonsSidePanel:Add("DLabel")
		HelpInstallDesc2:SetText(HelpInstallLine2)
		HelpInstallDesc2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpInstallDesc2:SetPos(20,200)
		HelpInstallDesc2:SetFont( "DefaultBold" )
		HelpInstallDesc2:SizeToContents()
		--#########################################################################################	
		SVNText2 = ButtonsSidePanel:Add( "DTextEntry" )
		SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
		SVNText2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNText2:SetPos( 5,250 )
		SVNText2:SetWide( 270 )
		SVNText2.OnTextChanged = function( )
			if SVNText2:GetValue() != "https://github.com/bouletmarc/ACF_CustomMod/trunk" then
				SVNText2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
			end
		end
		
		SVNCopy2 = ButtonsSidePanel:Add("DButton") // The play button.
		SVNCopy2:SetText("Copy SVN link")
		SVNCopy2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SVNCopy2:SetPos( 80, 280 )
		SVNCopy2:SetWide( 120 )
		SVNCopy2:SetTall( 30 )
		SVNCopy2.DoClick = function()
			SetClipboardText("https://github.com/bouletmarc/ACF_CustomMod/trunk")
		end
		--#########################################################################################	
		HelpInstallDesc3 = ButtonsSidePanel:Add("DLabel")
		HelpInstallDesc3:SetText(HelpInstallLine3)
		HelpInstallDesc3:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpInstallDesc3:SetPos(20,350)
		HelpInstallDesc3:SetFont( "DefaultBold" )
		HelpInstallDesc3:SizeToContents()
		--#########################################################################################	
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos(30,460)
		Close:SetWide(80)
		Close:SetTall(40)
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
		--#########################################################################################	

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

concommand.Add("acf_helpinstall_browser_open", OpenSartBrowser)