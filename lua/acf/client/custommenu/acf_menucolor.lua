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
	MainPanel:SetSize(300, 450)
	--Set Center
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(290)
	MainPanel:SetMinHeight(440)
	--Set options
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("ACF Font's Color Menu by Bouletmarc")
	MainPanel:SetVisible(false)
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Menu text
	local MainText = MainPanel:Add("DLabel")
	MainText:SetText("Change color of Acf font's in the menu")
	MainText:SetTextColor(Color(0,255,0,255))
	MainText:SetPos(45,35)
	MainText:SetFont( "DefaultBold" )
	MainText:SizeToContents()
	--Add 2nd panel
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(4, 4, 4, 4)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(280, 430)
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		if not file.Exists("acf/menucolor.txt", "DATA") then
			SaveFunc()
		end
		
		--Set color text
		local ColorText = SecondPanel:Add("DLabel")
		ColorText:SetPos(160,260)
		ColorText:SetFont( "DefaultBold" )
		ColorText:SetText("Current Color :\n  ("..ACFC.R..","..ACFC.G..","..ACFC.B..")")
		ColorText:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		ColorText:SizeToContents()
		--Set help text
		local Help = SecondPanel:Add("DLabel")
		Help:SetPos(140,320)
		Help:SetFont( "DefaultBold" )
		Help:SetText("             To Reload\n       ACF Menu Colors\n       Clic on ACF Home\nat the top of ACF Menu")
		Help:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Help:SizeToContents()
		--Set save button
		local Save  = SecondPanel:Add("DButton")
		Save:SetText("Save")
		Save:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Save:SetPos(20,260)
		Save:SetWide(100)
		Save:SetTall(60)
		Save.DoClick = function()
			SaveFunc()
		end
		--Set close button
		local Close  = SecondPanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(255,0,0,255))
		Close:SetPos(20,340)
		Close:SetWide(100)
		Close:SetTall(60)
		Close.DoClick = function()
			MainPanel:Close()
		end
		--Create color mixer panel
		local ColorPanel = SecondPanel:Add("DPanel")
		ColorPanel:SetSize(257,190)
		ColorPanel:SetPos(10, 30)
		ColorPanel:SetDrawBackground(false)
		--Color mixer
		local Mixer = ColorPanel:Add("DColorMixer")
		Mixer:Dock(FILL)
		Mixer:SetPalette(false)
		Mixer:SetAlphaBar(false)
		Mixer:SetWangs(true)
		Mixer:SetColor(Color(ACFC.R,ACFC.G,ACFC.B))
		Mixer.ValueChanged = function()
			local colorRGB = Mixer:GetColor()
			local r,g,b,a = colorRGB.r, colorRGB.g, colorRGB.b, colorRGB.a
			local ColorTable = {tonumber(r), tonumber(g), tonumber(b)}
			
			for k, v in pairs(ColorTable) do
				if v > 255 then
					k = 255
				else
					k = tonumber(v)
				end
			end
			
			ACFC.R = tonumber(ColorTable[1])
			ACFC.G = tonumber(ColorTable[2])
			ACFC.B = tonumber(ColorTable[3])
			
			ColorText:SetText("Current Color :\n  ("..ACFC.R..","..ACFC.G..","..ACFC.B..")")
			ColorText:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			Help:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			Save:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		end
	
	MainPanel:InvalidateLayout(true)
	
end
--------------------------------------
--	Saving
--------------------------------------
function SaveFunc()
	local txt = ACFC.R..","..ACFC.G..","..ACFC.B
	file.CreateDir("acf")
	file.Write("acf/menucolor.txt", txt)
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
concommand.Add("acf_colormenu_open", OpenMenu)