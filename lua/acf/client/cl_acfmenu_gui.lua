
function PANEL:Init( )

	acfmenupanel = self.Panel
	
	// height
	
	
	self:SetTall( surface.ScreenHeight() - 120 )
	
	//Weapon Select	
	
	self.WeaponSelect = vgui.Create( "DTree", self )

	self.WeaponData = ACF.Weapons
	
	local Classes = list.Get("ACFClasses")
	self.Classes = {}
	for ID,Table in pairs(Classes) do
		self.Classes[ID] = {}
		for ClassID,Class in pairs(Table) do
			Class.id = ClassID
			table.insert(self.Classes[ID], Class)
		end
		table.sort(self.Classes[ID], function(a,b) return a.id < b.id end )
	end
	
	local WeaponDisplay = list.Get("ACFEnts")
	self.WeaponDisplay = {}
	for ID,Table in pairs(WeaponDisplay) do
		self.WeaponDisplay[ID] = {}
		for EntID,Data in pairs(Table) do
			table.insert(self.WeaponDisplay[ID], Data)
		end
		
		if ID == "Guns" then
			table.sort(self.WeaponDisplay[ID], function(a,b) if a.gunclass == b.gunclass then return a.caliber < b.caliber else return a.gunclass < b.gunclass end end)
		else
			table.sort(self.WeaponDisplay[ID], function(a,b) return a.id < b.id end )
		end
		
	end
	
	local HomeNode = self.WeaponSelect:AddNode( "ACF Home" )
	HomeNode.mytable = {}
		HomeNode.mytable.guicreate = (function( Panel, Table ) ACFHomeGUICreate( Table ) end or nil)
		HomeNode.mytable.guiupdate = (function( Panel, Table ) ACFHomeGUIUpdate( Table ) end or nil)
	function HomeNode:DoClick()
		acfmenupanel:UpdateDisplay(self.mytable)
	end
	HomeNode.Icon:SetImage( "gui/silkicons/star" )
	
	local RoundAttribs = list.Get("ACFRoundTypes")
	self.RoundAttribs = {}
	for ID,Table in pairs(RoundAttribs) do
		Table.id = ID
		table.insert(self.RoundAttribs, Table)
	end
	table.sort(self.RoundAttribs, function(a,b) return a.id < b.id end )
	
	local Guns = self.WeaponSelect:AddNode( "Guns" )
	for ClassID,Class in pairs(self.Classes["GunClass"]) do
	
		local SubNode = Guns:AddNode( Class.name or "No Name" )
		
		for Type, Ent in pairs(self.WeaponDisplay["Guns"]) do	
			if Ent.gunclass == Class.id then
				local EndNode = SubNode:AddNode( Ent.name or "No Name" )
				EndNode.mytable = Ent
				function EndNode:DoClick()
					RunConsoleCommand( "acfmenu_type", self.mytable.type )
					acfmenupanel:UpdateDisplay( self.mytable )
				end
				EndNode.Icon:SetImage( "gui/silkicons/newspaper" )
			end
		end
		
	end

	local Ammo = self.WeaponSelect:AddNode( "Ammo" )
	for AmmoID,AmmoTable in pairs(self.RoundAttribs) do
		
		local EndNode = Ammo:AddNode( AmmoTable.name or "No Name" )
		EndNode.mytable = AmmoTable
		function EndNode:DoClick()
			RunConsoleCommand( "acfmenu_type", self.mytable.type )
			acfmenupanel:UpdateDisplay( self.mytable )
		end
		EndNode.Icon:SetImage( "gui/silkicons/newspaper" )
		
	end
	
	local Mobility = self.WeaponSelect:AddNode( "Mobility" )
	local Engines = Mobility:AddNode( "Engines" )
	local Gearboxes = Mobility:AddNode( "Gearboxes" )
	local FuelTanks = Mobility:AddNode( "Fuel Tanks" )
	--###################
	local EnginesMaker = Mobility:AddNode( "Engines Maker Menu" )
	local EnginesLittle = Mobility:AddNode( "Customizable Little Engines" )
	local EnginesFat = Mobility:AddNode( "Customizable Fat Engines" )
	local Engines2 = Mobility:AddNode( "Engines Custom" )
	local CVT = Mobility:AddNode( "CVT Gearbox" )
	local Automatic = Mobility:AddNode( "Automatic Gearbox" )
	local Chips = Mobility:AddNode( "Chips" )
	local Vtec = Mobility:AddNode( "Chips Vtec" )
	local Nos = Mobility:AddNode( "Nos Bottle" )
	--###################
	local EngineSubcats = {}
	for _, MobilityTable in pairs(self.WeaponDisplay["Mobility"]) do
		NodeAdd = Mobility
		if( MobilityTable.ent == "acf_engine" ) then
			NodeAdd = Engines
		elseif ( MobilityTable.ent == "acf_gearbox" ) then
			NodeAdd = Gearboxes
		elseif ( MobilityTable.ent == "acf_fueltank" ) then
			NodeAdd = FuelTanks
		elseif ( MobilityTable.ent == "acf_engine5" ) then
			NodeAdd = EnginesMaker
		elseif( MobilityTable.ent == "acf_engine2" ) then
			NodeAdd = EnginesLittle
		elseif ( MobilityTable.ent == "acf_engine4" ) then
			NodeAdd = EnginesFat
		elseif ( MobilityTable.ent == "acf_engine3" ) then
			NodeAdd = Engines2
		elseif ( MobilityTable.ent == "acf_gearbox2" ) then
			NodeAdd = CVT
		elseif ( MobilityTable.ent == "acf_gearbox3" ) then
			NodeAdd = Automatic
		elseif ( MobilityTable.ent == "acf_chips" ) then
			NodeAdd = Chips
		elseif ( MobilityTable.ent == "acf_vtec" ) then
			NodeAdd = Vtec
		elseif ( MobilityTable.ent == "acf_nos" ) then
			NodeAdd = Nos
		end
		--###############
		--if((EngineSubcats["misce"] == nil) and (EngineSubcats["miscg"] == nil) ) then
		--	EngineSubcats["misce"] = Engines:AddNode( "Miscellaneous" )
		--	EngineSubcats["miscg"] = Gearboxes:AddNode( "Miscellaneous" )
		--end
		if(MobilityTable.category) then
			if(!EngineSubcats[MobilityTable.category]) then
				EngineSubcats[MobilityTable.category] = NodeAdd:AddNode( MobilityTable.category )
			end
		end
	end
	
	for MobilityID,MobilityTable in pairs(self.WeaponDisplay["Mobility"]) do
		
		local NodeAdd = Mobility
		if MobilityTable.ent == "acf_engine" then
			NodeAdd = Engines
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			--else
			--	NodeAdd = EngineSubcats["misce"]
			end
		elseif MobilityTable.ent == "acf_gearbox" then
			NodeAdd = Gearboxes
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			--else
			--	NodeAdd = EngineSubcats["miscg"]
			end
		elseif MobilityTable.ent == "acf_fueltank" then
			NodeAdd = FuelTanks
			if (MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine5" then
			NodeAdd = EnginesMaker
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine2" then
			NodeAdd = EnginesLittle
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine4" then
			NodeAdd = EnginesFat
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine3" then
			NodeAdd = Engines2
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_gearbox2" then
			NodeAdd = CVT
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_gearbox3" then
			NodeAdd = Automatic
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_chips" then
			NodeAdd = Chips
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_vtec" then
			NodeAdd = Vtec
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_nos" then
			NodeAdd = Nos
			if(MobilityTable.category) then
				NodeAdd = EngineSubcats[MobilityTable.category]
			end
		end
		--###############
		
		local EndNode = NodeAdd:AddNode( MobilityTable.name or "No Name" )
		EndNode.mytable = MobilityTable
		function EndNode:DoClick()
			RunConsoleCommand( "acfmenu_type", self.mytable.type )
			acfmenupanel:UpdateDisplay( self.mytable )
		end
		EndNode.Icon:SetImage( "gui/silkicons/wrench" )

	end
	--#########################################################################################################
	/*	--Creating New menu
	local Mobility2 = self.WeaponSelect:AddNode( "Custom ACF Mod" )		-->menu name
		--Creating SubCategories
	local EnginesMaker = Mobility2:AddNode( "Engines Maker Menu" )
	local EnginesLittle = Mobility2:AddNode( "Customizable Little Engines" )
	local EnginesFat = Mobility2:AddNode( "Customizable Fat Engines" )
	local Engines2 = Mobility2:AddNode( "Engines" )
	local CVT = Mobility2:AddNode( "CVT Gearbox" )
	local Automatic = Mobility2:AddNode( "Automatic Gearbox" )
	local Chips = Mobility2:AddNode( "Chips" )
	local Vtec = Mobility2:AddNode( "Chips Vtec" )
	local Nos = Mobility2:AddNode( "Nos Bottle" )
	
	local Engine2Subcats = {}
	for _, MobilityTable in pairs(self.WeaponDisplay["Mobility"]) do
		NodeAdd = Mobility2
		if ( MobilityTable.ent == "acf_engine5" ) then
			NodeAdd = EnginesMaker
		elseif( MobilityTable.ent == "acf_engine2" ) then
			NodeAdd = EnginesLittle
		elseif ( MobilityTable.ent == "acf_engine4" ) then
			NodeAdd = EnginesFat
		elseif ( MobilityTable.ent == "acf_engine3" ) then
			NodeAdd = Engines2
		elseif ( MobilityTable.ent == "acf_gearbox2" ) then
			NodeAdd = CVT
		elseif ( MobilityTable.ent == "acf_gearbox3" ) then
			NodeAdd = Automatic
		elseif ( MobilityTable.ent == "acf_chips" ) then
			NodeAdd = Chips
		elseif ( MobilityTable.ent == "acf_vtec" ) then
			NodeAdd = Vtec
		elseif ( MobilityTable.ent == "acf_nos" ) then
			NodeAdd = Nos
		end
		
		if(MobilityTable.category) then
			if(!Engine2Subcats[MobilityTable.category]) then
				Engine2Subcats[MobilityTable.category] = NodeAdd:AddNode( MobilityTable.category )
			end
		end
	end
	
	for MobilityID,MobilityTable in pairs(self.WeaponDisplay["Mobility"]) do
		
		local NodeAdd = Mobility2
		--#########################################################
		if MobilityTable.ent == "acf_engine5" then
			NodeAdd = EnginesMaker
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine2" then
			NodeAdd = EnginesLittle
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine4" then
			NodeAdd = EnginesFat
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_engine3" then
			NodeAdd = Engines2
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_gearbox2" then
			NodeAdd = CVT
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_gearbox3" then
			NodeAdd = Automatic
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_chips" then
			NodeAdd = Chips
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_vtec" then
			NodeAdd = Vtec
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		elseif MobilityTable.ent == "acf_nos" then
			NodeAdd = Nos
			if(MobilityTable.category) then
				NodeAdd = Engine2Subcats[MobilityTable.category]
			end
		end
		
		local EndNode = NodeAdd:AddNode( MobilityTable.name or "No Name" )
		EndNode.mytable = MobilityTable
		function EndNode:DoClick()
			RunConsoleCommand( "acfmenu_type", self.mytable.type )
			acfmenupanel:UpdateDisplay( self.mytable )
		end
		EndNode.Icon:SetImage( "gui/silkicons/wrench" )

	end*/
	
	--#########################################################################################################
	--#########################################################################################################
	--#########################################################################################################
	
	/*local Missiles = self.WeaponSelect:AddNode( "Missiles" )
	for MisID, MisTable in pairs(self.WeaponDisplay["Missiles"]) do

		local EndNode = Missiles:AddNode( MisTable.name or "No Name" )
    
		EndNode.mytable = MisTable
		function EndNode:DoClick()
			RunConsoleCommand( "acfmenu_type", self.mytable.type )
			acfmenupanel:UpdateDisplay( self.mytable )
		end
    
		EndNode.Icon:SetImage( "gui/silkicons/newspaper")
    
	end*/
	-- local Sensors = self.WeaponSelect:AddNode( "Sensors" )
	-- for SensorsID,SensorsTable in pairs(self.WeaponDisplay["Sensors"]) do
		
		-- local EndNode = Sensors:AddNode( SensorsTable.name or "No Name" )
		-- EndNode.mytable = SensorsTable
		-- function EndNode:DoClick()
			-- RunConsoleCommand( "acfmenu_type", self.mytable.type )
			-- acfmenupanel:UpdateDisplay( self.mytable )
		-- end
		-- EndNode.Icon:SetImage( "gui/silkicons/newspaper" )
		
	-- end
	
end

/*------------------------------------
	Think
------------------------------------*/
function PANEL:Think( )

end

function PANEL:UpdateDisplay( Table )
	
	RunConsoleCommand( "acfmenu_id", Table.id or 0 )
	
	--If a previous display exists, erase it
	if ( acfmenupanel.CustomDisplay ) then
		acfmenupanel.CustomDisplay:Clear(true)
		acfmenupanel.CustomDisplay = nil
		acfmenupanel.CData = nil
	end
	--Create the space to display the custom data
	acfmenupanel.CustomDisplay = vgui.Create( "DPanelList", acfmenupanel )	
		acfmenupanel.CustomDisplay:SetSpacing( 10 )
		acfmenupanel.CustomDisplay:EnableHorizontal( false ) 
		acfmenupanel.CustomDisplay:EnableVerticalScrollbar( false ) 
		acfmenupanel.CustomDisplay:SetSize( acfmenupanel:GetWide(), acfmenupanel:GetTall() )
	
	if not acfmenupanel["CData"] then
		--Create a table for the display to store data
		acfmenupanel["CData"] = {}	
	end
		
	acfmenupanel.CreateAttribs = Table.guicreate
	acfmenupanel.UpdateAttribs = Table.guiupdate
	acfmenupanel:CreateAttribs( Table )
	
	acfmenupanel:PerformLayout()

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
	acfmenupanel.WeaponSelect:SetPos( 0, ypos )
	acfmenupanel.WeaponSelect:SetSize( acfmenupanel:GetWide(), 165 )
	ypos = acfmenupanel.WeaponSelect.Y + acfmenupanel.WeaponSelect:GetTall() + vspacing
	
	if acfmenupanel.CustomDisplay then
		--Custom panel
		acfmenupanel.CustomDisplay:SetPos( 0, ypos )
		acfmenupanel.CustomDisplay:SetSize( acfmenupanel:GetWide(), acfmenupanel:GetTall() - acfmenupanel.WeaponSelect:GetTall() - 10 )
		ypos = acfmenupanel.CustomDisplay.Y + acfmenupanel.CustomDisplay:GetTall() + vspacing
	end
	
end

function ACFHomeGUICreate( Table )

	if not acfmenupanel.CustomDisplay then return end
	--start version
	
	VersionText1 = vgui.Create( "DLabel" )
	VersionText1:SetText("ACF Version")
	VersionText1:SetTextColor(Color(0,0,50,255))
	VersionText1:SetFont( "DefaultBold" )
	VersionText1:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( VersionText1 )
	
	VersionT = vgui.Create( "DLabel" )
	--versiontext = "Version\n\n".."SVN Version: "..ACF.CurrentVersion.."\nCurrent Version: "..ACF.Version
	VersionT:SetText("SVN Version: "..ACF.CurrentVersion.."\nCurrent Version: "..ACF.Version)
	VersionT:SetTextColor(Color(0,0,250,255))
	VersionT:SetFont( "DefaultBold" )
	VersionT:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( VersionT )
	
	VersionText2 = vgui.Create( "DLabel" )
	VersionText2:SetText("Custom Version")
	VersionText2:SetTextColor(Color(0,0,50,255))
	VersionText2:SetFont( "DefaultBold" )
	VersionText2:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( VersionText2 )
	
	VersionT2 = vgui.Create( "DLabel" )
	VersionT2:SetText("SVN Version: "..ACF.CurrentVersion2.."\nCurrent Version: "..ACF.Version2)
	VersionT2:SetTextColor(Color(0,0,250,255))
	VersionT2:SetFont( "DefaultBold" )
	VersionT2:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( VersionT2 )
	
	
	acfmenupanel["CData"]["VersionText"] = vgui.Create( "DLabel" )
	local color
	local versionstring
	if ACF.Version >= ACF.CurrentVersion then
		versionstring = "Up To Date"
		color = Color(0,225,0,255)
	else
		versionstring = "Out Of Date"
		color = Color(225,0,0,255)
	end
	
	acfmenupanel["CData"]["VersionText"]:SetText("\nACF Is "..versionstring.."!")
	acfmenupanel["CData"]["VersionText"]:SetColor(color) 
	acfmenupanel["CData"]["VersionText"]:SetFont( "DefaultBold" )
	acfmenupanel["CData"]["VersionText"]:SizeToContents() 
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"]["VersionText"] )
	
	
	VersionT3 = vgui.Create( "DLabel" )
	local color2
	local versionstring2
	if ACF.Version2 >= ACF.CurrentVersion2 then
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
	acfmenupanel.CustomDisplay:AddItem( VersionT3 )
	-- end version
	
	VersionCustomText = vgui.Create( "DLabel" )
	VersionCustomText:SetText("Custom Version: "..ACF.VersionCustom.."\n")
	VersionCustomText:SetTextColor(Color(0,0,250,255))
	VersionCustomText:SetFont( "DefaultBold" )
	VersionCustomText:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( VersionCustomText )
	
	------##### HELP CUSTOM MENU
	HelpText1 = vgui.Create( "DButton" )
	HelpText1:SetText("Help")
	HelpText1:SetTextColor(Color(255,0,0,255))
	HelpText1:SetWide(70)
	HelpText1:SetTall(50)
	HelpText1.DoClick = function()
		RunConsoleCommand("acf_help_browser_open")
	end
	acfmenupanel.CustomDisplay:AddItem( HelpText1 )
	
	--#########
	
	--acfmenupanel:CPanelText("Header", "Changelog")
	TextLog= vgui.Create( "DLabel" )
		TextLog:SetText( "Changelog")
		TextLog:SetTextColor(Color(0,0,200,255))
		TextLog:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextLog )
	
	--#################
	if acfmenupanel.Changelog then
		acfmenupanel["CData"]["Changelist"] = vgui.Create( "DTree" )
		for Rev,Changes in pairs(acfmenupanel.Changelog) do
			
			local Node = acfmenupanel["CData"]["Changelist"]:AddNode( "Rev "..Rev )
			Node.mytable = {}
				Node.mytable["rev"] = Rev
			function Node:DoClick()
				acfmenupanel:UpdateAttribs( Node.mytable )
			end
			Node.Icon:SetImage( "gui/silkicons/newspaper" )
			
		end	
		acfmenupanel.CData.Changelist:SetSize( acfmenupanel.CustomDisplay:GetWide(), 60 )
		
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"]["Changelist"] )
		
		acfmenupanel.CustomDisplay:PerformLayout()
		
		acfmenupanel:UpdateAttribs( {rev = table.maxn(acfmenupanel.Changelog)} )
	end
	--#################
	/*
	if acfmenupanel.Changelog then
		acfmenupanel["CData"]["Changelist"] = vgui.Create( "DTree" )
		for Rev,Changes in pairs(acfmenupanel.Changelog) do
			
			local Node = acfmenupanel["CData"]["Changelist"]:AddNode( "Rev "..Rev )
			Node.mytable = {}
				Node.mytable["rev"] = Rev
			function Node:DoClick()
				acfmenupanel:UpdateAttribs( Node.mytable )
			end
			Node.Icon:SetImage( "gui/silkicons/newspaper" )
			
		end	
		acfmenupanel.CData.Changelist:SetSize( acfmenupanel.CustomDisplay:GetWide(), 60 )
		
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"]["Changelist"] )
		
		acfmenupanel.CustomDisplay:PerformLayout()
		
		acfmenupanel:UpdateAttribs( {rev = table.maxn(acfmenupanel.Changelog)} )
	end*/
	
