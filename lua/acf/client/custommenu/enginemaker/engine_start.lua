--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
EngineMakerUseLoad = false
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetPos(600,200)
	MainPanel:SetSize(200, 320)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))

	MainPanel:SetMinWidth(200)
	MainPanel:SetMinHeight(320)
	
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( false )
	MainPanel:SetTitle("Engine Maker Start Menu V"..ACFCUSTOM.EngineMakerVersion)
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel	
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(4, 4, 4, 4)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(180, 300)
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--create menu text
		CurrentText = SecondPanel:Add("DLabel")
		CurrentText:SetPos(35,10)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("   ACF Engine Maker\nMade By Bouletmarc")
		CurrentText:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		CurrentText:SizeToContents()
		
		CreateEng = SecondPanel:Add("DButton")
		CreateEng:SetText("Create New Engine")
		CreateEng:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		CreateEng:SetToolTip("Create a New Engine\nChoose Values, Model, Sound, Name\nAnd save it !")
		CreateEng:SetPos( 35, 60 )
		CreateEng:SetWide(110)
		CreateEng:SetTall( 40 )
		CreateEng.DoClick = function()
			EngineMakerUseLoad = false
			RunConsoleCommand("acf_enginecreate_open")
			MainPanel:Close()
		end
		
		LoadEng = SecondPanel:Add("DButton")
		LoadEng:SetText("Load/Edit Engine")
		LoadEng:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		LoadEng:SetToolTip("Load a engine\nThen edit it if you want")
		LoadEng:SetPos( 35, 110 )
		LoadEng:SetWide(110)
		LoadEng:SetTall( 40 )
		LoadEng.DoClick = function()
			RunConsoleCommand("acf_engineload_open")
			MainPanel:Close()
		end
		
		EditLastEng = SecondPanel:Add("DButton")
		EditLastEng:SetText("Edit Last Engine")
		EditLastEng:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		EditLastEng:SetToolTip("Edit the Last Engine used")
		EditLastEng:SetPos( 35, 160 )
		EditLastEng:SetWide(110)
		EditLastEng:SetTall( 40 )
		EditLastEng.DoClick = function()
			EngineMakerUseLoad = true
			RunConsoleCommand("acf_enginecreate_open")
			MainPanel:Close()
		end
		
		Close = SecondPanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Close:SetPos( 50,220 )
		Close:SetWide(80)
		Close:SetTall( 50 )
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
concommand.Add("acf_enginestart_open", OpenMenu)