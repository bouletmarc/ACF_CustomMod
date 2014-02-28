// Made by Bouletmarc.

local StartBrowserPanel = nil

local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetPos(600,200)
	StartBrowserPanel:SetSize(200, 320)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(200)
	StartBrowserPanel:SetMinHeight(320)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( false )
	StartBrowserPanel:SetTitle("Engine Maker Start Menu V8.1")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(180, 300)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
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
			RunConsoleCommand( "acfmenu_red", Redcolor )
			RunConsoleCommand( "acfmenu_green", Greencolor )
			RunConsoleCommand( "acfmenu_blue", Bluecolor )
			SaveFunc()
		end
		--###########################################
		--create menu text
		CurrentText = ButtonsSidePanel:Add("DLabel")
		CurrentText:SetPos(35,10)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("   ACF Engine Maker\nMade By Bouletmarc")
		CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CurrentText:SizeToContents()
		
		CreateEng = ButtonsSidePanel:Add("DButton")
		CreateEng:SetText("Create New Engine")
		CreateEng:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CreateEng:SetToolTip("Create a New Engine\nChoose Values, Model, Sound, Name\nAnd save it !")
		CreateEng:SetPos( 35, 60 )
		CreateEng:SetWide(110)
		CreateEng:SetTall( 40 )
		CreateEng.DoClick = function()
			RunConsoleCommand("acf_enginecreate_browser_open")
			StartBrowserPanel:Close()
		end
		
		LoadEng = ButtonsSidePanel:Add("DButton")
		LoadEng:SetText("Load/Edit Engine")
		LoadEng:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		LoadEng:SetToolTip("Load a engine\nThen edit it if you want")
		LoadEng:SetPos( 35, 110 )
		LoadEng:SetWide(110)
		LoadEng:SetTall( 40 )
		LoadEng.DoClick = function()
			RunConsoleCommand("acf_engineload_browser_open")
			StartBrowserPanel:Close()
		end
		
		EditLastEng = ButtonsSidePanel:Add("DButton")
		EditLastEng:SetText("Edit Last Engine")
		EditLastEng:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		EditLastEng:SetToolTip("Edit the Last Engine used")
		EditLastEng:SetPos( 35, 160 )
		EditLastEng:SetWide(110)
		EditLastEng:SetTall( 40 )
		EditLastEng.DoClick = function()
			RunConsoleCommand("acf_enginecreateload_browser_open")
			StartBrowserPanel:Close()
		end
		
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos( 50,220 )
		Close:SetWide(80)
		Close:SetTall( 50 )
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end

	StartBrowserPanel.OnClose = function() end

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

concommand.Add("acf_enginestart_browser_open", OpenSartBrowser)