end
	
function ACFHomeGUIUpdate( Table )
	
	/*acfmenupanel:CPanelText("Changelog", acfmenupanel.Changelog[Table["rev"]])
	acfmenupanel.CustomDisplay:PerformLayout()
	TextLog2 = vgui.Create( "DLabel" )
		TextLog2:SetText( acfmenupanel.Changelog2[Table["rev2"]])
		TextLog2:SetTextColor(Color(0,0,200,255))
		TextLog2:SetFont( "DefaultBold" )
		TextLog2:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( TextLog2 )
	acfmenupanel.CustomDisplay:PerformLayout()*/
	
	TextLog3 = vgui.Create( "DLabel" )
		TextLog3:SetText( acfmenupanel.Changelog[Table["rev"]])
		TextLog3:SetTextColor(Color(0,0,200,255))
		TextLog3:SetFont( "DefaultBold" )
		TextLog3:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( TextLog3 )
	acfmenupanel.CustomDisplay:PerformLayout()
	
	local color
	local versionstring
	if ACF.Version >= ACF.CurrentVersion then
		versionstring = "Up To Date"
		color = Color(0,225,0,255)
	else
		versionstring = "Out Of Date"
		color = Color(225,0,0,255)

	end
	
	acfmenupanel["CData"]["VersionText"]:SetText("\nACF Is "..versionstring.."!")
	acfmenupanel["CData"]["VersionText"]:SetColor(color)
	acfmenupanel["CData"]["VersionText"]:SizeToContents()
	
	local color2
	local versionstring2
	if ACF.Version2 >= ACF.CurrentVersion2 then
		versionstring2 = "Up To Date"
		color2 = Color(0,225,0,255)
	else
		versionstring2 = "Out Of Date"
		color2 = Color(225,0,0,255)
	end
	
	VersionT3:SetText("ACF Custom Is "..versionstring2.."!\n")
	VersionT3:SetColor(color2)
	VersionT3:SizeToContents()
	
