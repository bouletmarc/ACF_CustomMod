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
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Menu text
	MainText = MainPanel:Add("DLabel")
	MainText:SetText("ACF Help Menu Page2")
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
		local TopLeftName = "Linking Part :"
		local BottomLeftName = ""
		local TopRightName = ""
		local BottomRightName = ""
		local TitleText = ""
		local TitleName = LeftPanel:Add("DLabel")
		--Set top left text
		TopLeftText = TopLeftText .. "*To LINK, you must RIGHT clic on both entities with acf_menu*\n"
		TopLeftText = TopLeftText .. "*To UNLINK, you must hold -E- and right clic with acf_menu*\n\n"
		TopLeftText = TopLeftText .. "- Engine must be linked to Gearbox, FuelTank or a Engine Extra\n"
		TopLeftText = TopLeftText .. "- Gearbox's must be linked to Wheels (regular prop's)\n"
		TopLeftText = TopLeftText .. "- Gun must be linked to the Ammo Box\n\n"
		TopLeftText = TopLeftText .. "-- Chips, Nos, Turbo, Supercharger and Radiator is a Engine Extra\n"
		--Set bottom left text
		BottomLeftText = BottomLeftText .. ""
		--Set top right text
		TopRightText = TopRightText .. ""
		--Set bottom right text
		BottomRightText = BottomRightText .. ""
		--Set title
		TitleName:SetText(TitleText)
		TitleName:SetTextColor(Color(240,240,240,255))
		TitleName:SetPos(280,20)
		TitleName:SetFont( "DefaultBold" )
		TitleName:SizeToContents()
	--------------------------------------
	--	Left Panel Menu
	--------------------------------------
		--Set top left title
		local TopLeftTitle = LeftPanel:Add("DLabel")
		TopLeftTitle:SetText(TopLeftName)
		TopLeftTitle:SetTextColor(Color(210,210,210,255))
		TopLeftTitle:SetPos(40,40)
		TopLeftTitle:SetFont( "DefaultBold" )
		TopLeftTitle:SizeToContents()
		--Set top left text
		local TopLeft = LeftPanel:Add("DLabel")
		TopLeft:SetText(TopLeftText)
		TopLeft:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TopLeft:SetPos(20,60)
		TopLeft:SetFont( "DefaultBold" )
		TopLeft:SizeToContents()
		--Set bottom left title
		local BottomLeftTitle = LeftPanel:Add("DLabel")
		BottomLeftTitle:SetText(BottomLeftName)
		BottomLeftTitle:SetTextColor(Color(210,210,210,255))
		BottomLeftTitle:SetPos(40,220)
		BottomLeftTitle:SetFont( "DefaultBold" )
		BottomLeftTitle:SizeToContents()
		--Set bottom left text
		local BottomLeft = LeftPanel:Add("DLabel")
		BottomLeft:SetText(BottomLeftText)
		BottomLeft:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BottomLeft:SetPos(20,240)
		BottomLeft:SetFont( "DefaultBold" )
		BottomLeft:SizeToContents()
	--------------------------------------
	--	Right Panel Menu
	--------------------------------------
		--Set top right title
		local TopRightTitle = RightPanel:Add("DLabel")
		TopRightTitle:SetText(TopRightName)
		TopRightTitle:SetTextColor(Color(210,210,210,255))
		TopRightTitle:SetPos(20,40)
		TopRightTitle:SetFont( "DefaultBold" )
		TopRightTitle:SizeToContents()
		--Set top right text
		local TopRight = RightPanel:Add("DLabel")
		TopRight:SetText(TopRightText)
		TopRight:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TopRight:SetPos(0,60)
		TopRight:SetFont( "DefaultBold" )
		TopRight:SizeToContents()
		--Set bottom right title
		local BottomRightTitle = RightPanel:Add("DLabel")
		BottomRightTitle:SetText(BottomRightName)
		BottomRightTitle:SetTextColor(Color(210,210,210,255))
		BottomRightTitle:SetPos(20,200)
		BottomRightTitle:SetFont( "DefaultBold" )
		BottomRightTitle:SizeToContents()
		--Set bottom right text
		local BottomRight = RightPanel:Add("DLabel")
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
		--Set back page button
		local HelpBack = LeftPanel:Add("DButton")
		HelpBack:SetText("Help Back Page")
		HelpBack:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		HelpBack:SetPos(170,360)
		HelpBack:SetWide(100)
		HelpBack:SetTall(40)
		HelpBack.DoClick = function()
			RunConsoleCommand("acf_help1_open")
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
			RunConsoleCommand("acf_help3_open")
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
concommand.Add("acf_help2_open", OpenMenu)