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
	MainPanel:SetSize(250, 400)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(250)
	MainPanel:SetMinHeight(400)
	--Set options
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( false )
	MainPanel:SetTitle("ACF Help Menu")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(4, 4, 4, 4)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(230, 360)
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--Set local vars
		local Text1, Text3 = SecondPanel:Add("DLabel"), SecondPanel:Add("DLabel")
		local Text2 = SecondPanel:Add( "DTextEntry" )
		local Copy, Help = SecondPanel:Add("DButton"), SecondPanel:Add("DButton")
		--Set Text1
		Text1:SetText("First make sure you have \n   ACF Custom Installed. \n\n          Here the SVN :")
		Text1:SetTextColor(Color(0,255,0,255))
		Text1:SetPos(45,20)
		Text1:SetFont( "DefaultBold" )
		Text1:SizeToContents()
		--Set Text2
		Text2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
		Text2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Text2:SetPos( 10,80 )
		Text2:SetWide( 220 )
		Text2.OnTextChanged = function( )
			if Text2:GetValue() != "https://github.com/bouletmarc/ACF_CustomMod/trunk" then
				Text2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
			end
		end
		--Set Copy Button
		Copy:SetText("Copy SVN link")
		Copy:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Copy:SetPos( 65, 110 )
		Copy:SetWide(SecondPanel:GetWide() / 2.2 - 2.2)
		Copy:SetTall( 30 )
		Copy.DoClick = function()
			SetClipboardText("https://github.com/bouletmarc/ACF_CustomMod/trunk")
		end
		--Set Help Button
		Help:SetText("Help me with ACF")
		Help:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Help:SetPos( 20, 170 )
		Help:SetWide(SecondPanel:GetWide() / 1.2 - 1.2)
		Help:SetTall( 40 )
		Help.DoClick = function()
			RunConsoleCommand("acf_help1_open")
			MainPanel:Close()
		end
		--Set Owner
		Text3:SetText("Made by Bouletmarc\n      (B0ul3Tm@rc)")
		Text3:SetTextColor(Color(0,255,0,255))
		Text3:SetPos(60,320)
		Text3:SetFont( "DefaultBold" )
		Text3:SizeToContents()

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
concommand.Add("acf_help_open", OpenMenu)