end

function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	
	acfmenupanel.Changelog = {}
	for Key,String in pairs(Temp) do
		acfmenupanel.Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(acfmenupanel.Changelog,true)
	
	local Table = {}
		Table.guicreate = (function( Panel, Table ) ACFHomeGUICreate( Table ) end or nil)
		Table.guiupdate = (function( Panel, Table ) ACFHomeGUIUpdate( Table ) end or nil)
	acfmenupanel:UpdateDisplay( Table )

end
http.Fetch("https://raw.github.com/bouletmarc/ACF_CustomMod/master/changelogcustom.txt", ACFChangelogHTTPCallBack, function() end)

/*function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	
	acfmenupanel.Changelog = {}
	for Key,String in pairs(Temp) do
		acfmenupanel.Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(acfmenupanel.Changelog,true)
	
	local Table = {}
		Table.guicreate = (function( Panel, Table ) ACFHomeGUICreate( Table ) end or nil)
		Table.guiupdate = (function( Panel, Table ) ACFHomeGUIUpdate( Table ) end or nil)
	acfmenupanel:UpdateDisplay( Table )

end
http.Fetch("http://raw.github.com/nrlulz/ACF/master/changelog.txt", ACFChangelogHTTPCallBack, function() end)*/

function PANEL:AmmoSelect( Blacklist )
	
	if not acfmenupanel.CustomDisplay then return end
	if not Blacklist then Blacklist = {} end
	
	if not acfmenupanel.AmmoData then
		acfmenupanel.AmmoData = {}
			acfmenupanel.AmmoData["Id"] = "Ammo2x4x4"
			acfmenupanel.AmmoData["Type"] = "Ammo"
			acfmenupanel.AmmoData["Data"] = acfmenupanel.WeaponData["Guns"]["12.7mmMG"]["round"]
	end
	
	--Creating the ammo crate selection
	acfmenupanel.CData.CrateSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	--Every display and slider is placed in the Round table so it gets trashed when selecting a new round type
		acfmenupanel.CData.CrateSelect:SetSize(100, 30)
		for Key, Value in pairs( acfmenupanel.WeaponDisplay["Ammo"] ) do
			acfmenupanel.CData.CrateSelect:AddChoice( Value.id , Key )
		end
		acfmenupanel.CData.CrateSelect.OnSelect = function( index , value , data )
			RunConsoleCommand( "acfmenu_id", data )
		end
		acfmenupanel.CData.CrateSelect:SetText(acfmenupanel.AmmoData["Id"])
		RunConsoleCommand( "acfmenu_id", acfmenupanel.AmmoData["Id"] )
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.CrateSelect )
	
	--Create the caliber selection display
	acfmenupanel.CData.CaliberSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	
		acfmenupanel.CData.CaliberSelect:SetSize(100, 30)
		for Key, Value in pairs( acfmenupanel.WeaponDisplay["Guns"] ) do
			if( !table.HasValue( Blacklist, Value.gunclass ) ) then
				acfmenupanel.CData.CaliberSelect:AddChoice( Value.id , Key )
			end
		end
		acfmenupanel.CData.CaliberSelect.OnSelect = function( index , value , data )
			acfmenupanel.AmmoData["Data"] = acfmenupanel.WeaponData["Guns"][data]["round"]
			self:UpdateAttribs()
			self:UpdateAttribs()	--Note : this is intentional
		end
		acfmenupanel.CData.CaliberSelect:SetText(acfmenupanel.AmmoData["Data"]["id"])
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.CaliberSelect )

