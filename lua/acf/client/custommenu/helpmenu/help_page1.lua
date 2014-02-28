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
	MainText:SetText("ACF Help Menu Page1")
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
		WireModText1 = ButtonsSidePanel:Add("DLabel")
		WireModText1:SetText("WireMod Part :")
		WireModText1:SetTextColor(Color(0,170,170,255))
		WireModText1:SetPos(280,20)
		WireModText1:SetFont( "DefaultBold" )
		WireModText1:SizeToContents()
		--#########################################################################################
		WireModTextEngine = ButtonsSidePanel:Add("DLabel")
		WireModTextEngine:SetText("With Engine's :")
		WireModTextEngine:SetTextColor(Color(210,210,210,255))
		WireModTextEngine:SetPos(40,40)
		WireModTextEngine:SetFont( "DefaultBold" )
		WireModTextEngine:SizeToContents()
		
		WireModTextGearbox = ButtonsSidePanel2:Add("DLabel")
		WireModTextGearbox:SetText("With Gearbox's :")
		WireModTextGearbox:SetTextColor(Color(210,210,210,255))
		WireModTextGearbox:SetPos(20,40)
		WireModTextGearbox:SetFont( "DefaultBold" )
		WireModTextGearbox:SizeToContents()
		
		WireModTextChips = ButtonsSidePanel:Add("DLabel")
		WireModTextChips:SetText("With Chips's :")
		WireModTextChips:SetTextColor(Color(210,210,210,255))
		WireModTextChips:SetPos(40,220)
		WireModTextChips:SetFont( "DefaultBold" )
		WireModTextChips:SizeToContents()
		
		WireModTextFuel = ButtonsSidePanel2:Add("DLabel")
		WireModTextFuel:SetText("With Fuel Tank's :")
		WireModTextFuel:SetTextColor(Color(210,210,210,255))
		WireModTextFuel:SetPos(20,200)
		WireModTextFuel:SetFont( "DefaultBold" )
		WireModTextFuel:SizeToContents()
		--#########################################################################################	
		local WireLineEngine = ""
		WireLineEngine = WireLineEngine .. "- Active should be wired to a (0-1) value\n"
		WireLineEngine = WireLineEngine .. "- Throttle should be wired to a (0-100) value\n"
		WireLineEngine = WireLineEngine .. "- TqAdd to a Torque adding Value\n"
		WireLineEngine = WireLineEngine .. "- MaxRpmAdd to a Max RPM adding Value\n"
		WireLineEngine = WireLineEngine .. "- LimitRpmAdd to a Limit RPM adding Value\n"
		WireLineEngine = WireLineEngine .. "- FlywheelMass to a Flywheel Mass number Value\n"
		WireLineEngine = WireLineEngine .. "- Idle to a Idle RPM Value\n"
		WireLineEngine = WireLineEngine .. "- Disable Cutoff to 1 to Disable the Cutoff\n"
		WireLineEngine = WireLineEngine .. "- Override to a Override RPM Value\n"
		WireLineEngine = WireLineEngine .. "- Gearbox RPM to Gearbox ONLY if you don't want\n"
		WireLineEngine = WireLineEngine .. "* your engine to use the autoclutch system\n"
		
		local WireLineGearbox = ""
		WireLineGearbox = WireLineGearbox .. "- Clutch should be wired to (0-1)\n"
		WireLineGearbox = WireLineGearbox .. "- Brake should be wired to (0-20) too high value make spazz\n"
		WireLineGearbox = WireLineGearbox .. "- Left/Right Input's are to controls side's wheel's\n"
		WireLineGearbox = WireLineGearbox .. "- Gear should be wired to your Gear Number Value or\n"
		WireLineGearbox = WireLineGearbox .. "* if you use GearUp and GearDown, those should\n"
		WireLineGearbox = WireLineGearbox .. "* be wired to (0-1) to Increase or Decrease Gear.\n"
		
		local WireLineChips = ""
		WireLineChips = WireLineChips .. "- ActiveChips should be wired to a (0-1) value\n"
		WireLineChips = WireLineChips .. "** OUTPUTS : **\n"
		WireLineChips = WireLineChips .. "- TqAdd to the Engine(Engine to Chips)\n"
		WireLineChips = WireLineChips .. "- MaxRpmAdd to the Engine(Engine to Chips)\n"
		WireLineChips = WireLineChips .. "- LimitRpmAdd to the Engine(Engine to Chips)"
		
		local WireLineFuel = ""
		WireLineFuel = WireLineFuel .. "- Active should be wired to a (0-1) value AND\n"
		WireLineFuel = WireLineFuel .. "* BEFORE the engine -Active- are wired, to make\n"
		WireLineFuel = WireLineFuel .. "* the tank Activate before engine\n\n"
		WireLineFuel = WireLineFuel .. "- Refuel Duty to (0-1) to make the tank refuel other tank's"
		--#########################################################################################	
		WireModText2 = ButtonsSidePanel:Add("DLabel")
		WireModText2:SetText(WireLineEngine)
		WireModText2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModText2:SetPos(20,60)
		WireModText2:SetFont( "DefaultBold" )
		WireModText2:SizeToContents()
		
		WireModText3 = ButtonsSidePanel2:Add("DLabel")
		WireModText3:SetText(WireLineGearbox)
		WireModText3:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModText3:SetPos(0,60)
		WireModText3:SetFont( "DefaultBold" )
		WireModText3:SizeToContents()
		
		WireModText2 = ButtonsSidePanel:Add("DLabel")
		WireModText2:SetText(WireLineChips)
		WireModText2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModText2:SetPos(20,240)
		WireModText2:SetFont( "DefaultBold" )
		WireModText2:SizeToContents()
		
		WireModTextFuelDesc = ButtonsSidePanel2:Add("DLabel")
		WireModTextFuelDesc:SetText(WireLineFuel)
		WireModTextFuelDesc:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WireModTextFuelDesc:SetPos(0,220)
		WireModTextFuelDesc:SetFont( "DefaultBold" )
		WireModTextFuelDesc:SizeToContents()
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
		
		HelpNext = ButtonsSidePanel:Add("DButton")
		HelpNext:SetText("Help Next Page")
		HelpNext:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpNext:SetPos(280,360)
		HelpNext:SetWide(100)
		HelpNext:SetTall(40)
		HelpNext.DoClick = function()
			RunConsoleCommand("acf_help2_browser_open")
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

concommand.Add("acf_help1_browser_open", OpenSartBrowser)