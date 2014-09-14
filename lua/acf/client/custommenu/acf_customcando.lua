// Made by Bouletmarc.

local StartBrowserPanel = nil

local Changelog = {}

local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetSize(700, 450)
	--Set Center
	StartBrowserPanel:SetPos(((ScrW()/2)-(StartBrowserPanel:GetWide()/2))+ScrW()/4,(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(700)
	StartBrowserPanel:SetMinHeight(450)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("Custom Mod Tips Menu V9.2")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(330, 406)
	ButtonsSidePanel:SetDrawBackground(true)
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
			RunConsoleCommand( "acfcustom_red", Redcolor )
			RunConsoleCommand( "acfcustom_green", Greencolor )
			RunConsoleCommand( "acfcustom_blue", Bluecolor )
			SaveFunc()
		end
		--###########################################
		local CustomCanDoClient = ""
		local CustomCanDoServer = ""
		CustomCanDoClient = CustomCanDoClient .. "       CLIENT :\n"
		CustomCanDoClient = CustomCanDoClient .. "-Engines have a rev limiter(cutoff) sound, can be disabled by wiring DisableCut to a Value that equal 1\n"
		CustomCanDoClient = CustomCanDoClient .. "-Turbine and Eletric engine will not have rev limiter(cut off), its useles for thoses engines\n"
		CustomCanDoClient = CustomCanDoClient .. "-ANY engines not require fuel, to require fuel link a fuel tank (add 25% torque, but the weight come with it)\n"
		CustomCanDoClient = CustomCanDoClient .. "-When you stop a engine, it'll stop progressively\n"
		CustomCanDoClient = CustomCanDoClient .. "-Engines link to the Chips, Nos, Turbo, Supercharger or Radiators\n"
		CustomCanDoClient = CustomCanDoClient .. "-To update the engines made from Engine Maker, select Engine Maker again in the menu, it'll update values\n"
		CustomCanDoClient = CustomCanDoClient .. "-It having all E2 functions like 'acfCustomThrottle(100)', also having customs functions like 'acfCustomTqAdd(50)'\n"
		CustomCanDoClient = CustomCanDoClient .. "-Custom Mod have more sounds, more engines, and also old models back\n"
		CustomCanDoClient = CustomCanDoClient .. "-The CVT from the custom mod are the first acf CVT ever made, and probably better than the original\n"
		CustomCanDoClient = CustomCanDoClient .. "-The Airplane Beta Gearbox are used to rotate and also push/pull a prop like a propeller\n"
		CustomCanDoServer = CustomCanDoServer .. "       SERVER :\n"
		CustomCanDoServer = CustomCanDoServer .. "-sbox_max_acf_modding (0-1) allow engines modding (wire inputs)\n"
		CustomCanDoServer = CustomCanDoServer .. "-sbox_max_acf_extra (Value) the number of acf extras allowed (chips,nos)\n"
		CustomCanDoServer = CustomCanDoServer .. "-sbox_max_acf_maker (Value) the number of engines from engines maker allowed\n"
		CustomCanDoServer = CustomCanDoServer .. "-Anyone can use it if its on the server, and the client only get acf orignal\n"
		
		CurrentText = ButtonsSidePanel:Add("DLabel")
		CurrentText:SetPos(120,20)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("Custom Mod Tips : ")
		CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CurrentText:SizeToContents()
		
		CustomModTipsClient = ButtonsSidePanel:Add("DLabel")
		CustomModTipsClient:SetText(CustomCanDoClient)
		CustomModTipsClient:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CustomModTipsClient:SetPos(20,60)
		CustomModTipsClient:SetFont( "DefaultBold" )
		CustomModTipsClient:SizeToContents()
		
		CustomModTipsServer = ButtonsSidePanel:Add("DLabel")
		CustomModTipsServer:SetText(CustomCanDoServer)
		CustomModTipsServer:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CustomModTipsServer:SetPos(20,230)
		CustomModTipsServer:SetFont( "DefaultBold" )
		CustomModTipsServer:SizeToContents()
		
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos( 220,340 )
		Close:SetWide(80)
		Close:SetTall( 50 )
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
	
	
	StartBrowserPanel.OnClose = function() end

	StartBrowserPanel:InvalidateLayout(false)
	
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

concommand.Add("acf_customcando_open", OpenSartBrowser)