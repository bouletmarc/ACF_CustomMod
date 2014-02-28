// Made by Bouletmarc.

local StartBrowserPanel = nil

local function CreateSoundBrowser( )

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetSize(300, 450)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(290)
	StartBrowserPanel:SetMinHeight(440)
	
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("ACF Font's Color Menu by Bouletmarc")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	MainText = StartBrowserPanel:Add("DLabel")
	MainText:SetText("Change color of Acf font's in the menu")
	MainText:SetTextColor(Color(0,255,0,255))
	MainText:SetPos(45,35)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(280, 430)
	ButtonsSidePanel:SetDrawBackground(false)
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
			RunConsoleCommand( "acfmenu_red", Redcolor )
			RunConsoleCommand( "acfmenu_green", Greencolor )
			RunConsoleCommand( "acfmenu_blue", Bluecolor )
			SaveFunc()
		end
		--###########################################
		--create menu text
		CurrentText = ButtonsSidePanel:Add("DLabel")
		CurrentText:SetPos(160,260)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("Current Color :\n  ("..Redcolor..","..Greencolor..","..Bluecolor..")")
		CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CurrentText:SizeToContents()
		
		HelpText = ButtonsSidePanel:Add("DLabel")
		HelpText:SetPos(140,320)
		HelpText:SetFont( "DefaultBold" )
		HelpText:SetText("             To Reload\n       ACF Menu Colors\n       Clic on ACF Home\nat the top of ACF Menu")
		HelpText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		HelpText:SizeToContents()
		
		Save = ButtonsSidePanel:Add("DButton")
		Save:SetText("Save")
		Save:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Save:SetPos(20,260)
		Save:SetWide(100)
		Save:SetTall(60)
		Save.DoClick = function()
			SaveFunc()
		end
		
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(255,0,0,255))
		Close:SetPos(20,340)
		Close:SetWide(100)
		Close:SetTall(60)
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
		--#########################################################################################
		--Color Mixer
		ColorPanel = ButtonsSidePanel:Add("DPanel")
		ColorPanel:SetSize( 257,190 ) --good size for example
		ColorPanel:SetPos( 10, 30 )
		ColorPanel:SetDrawBackground(false)
		
		Mixer = ColorPanel:Add("DColorMixer")
		Mixer:Dock( FILL )
		Mixer:SetPalette( false )
		Mixer:SetAlphaBar( false )
		Mixer:SetWangs( true )
		Mixer:SetColor( Color( Redcolor,Greencolor,Bluecolor ) )
		Mixer.ValueChanged = function()
			local colorRGB = Mixer:GetColor()
			local r,g,b,a = colorRGB.r, colorRGB.g, colorRGB.b, colorRGB.a
			Redcolorcheck = tonumber(r)
			Greencolorcheck = tonumber(g)
			Bluecolorcheck = tonumber(b)
			
			if Redcolorcheck > 255 then
				Redcolor = 255
			else
				Redcolor = tonumber(r)
			end
			
			if Greencolorcheck > 255 then
				Greencolor = 255
			else
				Greencolor = tonumber(g)
			end
			
			if Bluecolorcheck > 255 then
				Bluecolor = 255
			else
				Bluecolor = tonumber(b)
			end
			RunConsoleCommand( "acfmenu_red", Redcolor )
			RunConsoleCommand( "acfmenu_green", Greencolor )
			RunConsoleCommand( "acfmenu_blue", Bluecolor )
			CurrentText:SetText("Current Color :\n  ("..Redcolor..","..Greencolor..","..Bluecolor..")")
			CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
			HelpText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
			Save:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		end
		--#########################################################################################	

	StartBrowserPanel.OnClose = function()
	end

	StartBrowserPanel:InvalidateLayout(true)
	
end

--Saving
function SaveFunc()
	local RedcolorT = math.Round(GetConVarNumber("acfmenu_red"))
	local GreencolorT = math.Round(GetConVarNumber("acfmenu_green"))
	local BluecolorT = math.Round(GetConVarNumber("acfmenu_blue"))
	local txt = RedcolorT..","..GreencolorT..","..BluecolorT
	file.CreateDir("acf")
	file.Write("acf/menucolor.txt", txt)
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

concommand.Add("acf_colormenu_browser_open", OpenSartBrowser)