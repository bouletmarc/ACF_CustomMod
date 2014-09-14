
--loading colors
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

function PANEL:Init( )
	--###########################################
	--Check If the Client Saw the Whats New
	if file.Exists("acf/revision.txt", "DATA") then
		local RevisionFile = file.Read("acf/revision.txt", "DATA")
		local RevisionTable = {}
		for w in string.gmatch(RevisionFile, "([^,]+)") do
			table.insert(RevisionTable, w)
		end
		local RevisionNumber = tonumber(RevisionTable[1])
		if RevisionNumber != ACFCUSTOM.Version2 then
			file.Write("acf/revision.txt", tostring(ACFCUSTOM.Version2)..","..tostring(ACFCUSTOM.VersionCustom))
			RunConsoleCommand("acf_whatsnew_browser_open")
		end
	else
		file.CreateDir("acf")
		file.Write("acf/revision.txt", tostring(ACFCUSTOM.Version2)..","..tostring(ACFCUSTOM.VersionCustom))
		RunConsoleCommand("acf_whatsnew_browser_open")
	end
	--###########################################
	acfmenupanelcustom = self.Panel
	// height
	self:SetTall( surface.ScreenHeight() - 120 )
	//Weapon Select	
	self.WeaponSelect = vgui.Create( "DTree", self )
	self.WeaponData = ACFCUSTOM.Weapons
	
	local WeaponDisplay = list.Get("ACFCUSTOMEnts")
	self.WeaponDisplay = {}
	for ID,Table in pairs(WeaponDisplay) do
		self.WeaponDisplay[ID] = {}
		for EntID,Data in pairs(Table) do
			table.insert(self.WeaponDisplay[ID], Data)
		end
		
		if ID != "Guns" then
			table.sort(self.WeaponDisplay[ID], function(a,b) return a.id < b.id end )
		end
		
	end
	--Home Node
	local HomeNode = self.WeaponSelect:AddNode( "Home menu" )
	HomeNode.mytable = {}
		HomeNode.mytable.guicreate = (function( Panel, Table ) ACFHomeCustomGUICreate( Table ) end or nil)
		HomeNode.mytable.guiupdate = (function( Panel, Table ) ACFHomeCustomGUIUpdate( Table ) end or nil)
	function HomeNode:DoClick()
		acfmenupanelcustom:UpdateDisplay(self.mytable)
	end
	HomeNode.Icon:SetImage( "icon16/newspaper.png" )
	
	--Get Convars limits
	local Makerlimit = GetConVarNumber("sbox_max_acf_maker")
	local Extralimit = GetConVarNumber("sbox_max_acf_extra")
	--Set Pages
	local Mobility = self.WeaponSelect:AddNode( "Mobility List" )
	local Engines = Mobility:AddNode( "Engines" )
	local CustomGB = Mobility:AddNode( "Custom Gearboxes" )
	--###################
	if Makerlimit > 0 then MakerNode = Mobility:AddNode( "Engines Maker" ) end
	if Extralimit > 0 then ExtraNode = Mobility:AddNode( "Engines Extras" ) end
	--###################
	local EngineSubcats = {}
	for _, MobilityTable in pairs(self.WeaponDisplay["MobilityCustom"]) do
		NodeAdd = Mobility
		if( MobilityTable.ent == "acf_engine_custom" ) then
			NodeAdd = Engines
		elseif ( MobilityTable.ent == "acf_gearboxauto" or MobilityTable.ent == "acf_gearboxcvt" or MobilityTable.ent == "acf_gearboxair" ) then
			NodeAdd = CustomGB
		elseif( MobilityTable.ent == "acf_enginemaker") then
			if Makerlimit > 0 then NodeAdd = MakerNode end
		elseif ( MobilityTable.ent == "acf_turbo" or MobilityTable.ent == "acf_supercharger" or MobilityTable.ent == "acf_chips" or MobilityTable.ent == "acf_nos" or MobilityTable.ent == "acf_rads") then
			if Extralimit > 0 then NodeAdd = ExtraNode end
		end
		if(MobilityTable.category) then
			if(!EngineSubcats[MobilityTable.category]) then
				EngineSubcats[MobilityTable.category] = NodeAdd:AddNode( MobilityTable.category )
			end
		end
	end
	
	for MobilityID,MobilityTable in pairs(self.WeaponDisplay["MobilityCustom"]) do
		
		local NodeAdd = Mobility
		if MobilityTable.ent == "acf_engine_custom" then
			NodeAdd = Engines
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_gearboxauto" or MobilityTable.ent == "acf_gearboxcvt" or MobilityTable.ent == "acf_gearboxair" then
			NodeAdd = CustomGB
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_enginemaker" then
			if Makerlimit > 0 then
				NodeAdd = MakerNode
				if(MobilityTable.category) then
					NodeAdd = EngineSubcats[MobilityTable.category]
				end
			end
		elseif MobilityTable.ent == "acf_turbo" or MobilityTable.ent == "acf_supercharger" or MobilityTable.ent == "acf_chips" or MobilityTable.ent == "acf_nos" or MobilityTable.ent == "acf_rads" then
			if Extralimit > 0 then
				NodeAdd = ExtraNode
				if(MobilityTable.category) then
					NodeAdd = EngineSubcats[MobilityTable.category]
				end
			end
		end
		local EndNode = NodeAdd:AddNode( MobilityTable.name or "No Name" )
		EndNode.mytable = MobilityTable
		function EndNode:DoClick()
			RunConsoleCommand( "acfcustom_type", self.mytable.type )
			acfmenupanelcustom:UpdateDisplay( self.mytable )
		end
		EndNode.Icon:SetImage( "icon16/newspaper.png" )

	end
