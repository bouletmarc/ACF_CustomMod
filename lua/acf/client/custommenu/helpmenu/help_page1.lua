--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()
	--Set frame
	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(830, 470)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(820)
	MainPanel:SetMinHeight(460)
	--Set options
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("ACF Help Menu by Bouletmarc")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Menu text
	MainText = MainPanel:Add("DLabel")
	MainText:SetText("ACF Help Menu Page1")
	MainText:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	MainText:SetPos(360,15)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	--Add left panel
	local LeftPanel = MainPanel:Add("DPanel")
	LeftPanel:DockMargin(4, 4, 4, 4)
	LeftPanel:Dock(LEFT)
	LeftPanel:SetSize(400, 420)
	LeftPanel:SetDrawBackground(false)
	--Add right panel
	local RightPanel = MainPanel:Add("DPanel")
	RightPanel:DockMargin(4, 4, 4, 4)
	RightPanel:Dock(RIGHT)
	RightPanel:SetSize(400, 420)
	RightPanel:SetDrawBackground(false)
	--------------------------------------
	--	Initialize Panels
	--------------------------------------
		--Set local vars
		local TopLeftText = ""
		local BottomLeftText = ""
		local TopRightText = ""
		local BottomRightText = ""
		local TopLeftName = "With Engine's :"
		local BottomLeftName = "With Gearbox's :"
		local TopRightName = "With Fuel Tank's :"
			local BottomRightName = ""
			--local BottomRightName = "With Chips :"
		local TitleText = "WireMod Part :"
		local TitleName = LeftPanel:Add("DLabel")
		--Set top left text
		TopLeftText = TopLeftText .. "- Active should be wired to a (0-1) value\n"
		TopLeftText = TopLeftText .. "- Throttle should be wired to a (0-100) value\n"
		TopLeftText = TopLeftText .. "- TqAdd to a Torque adding Value\n"
		TopLeftText = TopLeftText .. "- MaxRpmAdd to a Max RPM adding Value\n"
		TopLeftText = TopLeftText .. "- LimitRpmAdd to a Limit RPM adding Value\n"
		TopLeftText = TopLeftText .. "- FlywheelMass to a Flywheel Mass number Value\n"
		TopLeftText = TopLeftText .. "- Idle to a Idle RPM Value\n"
		TopLeftText = TopLeftText .. "- Disable Cutoff to 1 to Disable the Cutoff\n"
		TopLeftText = TopLeftText .. "- Override to a Override RPM Value\n"
		--Set bottom left text
		BottomLeftText = BottomLeftText .. "- Clutch should be wired to (0-1)\n"
		BottomLeftText = BottomLeftText .. "- Brake should be wired to (0-20) too high value make spazz\n"
		BottomLeftText = BottomLeftText .. "- Left/Right Input's are to controls side's wheel's\n"
		BottomLeftText = BottomLeftText .. "- Gear should be wired to your Gear Number Value or\n"
		BottomLeftText = BottomLeftText .. "* if you use GearUp and GearDown, those should\n"
		BottomLeftText = BottomLeftText .. "* be wired to (0-1) to Increase or Decrease Gear.\n"
		--Set top right text
		TopRightText = TopRightText .. "- Active should be wired to a (0-1) value AND\n"
		TopRightText = TopRightText .. "* BEFORE the engine -Active- are wired, to make\n"
		TopRightText = TopRightText .. "* the tank Activate before engine\n\n"
		TopRightText = TopRightText .. "- Refuel Duty to (0-1) to make the tank refuel other tank's"
		--Set bottom right text
		/*BottomRightText = BottomRightText .. "- ActiveChips should be wired to a (0-1) value\n"
		BottomRightText = BottomRightText .. "** OUTPUTS : **\n"
		BottomRightText = BottomRightText .. "- TqAdd to the Engine(Engine to Chips)\n"
		BottomRightText = BottomRightText .. "- MaxRpmAdd to the Engine(Engine to Chips)\n"
		BottomRightText = BottomRightText .. "- LimitRpmAdd to the Engine(Engine to Chips)"*/
		--Set title
		TitleName:SetText(TitleText)
		TitleName:SetTextColor(Color(240,240,240,255))
		TitleName:SetPos(280,20)
		TitleName:SetFont( "DefaultBold" )
		TitleName:SizeToContents()
	--------------------------------------
	--	Left Panel Menu
	--------------------------------------
		--Set local vars
		local TopLeftTitle, TopLeft = LeftPanel:Add("DLabel"), LeftPanel:Add("DLabel")
		local BottomLeftTitle, BottomLeft = LeftPanel:Add("DLabel"), LeftPanel:Add("DLabel")
		--Set top left title
		TopLeftTitle:SetText(TopLeftName)
		TopLeftTitle:SetTextColor(Color(210,210,210,255))
		TopLeftTitle:SetPos(40,40)
		TopLeftTitle:SetFont( "DefaultBold" )
		TopLeftTitle:SizeToContents()
		--Set top left text
		TopLeft:SetText(TopLeftText)
		TopLeft:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TopLeft:SetPos(20,60)
		TopLeft:SetFont( "DefaultBold" )
		TopLeft:SizeToContents()
		--Set bottom left title
		BottomLeftTitle:SetText(BottomLeftName)
		BottomLeftTitle:SetTextColor(Color(210,210,210,255))
		BottomLeftTitle:SetPos(40,220)
		BottomLeftTitle:SetFont( "DefaultBold" )
		BottomLeftTitle:SizeToContents()
		--Set bottom left text
		BottomLeft:SetText(BottomLeftText)
		BottomLeft:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BottomLeft:SetPos(20,240)
		BottomLeft:SetFont( "DefaultBold" )
		BottomLeft:SizeToContents()
	--------------------------------------
	--	Right Panel Menu
	--------------------------------------
		--Set local vars
		local TopRightTitle, TopRight = RightPanel:Add("DLabel"), RightPanel:Add("DLabel")
		local BottomRightTitle, BottomRight = RightPanel:Add("DLabel"), RightPanel:Add("DLabel")
		--Set top right title
		TopRightTitle:SetText(TopRightName)
		TopRightTitle:SetTextColor(Color(210,210,210,255))
		TopRightTitle:SetPos(20,40)
		TopRightTitle:SetFont( "DefaultBold" )
		TopRightTitle:SizeToContents()
		--Set top right text
		TopRight:SetText(TopRightText)
		TopRight:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TopRight:SetPos(0,60)
		TopRight:SetFont( "DefaultBold" )
		TopRight:SizeToContents()
		--Set bottom right title
		BottomRightTitle:SetText(BottomRightName)
		BottomRightTitle:SetTextColor(Color(210,210,210,255))
		BottomRightTitle:SetPos(20,200)
		BottomRightTitle:SetFont( "DefaultBold" )
		BottomRightTitle:SizeToContents()
		--Set bottom right text
		BottomRight:SetText(BottomRightText)
		BottomRight:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BottomRight:SetPos(0,220)
		BottomRight:SetFont( "DefaultBold" )
		BottomRight:SizeToContents()
	--------------------------------------
	--	End Panel Menu
	--------------------------------------
		--Set close button
		local Close = LeftPanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Close:SetPos(30,360)
		Close:SetWide(80)
		Close:SetTall(40)
		Close.DoClick = function()
			MainPanel:Close()
		end
		--Set next page button
		local HelpNext = LeftPanel:Add("DButton")
		HelpNext:SetText("Help Next Page")
		HelpNext:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		HelpNext:SetPos(280,360)
		HelpNext:SetWide(100)
		HelpNext:SetTall(40)
		HelpNext.DoClick = function()
			RunConsoleCommand("acf_help2_open")
			MainPanel:Close()
		end

	MainPanel:InvalidateLayout(true)
	
end
--------------------------------------
--	Open Menu
--------------------------------------
local function OpenMenu(pl, cmd, args)
	if (!IsValid(MainPanel)) then
		CreateMenu()
	end

	MainPanel:SetVisible(true)
	MainPanel:MakePopup()
	MainPanel:InvalidateLayout(true)

	WireLib.Timedcall(function(MainPanel)
		if (!IsValid(MainPanel)) then return end

		MainPanel:InvalidateLayout(true)

	end, MainPanel)
end
concommand.Add("acf_help1_open", OpenMenu)