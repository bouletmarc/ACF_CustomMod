// Made by Bouletmarc.

local StartBrowserPanel = nil

function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:Center()
	StartBrowserPanel:SetSize(350, 450)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(350)
	StartBrowserPanel:SetMinHeight(450)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("Changelog Checker V8.1")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(330, 430)
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
		CurrentText = ButtonsSidePanel:Add("DLabel")
		CurrentText:SetPos(100,20)
		CurrentText:SetFont( "DefaultBold" )
		CurrentText:SetText("ACF Original Changelog")
		CurrentText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		CurrentText:SizeToContents()
		
		Close = ButtonsSidePanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		Close:SetPos( 20,350 )
		Close:SetWide(80)
		Close:SetTall( 50 )
		Close.DoClick = function()
			StartBrowserPanel:Close()
		end
		
		VersionT = ButtonsSidePanel:Add("DLabel")
		VersionT:SetText("Original SVN Version : "..ACF.CurrentVersion)
		VersionT:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		VersionT:SetFont( "DefaultBold" )
		VersionT:SizeToContents()
		VersionT:SetPos( 120,350 )
		
		VersionT2 = ButtonsSidePanel:Add("DLabel")
		VersionT2:SetText("Custom SVN Run On Version : "..ACF.Version)
		VersionT2:SetFont( "DefaultBold" )
		VersionT2:SizeToContents()
		VersionT2:SetPos( 120,370 )
		
		if ACF.Version >= ACF.CurrentVersion then
			VersionT2:SetTextColor(Color(0,200,0,255))
		else
			VersionT2:SetTextColor(Color(200,0,0,255))
		end
	--#################
	CustomDisplay = ButtonsSidePanel:Add("DPanelList")
	CustomDisplay:SetSpacing( 10 )
	CustomDisplay:EnableHorizontal( false ) 
	CustomDisplay:EnableVerticalScrollbar( true )
	CustomDisplay:SetSize( 300, 250 )
	CustomDisplay:SetPos( 20, 50 )
		
	ButtonsSidePanel:PerformLayout()
	
	if Changelog then
		Changelist = vgui.Create( "DTree" )
		for Rev,Changes in pairs(Changelog) do
			local Node = Changelist:AddNode( "Rev "..Rev )
			Node.mytable = {}
			Node.mytable["rev"] = Rev
			function Node:DoClick() -- On Click
					UpdateSoundBrowser( Node.mytable )
					CustomDisplay:PerformLayout()
			end
			Node.Icon:SetImage( "icon16/newspaper.png" )
			
		end	
		Changelist:SetSize( 60, 100 )
		CustomDisplay:AddItem( Changelist )
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
	if TextLog1 then TextLog1:Remove() end
	if TextLog2 then TextLog2:Remove() end
	--Set Changelog text and End
	TextLog1 = vgui.Create( "DLabel" )
		TextLog1:SetText( "Original Changlog :")
		TextLog1:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		TextLog1:SetFont( "DefaultBold" )
		TextLog1:SizeToContents()
	CustomDisplay:AddItem( TextLog1 )
	
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
function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	Changelog = {}
	for Key,String in pairs(Temp) do
		Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(Changelog,true)
end
http.Fetch("https://raw.github.com/nrlulz/ACF/master/changelog.txt", ACFChangelogHTTPCallBack, function() end)
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

concommand.Add("acf_changelog_browser_open", OpenSartBrowser)