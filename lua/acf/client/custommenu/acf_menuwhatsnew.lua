// Made by Bouletmarc.

local StartBrowserPanel = nil

local Changelog = {}

local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetSize(350, 450)
	--Set Center
	StartBrowserPanel:SetPos(((ScrW()/2)-(StartBrowserPanel:GetWide()/2))+ScrW()/4,(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(350)
	StartBrowserPanel:SetMinHeight(450)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("Whats New Menu V8.1")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(330, 406)
	ButtonsSidePanel:SetDrawBackground(true)
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
			RunConsoleCommand( "acfcustom_red", Redcolor )
			RunConsoleCommand( "acfcustom_green", Greencolor )
			RunConsoleCommand( "acfcustom_blue", Bluecolor )
			SaveFunc()
		end
		--###########################################
		CurrentText = ButtonsSidePanel:Add("DLabel")
		CurrentText:SetPos(70,20)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("Whats New in ACF Custom Rev : "..ACFCUSTOM.Version2)
		CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CurrentText:SizeToContents()
		
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos( 120,340 )
		Close:SetWide(80)
		Close:SetTall( 50 )
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
	--#################
	CustomDisplay = ButtonsSidePanel:Add("DPanelList")
	CustomDisplay:SetSpacing( 10 )
	CustomDisplay:EnableHorizontal( false ) 
	CustomDisplay:EnableVerticalScrollbar( true )
	CustomDisplay:SetSize( 300, 240 )
	CustomDisplay:SetPos( 20, 50 )
		
	ButtonsSidePanel:PerformLayout()
	
	if Changelog then
		CustomDisplay:PerformLayout()
		UpdateSoundBrowser( {rev = table.maxn(Changelog)} )
	end
	--###############
		
	StartBrowserPanel.OnClose = function() end

	StartBrowserPanel:InvalidateLayout(false)
	
end
--###########
function UpdateSoundBrowser( Table )
	--#######
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
	--Clear
	if TextLog2 then TextLog2:Remove() end
	--Set Changelog text
	TextLog2 = vgui.Create( "DLabel" )
		TextLog2:SetText( Changelog[Table["rev"]])
		TextLog2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		TextLog2:SetFont( "DefaultBold" )
		TextLog2:SetWrap(true)
		TextLog2:SetAutoStretchVertical(true)
	CustomDisplay:AddItem( TextLog2 )
	
	CustomDisplay:PerformLayout()
end
--###########
local function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	Changelog = {}
	for Key,String in pairs(Temp) do
		Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(Changelog,true)
end
http.Fetch("https://raw.github.com/bouletmarc/ACF_CustomMod/master/changelogcustom.txt", ACFChangelogHTTPCallBack, function() end)
--##########
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

concommand.Add("acf_whatsnew_browser_open", OpenSartBrowser)