end
/*------------------------------------
	Think
------------------------------------*/
function PANEL:Think( )
end

function PANEL:UpdateDisplay( Table )
	RunConsoleCommand( "acfcustom_id", Table.id or 0 )
	--If a previous display exists, erase it
	if ( acfmenupanelcustom.CustomDisplay ) then
		acfmenupanelcustom.CustomDisplay:Clear(true)
		acfmenupanelcustom.CustomDisplay = nil
		acfmenupanelcustom.CData = nil
	end
	--Create the space to display the custom data
	acfmenupanelcustom.CustomDisplay = vgui.Create( "DPanelList", acfmenupanelcustom )	
		acfmenupanelcustom.CustomDisplay:SetSpacing( 10 )
		acfmenupanelcustom.CustomDisplay:EnableHorizontal( false ) 
		acfmenupanelcustom.CustomDisplay:EnableVerticalScrollbar( false ) 
		acfmenupanelcustom.CustomDisplay:SetSize( acfmenupanelcustom:GetWide(), acfmenupanelcustom:GetTall() )
	if not acfmenupanelcustom["CData"] then
		--Create a table for the display to store data
		acfmenupanelcustom["CData"] = {}	
	end
	acfmenupanelcustom.CreateAttribs = Table.guicreate
	acfmenupanelcustom.UpdateAttribs = Table.guiupdate
	acfmenupanelcustom:CreateAttribs( Table )
	
	acfmenupanelcustom:PerformLayout()
end

function PANEL:CreateAttribs( Table )
	--You overwrite this with your own function, defined in the ammo definition file, so each ammotype creates it's own menu
end

function PANEL:UpdateAttribs( Table )
	--You overwrite this with your own function, defined in the ammo definition file, so each ammotype creates it's own menu
end

function PANEL:PerformLayout()
	--Starting positions
	local vspacing = 10
	local ypos = 0
	--Selection Tree panel
	acfmenupanelcustom.WeaponSelect:SetPos( 0, ypos )
	acfmenupanelcustom.WeaponSelect:SetSize( acfmenupanelcustom:GetWide(), 165 )
	ypos = acfmenupanelcustom.WeaponSelect.Y + acfmenupanelcustom.WeaponSelect:GetTall() + vspacing
	
	if acfmenupanelcustom.CustomDisplay then
		--Custom panel
		acfmenupanelcustom.CustomDisplay:SetPos( 0, ypos )
		acfmenupanelcustom.CustomDisplay:SetSize( acfmenupanelcustom:GetWide(), acfmenupanelcustom:GetTall() - acfmenupanelcustom.WeaponSelect:GetTall() - 10 )
		ypos = acfmenupanelcustom.CustomDisplay.Y + acfmenupanelcustom.CustomDisplay:GetTall() + vspacing
	end
end

