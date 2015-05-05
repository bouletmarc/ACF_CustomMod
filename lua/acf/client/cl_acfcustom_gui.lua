--------------------------------------
--	Initialize
--------------------------------------
function PANEL:Init( )
	--Check If the Client Saw Whats New
	if file.Exists("acf/revision.txt", "DATA") then
		local RevisionFile = file.Read("acf/revision.txt", "DATA")
		local RevisionTable = {}
		for w in string.gmatch(RevisionFile, "([^,]+)") do
			table.insert(RevisionTable, w)
		end
		local RevisionNumber = tonumber(RevisionTable[1])
		if RevisionNumber != ACFCUSTOM.Version then
			file.Write("acf/revision.txt", tostring(ACFCUSTOM.Version)..","..tostring(ACFCUSTOM.VersionCustom))
			RunConsoleCommand("acf_whatsnew_open")
		end
	else
		file.CreateDir("acf")
		file.Write("acf/revision.txt", tostring(ACFCUSTOM.Version)..","..tostring(ACFCUSTOM.VersionCustom))
		RunConsoleCommand("acf_whatsnew_open")
	end
	--Start Menu coding
	acfmenupanelcustom = self.Panel
	
	self:SetTall( surface.ScreenHeight() - 120 )
	
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
	--Set Nodes
	local Mobility = self.WeaponSelect:AddNode( "Mobility List" )
	local Engines = Mobility:AddNode( "Engines" )
	local CustomGB = Mobility:AddNode( "Custom Gearboxes" )
	--Set Nodes with limits
	if Makerlimit > 0 then MakerNode = Mobility:AddNode( "Engines Maker" ) end
	if Extralimit > 0 then ExtraNode = Mobility:AddNode( "Engines Extras" ) end
	--Set Nodes Final
	local EngineSubcats = {}
	for _, MobilityTable in pairs(self.WeaponDisplay["MobilityCustom"]) do
		local NodeAdd = Mobility
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
--------------------------------------
--	Create Custom Menu
--------------------------------------
function ACFHomeCustomGUICreate( Table )
	if not acfmenupanelcustom.CustomDisplay then return end
	
	--Set local vars
	local VT, VT2, VT4 = vgui.Create( "DLabel" ), vgui.Create( "DLabel" ), vgui.Create( "DLabel" )
	local ColorMenu, HelpMenu, CustomTips = vgui.Create( "DButton" ), vgui.Create( "DButton" ), vgui.Create( "DButton" )
	local Log = vgui.Create( "DLabel" )
	--Set vars
	VT3 = vgui.Create( "DLabel" )
	
	--Version text1
	VT:SetText("Custom Version")
	VT:SetTextColor(Color(0,0,50,255))
	VT:SetFont( "DefaultBold" )
	VT:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VT )
	
	--Version text2
	VT2:SetText("SVN Version: "..ACFCUSTOM.CurrentVersion.."\nCurrent Version: "..ACFCUSTOM.Version)
	VT2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	VT2:SetFont( "DefaultBold" )
	VT2:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VT2 )
	
	--Version text3
	local color
	local versionstring
	if ACFCUSTOM.Version >= ACFCUSTOM.CurrentVersion then
		versionstring = "Up To Date"
		color = Color(0,225,0,255)
	else
		versionstring = "Out Of Date"
		color = Color(225,0,0,255)
	end
	
	VT3:SetText("ACF Custom Is "..versionstring.."!\n")
	VT3:SetColor(color) 
	VT3:SetFont( "DefaultBold" )
	VT3:SizeToContents() 
	acfmenupanelcustom.CustomDisplay:AddItem( VT3 )
	
	--Version text4
	VT4 = vgui.Create( "DLabel" )
	VT4:SetText("Custom Version: "..ACFCUSTOM.VersionCustom.."\n")
	VT4:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	VT4:SetFont( "DefaultBold" )
	VT4:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( VT4 )
	
	--Color Menu Button
	ColorMenu:SetText("Change ACF Menu Font's color")
	ColorMenu:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	ColorMenu:SetToolTip("Bored of that font color ?\nClic that button to change it !")
	ColorMenu:SetWide(100)
	ColorMenu:SetTall(30)
	ColorMenu.DoClick = function()
		RunConsoleCommand("acf_colormenu_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( ColorMenu )
	
	--Admin Menu
	if LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin() then
		local AdminMenu = vgui.Create( "DButton" )
		AdminMenu:SetText("Admin Menu")
		AdminMenu:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		AdminMenu:SetToolTip("Clic here to get Help about ACF\nAbout Wiring, Linking, Options, Installation")
		AdminMenu:SetWide(75)
		AdminMenu:SetTall(30)
		AdminMenu.DoClick = function()
			RunConsoleCommand("acf_admin_open")
		end
		acfmenupanelcustom.CustomDisplay:AddItem( AdminMenu )
	end
	
	--Help Menu Button
	HelpMenu:SetText("Help")
	HelpMenu:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	HelpMenu:SetToolTip("Clic here to get Help about ACF\nAbout Wiring, Linking, Options, Installation")
	HelpMenu:SetWide(70)
	HelpMenu:SetTall(30)
	HelpMenu.DoClick = function()
		RunConsoleCommand("acf_help_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( HelpMenu )
	
	--Custom Mod Tips Button
	CustomTips:SetText("Custom Mod Tips")
	CustomTips:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	CustomTips:SetToolTip("Clic here to get Help about ACF\nAbout Wiring, Linking, Options, Installation")
	CustomTips:SetWide(80)
	CustomTips:SetTall(30)
	CustomTips.DoClick = function()
		RunConsoleCommand("acf_tips_open")
	end
	acfmenupanelcustom.CustomDisplay:AddItem( CustomTips )
	
	--Changelog Text
	Log:SetText( "Changelog")
	Log:SetTextColor(Color(0,0,50,255))
	Log:SetFont( "DefaultBold" )
	acfmenupanelcustom.CustomDisplay:AddItem( Log )
	
	--Changelog Tree
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
	--Settings vars
	local Log, Log2 = vgui.Create( "DLabel" ), vgui.Create( "DLabel" )
	
	--Custom Changelog Text
	Log:SetText( "Custom Changlog :")
	Log:SetTextColor(Color(0,0,50,255))
	Log:SetFont( "DefaultBold" )
	Log:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( Log )
	
	--Custom changelog revision
	Log2:SetText( acfmenupanelcustom.Changelog[Table["rev"]])
	Log2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	Log2:SetFont( "DefaultBold" )
	Log2:SizeToContents()
	acfmenupanelcustom.CustomDisplay:AddItem( Log2 )
	
	local color
	local versionstring
	if ACFCUSTOM.Version >= ACFCUSTOM.CurrentVersion then
		versionstring = "Up To Date"
		color = Color(0,225,0,255)
	else
		versionstring = "Out Of Date"
		color = Color(225,0,0,255)
	end
	
	VT3:SetText("ACF Custom Is "..versionstring.."!\n")
	VT3:SetColor(color)
	VT3:SizeToContents()
	
	acfmenupanelcustom.CustomDisplay:PerformLayout()
end
--------------------------------------
--	Changelog calling
--------------------------------------
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
--------------------------------------
--	Set Menu Text
--------------------------------------
function PANEL:CPanelText(Name, Desc)
	if not acfmenupanelcustom["CData"][Name.."_text"] then
		acfmenupanelcustom["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanelcustom["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanelcustom["CData"][Name.."_text"]:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			acfmenupanelcustom["CData"][Name.."_text"]:SetWrap(true)
			acfmenupanelcustom["CData"][Name.."_text"]:SetAutoStretchVertical( true )
		acfmenupanelcustom.CustomDisplay:AddItem( acfmenupanelcustom["CData"][Name.."_text"] )
	end
	
	acfmenupanelcustom["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanelcustom["CData"][Name.."_text"]:SetSize( acfmenupanelcustom.CustomDisplay:GetWide(), 10 )
	acfmenupanelcustom["CData"][Name.."_text"]:SizeToContentsY()
end