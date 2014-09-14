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
	StartBrowserPanel:SetSize(830, 470)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(820)
	StartBrowserPanel:SetMinHeight(460)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("ACF Help Menu by Bouletmarc")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	MainText = StartBrowserPanel:Add("DLabel")
	MainText:SetText("ACF Help Menu Page2")
	MainText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	MainText:SetPos(360,15)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(LEFT)
	ButtonsSidePanel:SetSize(400, 420)
	ButtonsSidePanel:SetDrawBackground(false)
	local ButtonsSidePanel2 = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel2:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel2:Dock(RIGHT)
	ButtonsSidePanel2:SetSize(400, 420)
	ButtonsSidePanel2:SetDrawBackground(false)
	--#############################################################
		/*WireModText1 = ButtonsSidePanel:Add("DLabel")
		WireModText1:SetText("WireMod Part :")
		WireModText1:SetTextColor(Color(0,170,170,255))
		WireModText1:SetPos(280,20)
		WireModText1:SetFont( "DefaultBold" )
		WireModText1:SizeToContents()
		--#########################################################################################
		WireModTextVtec = ButtonsSidePanel:Add("DLabel")
		WireModTextVtec:SetText("With Vtec's :")
		WireModTextVtec:SetTextColor(Color(210,210,210,255))
		WireModTextVtec:SetPos(40,40)
		WireModTextVtec:SetFont( "DefaultBold" )
		WireModTextVtec:SizeToContents()
		
		WireModTextNos = ButtonsSidePanel2:Add("DLabel")
		WireModTextNos:SetText("With Nos :")
		WireModTextNos:SetTextColor(Color(210,210,210,255))
		WireModTextNos:SetPos(20,40)
		WireModTextNos:SetFont( "DefaultBold" )
		WireModTextNos:SizeToContents()*/
		
		LinkingText1 = ButtonsSidePanel:Add("DLabel")
		LinkingText1:SetText("Linking Part :")
		LinkingText1:SetTextColor(Color(0,170,170,255))
		LinkingText1:SetPos(40,40)
		LinkingText1:SetFont( "DefaultBold" )
		LinkingText1:SizeToContents()
		
		/*EngineTextOption = ButtonsSidePanel2:Add("DLabel")
		EngineTextOption:SetText("Engine options button's")
		EngineTextOption:SetTextColor(Color(0,170,170,255))
		EngineTextOption:SetPos(20,180)
		EngineTextOption:SetFont( "DefaultBold" )
		EngineTextOption:SizeToContents()*/
		--#########################################################################################
		/*local WireLineVtec = ""
		WireLineVtec = WireLineVtec .. "- RPM should be wired to the Engine\n"
		WireLineVtec = WireLineVtec .. "** OUTPUTS : **\n"
		WireLineVtec = WireLineVtec .. "- ActiveChips to a ACF Chips(Chips to Vtec)\n\n"
		WireLineVtec = WireLineVtec .. "To make the engine powerful on the Vtec, you\n"
		WireLineVtec = WireLineVtec .. "should wire together a Vtec, a Engine and a Chips\n"
		WireLineVtec = WireLineVtec .. "Vtec get value from Engine and throw it to the Chips\n"
		WireLineVtec = WireLineVtec .. "Chips will throw the Power to the Engine at the end"
		
		local WireLineNos = ""
		WireLineNos = WireLineNos .. "- ActiveNos should be wired to a (0-1) value\n"
		WireLineNos = WireLineNos .. "** OUTPUTS : **\n"
		WireLineNos = WireLineNos .. "- TqAdd to the Engine(Engine to Nos)\n"
		WireLineNos = WireLineNos .. "- MaxRpmAdd to the Engine(Engine to Nos)\n"
		WireLineNos = WireLineNos .. "- LimitRpmAdd to the Engine(Engine to Nos)"
		WireLineNos = WireLineNos .. "- Usable to a Screen or similar to know if\n"
		WireLineNos = WireLineNos .. "  you can activate it"*/
		
		local LinkingLine1 = ""
		LinkingLine1 = LinkingLine1 .. "*To LINK, you must RIGHT clic on both entities with acf_menu*\n"
		LinkingLine1 = LinkingLine1 .. "*To UNLINK, you must hold -E- and right clic with acf_menu*\n\n"
		LinkingLine1 = LinkingLine1 .. "- Engine must be linked to Gearbox, FuelTank or a Engine Extra\n"
		LinkingLine1 = LinkingLine1 .. "- Gearbox's must be linked to Wheels (regular prop's)\n"
		LinkingLine1 = LinkingLine1 .. "- Gun must be linked to the Ammo Box\n\n"
		LinkingLine1 = LinkingLine1 .. "-- Chips, Nos, Turbo, Supercharger and Radiator is a Engine Extra\n"
		
		--local EngineLineOption = ""
		--#########################################################################################
		/*WireModText3 = ButtonsSidePanel:Add("DLabel")
		WireModText3:SetText(WireLineVtec)
		WireModText3:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModText3:SetPos(20,60)
		WireModText3:SetFont( "DefaultBold" )
		WireModText3:SizeToContents()
		
		WireModText4 = ButtonsSidePanel2:Add("DLabel")
		WireModText4:SetText(WireLineNos)
		WireModText4:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModText4:SetPos(0,60)
		WireModText4:SetFont( "DefaultBold" )
		WireModText4:SizeToContents()*/
		
		LinkingText2 = ButtonsSidePanel:Add("DLabel")
		LinkingText2:SetText(LinkingLine1)
		LinkingText2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		LinkingText2:SetPos(20,80)
		LinkingText2:SetFont( "DefaultBold" )
		LinkingText2:SizeToContents()
		
		/*EngineTextOptionDesc = ButtonsSidePanel2:Add("DLabel")
		EngineTextOptionDesc:SetText(EngineLineOption)
		EngineTextOptionDesc:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		EngineTextOptionDesc:SetPos(0,200)
		EngineTextOptionDesc:SetFont( "DefaultBold" )
		EngineTextOptionDesc:SizeToContents()*/
		--#########################################################################################
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos(30,360)
		Close:SetWide(80)
		Close:SetTall(40)
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
		
		HelpBack = ButtonsSidePanel:Add("DButton")
		HelpBack:SetText("Help Back Page")
		HelpBack:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpBack:SetPos(170,360)
		HelpBack:SetWide(100)
		HelpBack:SetTall(40)
		HelpBack.DoClick = function()
			RunConsoleCommand("acf_help1_browser_open")
			StartBrowserPanel:Close()
		end
		
		/*HelpNext = ButtonsSidePanel:Add("DButton")
		HelpNext:SetText("Help Next Page")
		HelpNext:SetTextColor(Color(0,0,255,255))
		HelpNext:SetPos(280,360)
		HelpNext:SetWide(100)
		HelpNext:SetTall(40)
		HelpNext.DoClick = function()
			RunConsoleCommand("acf_help2_browser_open")
			StartBrowserPanel:Close()
		end*/
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

concommand.Add("acf_help2_browser_open", OpenSartBrowser)