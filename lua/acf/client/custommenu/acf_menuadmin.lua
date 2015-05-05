--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu( )
	--Set frame
	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(360, 420)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(500)
	MainPanel:SetMinHeight(500)
	--Set options
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("ACF Admin's Menu by Bouletmarc")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Menu Text
	MainText = MainPanel:Add("DLabel")
	MainText:SetText("Change ACF Limits or Customs Limits")
	MainText:SetTextColor(Color(0,255,0,255))
	MainText:SetPos(80,18)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	--Add left panel
	local LeftPanel = MainPanel:Add("DPanel")
	LeftPanel:DockMargin(4, 4, 4, 4)
	LeftPanel:Dock(LEFT)
	LeftPanel:SetSize(220, 420)
	LeftPanel:SetDrawBackground(true)
	--Add right panel
	local RightPanel = MainPanel:Add("DPanel")
	RightPanel:DockMargin(4, 4, 4, 4)
	RightPanel:Dock(RIGHT)
	RightPanel:SetSize(120, 400)
	RightPanel:SetDrawBackground(true)
	--------------------------------------
	--	Initialize Panels
	--------------------------------------
		if LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() then
			--Top Text's
			DescText = LeftPanel:Add("DLabel")
			DescText:SetPos(90,10)
			DescText:SetFont( "DefaultBold" )
			DescText:SetText("Descriptions")
			DescText:SetTextColor(Color(0,150,0,255))
			DescText:SizeToContents()
			
			SettingText = RightPanel:Add("DLabel")
			SettingText:SetPos(30,10)
			SettingText:SetFont( "DefaultBold" )
			SettingText:SetText("Settings")
			SettingText:SetTextColor(Color(0,150,0,255))
			SettingText:SizeToContents()
			--Set All Texts Left Side
			local txt = ""
			txt = txt .."ACF Custom Mod Master Switch\n\n\n"
			txt = txt .."Set the ACF_Guns Limits\n\n\n"
			txt = txt .."Set the ACF_Ammo Limits\n\n\n"
			txt = txt .."Set the ACF Engine/Gearbox/fuel Limits\n\n\n"
			txt = txt .."Set the ACF Engine Extras Limits\n\n\n"
			txt = txt .."Set the ACF Engine Maker Limits\n\n\n"
			
			AllTexts = LeftPanel:Add("DLabel")
			AllTexts:SetPos(10,40)
			AllTexts:SetText(txt)
			AllTexts:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			AllTexts:SizeToContents()
			--Customs Mod Switch
			local CustomSwitch = GetConVarNumber("sbox_max_acf_modding")
			CustomButton = RightPanel:Add("DButton")
			CustomButton:SetPos(10,30)
			CustomButton:SetWide(100)
			CustomButton:SetTall(30)
			CustomButton.DoClick = function()
				if CustomSwitch == 1 then
					CustomSwitch = 0
					RunConsoleCommand( "sbox_max_acf_modding", 0)
					CustomButton:SetText("Custom Mod OFF")
					CustomButton:SetTextColor(Color(200,0,0,255))
				elseif CustomSwitch == 0 then
					CustomSwitch = 1
					RunConsoleCommand( "sbox_max_acf_modding", 1)
					CustomButton:SetText("Custom Mod ON")
					CustomButton:SetTextColor(Color(0,200,0,255))
				end
			end
			if CustomSwitch == 1 then
				CustomButton:SetText("Custom Mod ON")
				CustomButton:SetTextColor(Color(0,200,0,255))
			else
				CustomButton:SetText("Custom Mod OFF")
				CustomButton:SetTextColor(Color(200,0,0,255))
			end
			--Acf Gun Limit
			local GunsLimits = GetConVarNumber("sbox_max_acf_gun")
			GunsEntry = RightPanel:Add( "DTextEntry" )
			GunsEntry:SetText( GunsLimits )
			GunsEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			GunsEntry:SetPos( 10, 70 )
			GunsEntry:SetWide( 80 )
			GunsEntry.OnTextChanged = function( )
				RunConsoleCommand( "sbox_max_acf_gun", GunsEntry:GetValue())
			end
			--Acf Ammo Limit
			local AmmoLimits = GetConVarNumber("sbox_max_acf_ammo")
			AmmoEntry = RightPanel:Add( "DTextEntry" )
			AmmoEntry:SetText( AmmoLimits )
			AmmoEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			AmmoEntry:SetPos( 10, 110 )
			AmmoEntry:SetWide( 80 )
			AmmoEntry.OnTextChanged = function( )
				RunConsoleCommand( "sbox_max_acf_ammo", AmmoEntry:GetValue() )
			end
			--Acf Misc Limit
			local MiscLimits = GetConVarNumber("sbox_max_acf_misc")
			MiscEntry = RightPanel:Add( "DTextEntry" )
			MiscEntry:SetText( MiscLimits )
			MiscEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			MiscEntry:SetPos( 10, 150 )
			MiscEntry:SetWide( 80 )
			MiscEntry.OnTextChanged = function( )
				RunConsoleCommand( "sbox_max_acf_misc", MiscEntry:GetValue() )
			end
			--Acf Extras Limit
			local ExtrasLimits = GetConVarNumber("sbox_max_acf_extra")
			ExtrasEntry = RightPanel:Add( "DTextEntry" )
			ExtrasEntry:SetText( ExtrasLimits )
			ExtrasEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			ExtrasEntry:SetPos( 10, 190 )
			ExtrasEntry:SetWide( 80 )
			ExtrasEntry.OnTextChanged = function( )
				RunConsoleCommand( "sbox_max_acf_extra", ExtrasEntry:GetValue() )
			end
			--Acf Engine Maker Limit
			local MakerLimits = GetConVarNumber("sbox_max_acf_maker")
			MakerEntry = RightPanel:Add( "DTextEntry" )
			MakerEntry:SetText( MakerLimits )
			MakerEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			MakerEntry:SetPos( 10, 230 )
			MakerEntry:SetWide( 80 )
			MakerEntry.OnTextChanged = function( )
				RunConsoleCommand( "sbox_max_acf_maker", MakerEntry:GetValue() )
			end
		else
			DescText = LeftPanel:Add("DLabel")
			DescText:SetPos(50,70)
			DescText:SetFont( "DefaultBold" )
			DescText:SetText("YOU ARE NOT\n   ALLOWED\n TO BE HERE!\n\n\n\n\n\nPLEASE LEAVE!")
			DescText:SetTextColor(Color(200,0,0,255))
			DescText:SizeToContents()
		end
		
		Close = LeftPanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(255,0,0,255))
		Close:SetPos(20,300)
		Close:SetWide(100)
		Close:SetTall(60)
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
concommand.Add("acf_admin_open", OpenMenu)