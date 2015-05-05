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
	MainPanel:SetTitle("Custom Mod Tips Menu V3")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
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
		local TopLeftName = "CLIENT :"
		local BottomLeftName = ""
		local TopRightName = "SERVER :"
		local BottomRightName = ""
		--Set top left text
		TopLeftText = TopLeftText .. "-Engines have rev limiter sound\n"
		TopLeftText = TopLeftText .. "--disable it by wiring DisableCut to a Value(0-1)\n"
		TopLeftText = TopLeftText .. "--Turbine and Electric engine will not have rev limiter\n\n"
		TopLeftText = TopLeftText .. "-ANY engines not require fuel\n"
		TopLeftText = TopLeftText .. "--linking a tank add 25% torque and weight\n\n"
		TopLeftText = TopLeftText .. "-When you stop a engine, it'll stop progressively\n\n"
		TopLeftText = TopLeftText .. "-Selecting again EngineMaker in the menu make it updating values\n\n"
		TopLeftText = TopLeftText .. "-Have Custom E2 functions\n\n"
		TopLeftText = TopLeftText .. "-Custom Mod have more sounds, more engines, and old models\n\n"
		TopLeftText = TopLeftText .. "-The CVT from the custom mod are the first ACF CVT ever made\n\n"
		TopLeftText = TopLeftText .. "-The Airplane Beta Gearbox are used to rotate and also push/pull\n"
		TopLeftText = TopLeftText .. "--a prop like a propeller\n\n"
		--Set bottom left text
		BottomLeftText = BottomLeftText .. ""
		--Set top right text
		TopRightText = TopRightText .. "-sbox_max_acf_modding (0-1) allow engines modding (wire inputs)\n\n"
		TopRightText = TopRightText .. "-sbox_max_acf_extra (Value) the number of acf extras allowed\n\n"
		TopRightText = TopRightText .. "-sbox_max_acf_maker (Value) the number of engines maker allowed\n\n"
		TopRightText = TopRightText .. "-Anyone can use CustomMod on the server\n"
		TopRightText = TopRightText .. "--even if the client not have it\n\n"
		--Set bottom right text
		BottomRightText = BottomRightText .. ""
		
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
concommand.Add("acf_tips_open", OpenMenu)