end

function PANEL:AmmoSlider(Name, Value, Min, Max, Decimals, Title, Desc) --Variable name in the table, Value, Min value, Max Value, slider text title, slider decimeals, description text below slider 

	if not acfmenupanel["CData"][Name] then
		acfmenupanel["CData"][Name] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Name].Label:SetSize( 0 ) --Note : this is intentional 
			acfmenupanel["CData"][Name]:SetTall( 50 ) -- make the slider taller to fit the new label
			acfmenupanel["CData"][Name]:SetMin( 0 )
			acfmenupanel["CData"][Name]:SetMax( 1000 )
			acfmenupanel["CData"][Name]:SetDecimals( Decimals )
		acfmenupanel["CData"][Name.."_label"] = vgui.Create( "DLabel", acfmenupanel["CData"][Name]) -- recreating the label
			acfmenupanel["CData"][Name.."_label"]:SetPos( 0,0 )
			acfmenupanel["CData"][Name.."_label"]:SetText( Title )
			acfmenupanel["CData"][Name.."_label"]:SizeToContents()
			acfmenupanel["CData"][Name.."_label"]:SetDark( true )
			if acfmenupanel.AmmoData[Name] then
				acfmenupanel["CData"][Name]:SetValue(acfmenupanel.AmmoData[Name])
			end
			acfmenupanel["CData"][Name].OnValueChanged = function( slider, val )
				if acfmenupanel.AmmoData[Name] != val then
					acfmenupanel.AmmoData[Name] = val
					self:UpdateAttribs( Name )
				end
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name] )
	end
	acfmenupanel["CData"][Name]:SetMin( Min ) 
	acfmenupanel["CData"][Name]:SetMax( Max )
	acfmenupanel["CData"][Name]:SetValue( Value )
	
	if not acfmenupanel["CData"][Name.."_text"] and Desc then
		acfmenupanel["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanel["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanel["CData"][Name.."_text"]:SetDark( true )
			acfmenupanel["CData"][Name.."_text"]:SetTall( 20 )
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name.."_text"] )
	end
	acfmenupanel["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanel["CData"][Name.."_text"]:SetSize( acfmenupanel.CustomDisplay:GetWide(), 10 )
	acfmenupanel["CData"][Name.."_text"]:SizeToContentsX()
	
end

function PANEL:AmmoCheckbox(Name, Title, Desc) --Variable name in the table, slider text title, slider decimeals, description text below slider 

	if not acfmenupanel["CData"][Name] then
		acfmenupanel["CData"][Name] = vgui.Create( "DCheckBoxLabel" )
			acfmenupanel["CData"][Name]:SetText( Title or "" )
			acfmenupanel["CData"][Name]:SetDark( true )
			acfmenupanel["CData"][Name]:SizeToContents()
			if acfmenupanel.AmmoData[Name] != nil then
				acfmenupanel["CData"][Name]:SetChecked(acfmenupanel.AmmoData[Name])
			else
				acfmenupanel.AmmoData[Name] = false
			end
			acfmenupanel["CData"][Name].OnChange = function( check, bval )
				acfmenupanel.AmmoData[Name] = bval
				self:UpdateAttribs( {Name, bval} )
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name] )
	end
	acfmenupanel["CData"][Name]:SetText( Title )
	
	
	if not acfmenupanel["CData"][Name.."_text"] and Desc then
		acfmenupanel["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanel["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanel["CData"][Name.."_text"]:SetDark( true )
			acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name.."_text"] )
	end
	acfmenupanel["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanel["CData"][Name.."_text"]:SetSize( acfmenupanel.CustomDisplay:GetWide(), 10 )
	acfmenupanel["CData"][Name.."_text"]:SizeToContentsX()
	
end

function PANEL:CPanelText(Name, Desc)

	if not acfmenupanel["CData"][Name.."_text"] then
		acfmenupanel["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanel["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanel["CData"][Name.."_text"]:SetDark( true )
			acfmenupanel["CData"][Name.."_text"]:SetWrap(true)
			acfmenupanel["CData"][Name.."_text"]:SetAutoStretchVertical( true )
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name.."_text"] )
	end
	acfmenupanel["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanel["CData"][Name.."_text"]:SetSize( acfmenupanel.CustomDisplay:GetWide(), 10 )
	acfmenupanel["CData"][Name.."_text"]:SizeToContentsY()

end