function ACFHomeCustomGUICreate( Table )

	if not acfmenupanelcustom.CustomDisplay then return end
	
	VersionText2 = vgui.Create( "DLabel" )
	VersionText2:SetText("Custom Version")
	VersionText2:SetTextColor(Color(0,0,50,255))
	VersionText2:SetFont( "DefaultBold" )
	VersionText2:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VersionText2 )
	
	VersionT2 = vgui.Create( "DLabel" )
	VersionT2:SetText("SVN Version: "..ACFCUSTOM.CurrentVersion2.."\nCurrent Version: "..ACFCUSTOM.Version2)
	VersionT2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	VersionT2:SetFont( "DefaultBold" )
	VersionT2:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VersionT2 )
	
	VersionT3 = vgui.Create( "DLabel" )
	local color2
	local versionstring2
	if ACFCUSTOM.Version2 >= ACFCUSTOM.CurrentVersion2 then
		versionstring2 = "Up To Date"
		color2 = Color(0,225,0,255)
	else
		versionstring2 = "Out Of Date"
		color2 = Color(225,0,0,255)
	end
	
	VersionT3:SetText("ACF Custom Is "..versionstring2.."!\n")
	VersionT3:SetColor(color2) 
	VersionT3:SetFont( "DefaultBold" )
	VersionT3:SizeToContents() 
	acfmenupanelcustom.CustomDisplay:AddItem( VersionT3 )
	
	VersionCustomText = vgui.Create( "DLabel" )
	VersionCustomText:SetText("Custom Version: "..ACFCUSTOM.VersionCustom.."\n")
	VersionCustomText:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	VersionCustomText:SetFont( "DefaultBold" )
	VersionCustomText:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VersionCustomText )
	--#################################################
	--Color And Help Menu
	ColorMenu = vgui.Create( "DButton" )
	ColorMenu:SetText("Change ACF Menu Font's color")
	ColorMenu:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	ColorMenu:SetToolTip("Bored of that font color ?\nClic that button to change it !")
	ColorMenu:SetWide(100)
	ColorMenu:SetTall(30)
	ColorMenu.DoClick = function()
		RunConsoleCommand("acf_colormenu_browser_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( ColorMenu )
		
	HelpText1 = vgui.Create( "DButton" )
	HelpText1:SetText("Help")
	HelpText1:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	HelpText1:SetToolTip("Clic here to get Help about ACF\nAbout Wiring, Linking, Options, Installation")
	HelpText1:SetWide(70)
	HelpText1:SetTall(30)
	HelpText1.DoClick = function()
		RunConsoleCommand("acf_help_browser_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( HelpText1 )
	
	WhatCustom = vgui.Create( "DButton" )
	WhatCustom:SetText("Custom Mod Tips")
	WhatCustom:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
	WhatCustom:SetToolTip("Clic here to get Help about ACF\nAbout Wiring, Linking, Options, Installation")
	WhatCustom:SetWide(80)
	WhatCustom:SetTall(30)
	WhatCustom.DoClick = function()
		RunConsoleCommand("acf_customcando_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( WhatCustom )
	
	TextLog= vgui.Create( "DLabel" )
		TextLog:SetText( "Changelog")
		TextLog:SetTextColor(Color(0,0,50,255))
		TextLog:SetFont( "DefaultBold" )
	acfmenupanelcustom.CustomDisplay:AddItem( TextLog )
	--#################
	if acfmenupanelcustom.Changelog then
		acfmenupanelcustom["CData"]["Changelist"] = vgui.Create( "DTree" )
		for Rev,Changes in pairs(acfmenupanelcustom.Changelog) do
			local Node = acfmenupanelcustom["CData"]["Changelist"]:AddNode( "Rev "..Rev )
			Node.mytable = {}
				Node.mytable["rev"] = Rev
			function Node:DoClick()
				acfmenupanelcustom:UpdateAttribs( Node.mytable )
			end
			Node.Icon:SetImage( "icon16/newspaper.png" )
		end	
		acfmenupanelcustom.CData.Changelist:SetSize( acfmenupanelcustom.CustomDisplay:GetWide(), 60 )
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom["CData"]["Changelist"] )
		acfmenupanelcustom.CustomDisplay:PerformLayout()
		acfmenupanelcustom:UpdateAttribs( {rev = table.maxn(acfmenupanelcustom.Changelog)} )
	end
end
	
function ACFHomeCustomGUIUpdate( Table )
	
	TextLog1 = vgui.Create( "DLabel" )
		TextLog1:SetText( "Custom Changlog :")
		TextLog1:SetTextColor(Color(0,0,50,255))
		TextLog1:SetFont( "DefaultBold" )
		TextLog1:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( TextLog1 )
	
	TextLog2 = vgui.Create( "DLabel" )
		TextLog2:SetText( acfmenupanelcustom.Changelog[Table["rev"]])
		TextLog2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		TextLog2:SetFont( "DefaultBold" )
		TextLog2:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( TextLog2 )
	
	local color2
	local versionstring2
	if ACFCUSTOM.Version2 >= ACFCUSTOM.CurrentVersion2 then
		versionstring2 = "Up To Date"
		color2 = Color(0,225,0,255)
	else
		versionstring2 = "Out Of Date"
		color2 = Color(225,0,0,255)
	end
	
	VersionT3:SetText("ACF Custom Is "..versionstring2.."!\n")
	VersionT3:SetColor(color2)
	VersionT3:SizeToContents()
	
	acfmenupanelcustom.CustomDisplay:PerformLayout()
end

function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	acfmenupanelcustom.Changelog = {}
	for Key,String in pairs(Temp) do
		acfmenupanelcustom.Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(acfmenupanelcustom.Changelog,true)
	local Table = {}
		Table.guicreate = (function( Panel, Table ) ACFHomeCustomGUICreate( Table ) end or nil)
		Table.guiupdate = (function( Panel, Table ) ACFHomeCustomGUIUpdate( Table ) end or nil)
	acfmenupanelcustom:UpdateDisplay( Table )
end
http.Fetch("https://raw.github.com/bouletmarc/ACF_CustomMod/master/changelogcustom.txt", ACFChangelogHTTPCallBack, function() end)


function PANEL:CPanelText(Name, Desc)

	if not acfmenupanelcustom["CData"][Name.."_text"] then
		acfmenupanelcustom["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanelcustom["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanelcustom["CData"][Name.."_text"]:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
			acfmenupanelcustom["CData"][Name.."_text"]:SetWrap(true)
			acfmenupanelcustom["CData"][Name.."_text"]:SetAutoStretchVertical( true )
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom["CData"][Name.."_text"] )
	end
	acfmenupanelcustom["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanelcustom["CData"][Name.."_text"]:SetSize( acfmenupanelcustom.CustomDisplay:GetWide(), 10 )
	acfmenupanelcustom["CData"][Name.."_text"]:SizeToContentsY()

end
