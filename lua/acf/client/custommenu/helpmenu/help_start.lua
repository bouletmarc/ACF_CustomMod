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
	MainPanel:SetSize(300, 400)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(300)
	MainPanel:SetMinHeight(400)
	--Set options
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( false )
	MainPanel:SetTitle("ACF Help Menu")
	MainPanel:SetVisible(false)
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(1, 5, 1, 5)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(240, 360)
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--Set Text1
		local Text1 = SecondPanel:Add("DLabel")
		Text1:SetText("First make sure you have \n   ACF Custom Installed. \n\n          Here the SVN :")
		Text1:SetTextColor(Color(0,255,0,255))
		Text1:SetPos(70,20)
		Text1:SetFont( "DefaultBold" )
		Text1:SizeToContents()
		--Set Text2
		local Text2 = SecondPanel:Add( "DTextEntry" )
		Text2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
		Text2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Text2:SetPos( 12,60 )
		Text2:SetWide( 268 )
		Text2.OnTextChanged = function( )
			if Text2:GetValue() != "https://github.com/bouletmarc/ACF_CustomMod/trunk" then
				Text2:SetText( "https://github.com/bouletmarc/ACF_CustomMod/trunk" )
			end
		end
		--Set Copy Button
		local Copy = SecondPanel:Add("DButton")
		Copy:SetText("Copy SVN link")
		Copy:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Copy:SetPos( 90, 110 )
		Copy:SetWide(SecondPanel:GetWide() / 2.2 - 2.2)
		Copy:SetTall( 30 )
		Copy.DoClick = function()
			SetClipboardText("https://github.com/bouletmarc/ACF_CustomMod/trunk")
		end
		--Set Help Button
		local Help = SecondPanel:Add("DButton")
		Help:SetText("Help me with ACF")
		Help:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Help:SetPos( 45, 190 )
		Help:SetWide(SecondPanel:GetWide() / 1.2 - 1.2)
		Help:SetTall( 40 )
		Help.DoClick = function()
			RunConsoleCommand("acf_help1_open")
			MainPanel:Close()
		end
	
		--Set Owner
		local Text3 = SecondPanel:Add("DLabel")
		Text3:SetText("Made by Bouletmarc\n      (B0ul3Tm@rc)")
		Text3:SetTextColor(Color(0,255,0,255))
		Text3:SetPos(85,320)
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