--------------------------------------
--	Set vars
--------------------------------------
DupeFixer = {}
DupeFixer.Version = "Advanced Duplicator2"
DupeFixer.Folder = ""
DupeFixer.Selected = ""
DupeFixer.EntitiesIDList = {}
DupeFixer.EnginesListChanged = ""

DupeFixer.AllowedMode = 0
DupeFixer.OldEngine = ""
DupeFixer.InitialSpacing = 0

DupeFixer.AddedSorted = 0
DupeFixer.CurrentFile = 0
DupeFixer.LastFolder = ""
DupeFixer.FileTableNotSorted = {}

local MenuSpacing = 5
--------------------------------------
--	Initialize
--------------------------------------
function PANEL:Init( )

	acfmenupanelfixer = self.Panel
	
	self:SetTall( surface.ScreenHeight() - 120 )
	
	local QuarterWide = (acfmenupanelfixer:GetWide()/2)
	
	DupeFixer.ReLoad = vgui.Create("DButton", self)
	DupeFixer.ReLoad:SetText("Reload list")
	DupeFixer.ReLoad:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.ReLoad:SetPos(QuarterWide/1.5,MenuSpacing)
	DupeFixer.ReLoad:SetWide(100)
	DupeFixer.ReLoad:SetTall(30)
	DupeFixer.ReLoad.DoClick = function()
		ReloadValues()
	end
	
	DupeFixer.Sort = vgui.Create("DButton", self)
	DupeFixer.Sort:SetText("Sort list")
	DupeFixer.Sort:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.Sort:SetPos(QuarterWide*4.5,MenuSpacing)
	DupeFixer.Sort:SetWide(100)
	DupeFixer.Sort:SetTall(30)
	DupeFixer.Sort:SetToolTip("   Use this option to\n      sort the files\n  that need to be fix\nlag for some seconds")
	DupeFixer.Sort.DoClick = function()
		local Sorting = true
		UpdateComboBox(Sorting)
	end
	
	MenuSpacing = MenuSpacing + 40
	
	DupeFixer.AlertInfo = vgui.Create("DLabel", self)
	DupeFixer.AlertInfo:SetPos( 5, MenuSpacing )
	DupeFixer.AlertInfo:SetText("Duplicator Version")
	DupeFixer.AlertInfo:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.AlertInfo:SetFont( "DefaultBold" )
	DupeFixer.AlertInfo:SizeToContents()
	
	MenuSpacing = MenuSpacing + 20
	
	DupeFixer.VersionComboBox = vgui.Create("DComboBox", self)
	DupeFixer.VersionComboBox:SetPos( 15, MenuSpacing )
	DupeFixer.VersionComboBox:SetSize( (acfmenupanelfixer:GetWide()*4), 20 )
	DupeFixer.VersionComboBox:SetValue( DupeFixer.Version )
	DupeFixer.VersionComboBox:AddChoice("Advanced Duplicator")
	DupeFixer.VersionComboBox:AddChoice("Advanced Duplicator2")
	DupeFixer.VersionComboBox.OnSelect = function( panel, index, value )
		DupeFixer.Version = value
		UpdateComboBox()
	end
	
	MenuSpacing = MenuSpacing + 30
	
	DupeFixer.FolderTitle = vgui.Create("DLabel", self)
	DupeFixer.FolderTitle:SetPos( 5, MenuSpacing )
	DupeFixer.FolderTitle:SetText("Folder")
	DupeFixer.FolderTitle:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.FolderTitle:SetFont( "DefaultBold" )
	DupeFixer.FolderTitle:SizeToContents()
	
	MenuSpacing = MenuSpacing + 20
	
	DupeFixer.FolderComboBox = vgui.Create("DComboBox", self)
	DupeFixer.FolderComboBox:SetPos( 15, MenuSpacing )
	DupeFixer.FolderComboBox:SetSize( (acfmenupanelfixer:GetWide()*4), 20 )
	DupeFixer.FolderComboBox:SetValue( ".NOON SELECTED" )
	DupeFixer.FolderComboBox.OnSelect = function( panel, index, value )
		DupeFixer.Selected = ""
		if value == ".NOON SELECTED" then
			DupeFixer.Folder = ""
		else
			DupeFixer.Folder = value
		end
		UpdateComboBox()
	end
	
	MenuSpacing = MenuSpacing + 30
	
	DupeFixer.FileListView = vgui.Create("DListView", self)
	DupeFixer.FileListView:SetParent(acfmenupanelfixer)
	DupeFixer.FileListView:SetPos(15, MenuSpacing)
	DupeFixer.FileListView:SetSize((acfmenupanelfixer:GetWide()*4), 220)
	DupeFixer.FileListView:SetMultiSelect(false)
	DupeFixer.FileListView:AddColumn("Files")
	DupeFixer.FileListView.OnClickLine = function(parent,selected,isselected)
		GetLineName = tostring(selected:GetValue(1))
		if GetLineName != "" then
			DupeFixer.Selected = GetLineName
			SelectionFolder()
		end
	end
	
	MenuSpacing = MenuSpacing + 235
	
	DupeFixer.BottomText = vgui.Create("DLabel", self)
	DupeFixer.BottomText:SetPos( 5, MenuSpacing )
	DupeFixer.BottomText:SetText("")
	DupeFixer.BottomText:SetFont( "DefaultBold" )
	
	MenuSpacing = MenuSpacing + 25
	
	local txtinfo = "1. Select a dupe file\n"
	txtinfo = txtinfo .. "2. Load the file\n"
	txtinfo = txtinfo .. "3. Replace acf custom values to original\n"
	txtinfo = txtinfo .. "4. Save the new dupe\n"
	txtinfo = txtinfo .. "5. Play on a server without Custom Mod"
	
	DupeFixer.BottomTextInfo = vgui.Create("DLabel", self)
	DupeFixer.BottomTextInfo:SetPos( 5, MenuSpacing )
	DupeFixer.BottomTextInfo:SetText(txtinfo)
	DupeFixer.BottomTextInfo:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.BottomTextInfo:SetFont( "DefaultBold" )
	DupeFixer.BottomTextInfo:SizeToContents()
	
	MenuSpacing = MenuSpacing + 80
	
	DupeFixer.Load = vgui.Create("DButton", self)
	DupeFixer.Load:SetText("Load")
	DupeFixer.Load:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.Load:SetPos(QuarterWide,MenuSpacing)
	DupeFixer.Load:SetWide(80)
	DupeFixer.Load:SetTall(30)
	DupeFixer.Load:SetDisabled(true)
	DupeFixer.Load.DoClick = function()
		acfmenupanelfixer:UpdateDisplay()
	end
	
	DupeFixer.Save = vgui.Create("DButton", self)
	DupeFixer.Save:SetText("Save")
	DupeFixer.Save:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	DupeFixer.Save:SetPos(QuarterWide*5,MenuSpacing)
	DupeFixer.Save:SetWide(80)
	DupeFixer.Save:SetTall(30)
	DupeFixer.Save:SetDisabled(true)
	DupeFixer.Save.DoClick = function()
		Encode( function(data)
			SaveDupe(data)
		end)
	end
	
	MenuSpacing = MenuSpacing + 40
	
	DupeFixer.SaveText = vgui.Create("DLabel", self)
	DupeFixer.SaveText:SetPos( 5, MenuSpacing )
	DupeFixer.SaveText:SetText("")
	DupeFixer.SaveText:SetTextColor(Color(0,200,0,255))
	DupeFixer.SaveText:SetFont( "DefaultBold" )
	
	MenuSpacing = MenuSpacing + 30
	
	DupeFixer.FoundText = vgui.Create("DLabel", self)
	DupeFixer.FoundText:SetPos( 5, MenuSpacing )
	DupeFixer.FoundText:SetText("")
	DupeFixer.FoundText:SetTextColor(Color(200,0,0,255))
	DupeFixer.FoundText:SetFont( "DefaultBold" )
	
	MenuSpacing = MenuSpacing + 30
	
	DupeFixer.InitialSpacing = MenuSpacing
	
	--Set files listing
	UpdateComboBox()
	
	--Set DPanelList
	acfmenupanelfixer:UpdateDisplay()
end
--------------------------------------
--	Think
--------------------------------------
function PANEL:Think()
	--//
end
--------------------------------------
--	Update Display
--------------------------------------
function PANEL:UpdateDisplay()
	--Clean bottom menu
	if (acfmenupanelfixer.CustomDisplay) then
		acfmenupanelfixer.CustomDisplay:Clear(true)
		acfmenupanelfixer.CustomDisplay = nil
		acfmenupanelfixer.CData = nil
	end
	--Remake DPanelList
	acfmenupanelfixer.CustomDisplay = vgui.Create("DPanelList", acfmenupanelfixer)
	acfmenupanelfixer.CustomDisplay:SetSpacing(10)
	acfmenupanelfixer.CustomDisplay:EnableHorizontal(false)
	acfmenupanelfixer.CustomDisplay:EnableVerticalScrollbar(true)
	acfmenupanelfixer.CustomDisplay:SetPos(5, MenuSpacing+20)
	acfmenupanelfixer.CustomDisplay:SetSize(acfmenupanelfixer:GetWide()/1.2, (acfmenupanelfixer:GetTall()-MenuSpacing-10))
	--Remake CData table
	if not acfmenupanelfixer["CData"] then
		acfmenupanelfixer["CData"] = {}
	end
	
	if DupeFixer.Selected != "" then
		DecodeDupe()
	end
	
	acfmenupanelfixer:PerformLayout()
end
--------------------------------------
--	Perform Layout
--------------------------------------
function PANEL:PerformLayout()
	if (acfmenupanelfixer.CustomDisplay) then
		acfmenupanelfixer.CustomDisplay:SetPos(5, MenuSpacing+20)
		acfmenupanelfixer.CustomDisplay:SetSize(acfmenupanelfixer:GetWide()/1.2, (acfmenupanelfixer:GetTall()-MenuSpacing-10))
	end
end
--------------------------------------
--	Create Bottom Menu
--------------------------------------
function DupeFixerMenuCreate()
	
	--Recall until DPanelList found
	if not acfmenupanelfixer.CustomDisplay then acfmenupanelfixer:UpdateDisplay() end
	
	for k, v in pairs(DupeFixer.EntitiesIDList) do --v = engineID (ex: '2.9-V8')
		--check allowed engines
		if AllowedCheckup(v) then
			--Allowed engines menu
			if DupeFixer.AllowedMode == 1 then
				if not acfmenupanelfixer["CData"]["EngineFoundText"..v] then
					acfmenupanelfixer["CData"]["EngineFoundText"..v] = vgui.Create("DLabel")
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetText("Replace each engine ID '"..v.."' by :")
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetFont( "DefaultBold" )
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SizeToContents()
					acfmenupanelfixer.CustomDisplay:AddItem(acfmenupanelfixer["CData"]["EngineFoundText"..v])
				end
				if not acfmenupanelfixer["CData"]["EngineFoundBox"..v] then
					acfmenupanelfixer["CData"]["EngineFoundBox"..v] = vgui.Create("DComboBox")
					acfmenupanelfixer["CData"]["EngineFoundBox"..v]:SetSize( (acfmenupanelfixer:GetWide()/1.5), 20 )
					acfmenupanelfixer["CData"]["EngineFoundBox"..v]:SetValue( "Select New Engine ID" )
					acfmenupanelfixer["CData"]["EngineFoundBox"..v].OnSelect = function( panel, index, value )
						--make the string 'table' to change
						if DupeFixer.OldEngine == "" then
							DupeFixer.EnginesListChanged = tostring(v..","..value)
						else
							DupeFixer.EnginesListChanged = tostring(DupeFixer.OldEngine..","..value)
						end
						--change text
						if v == value then
							acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetText("DONE-SAME ID")
							acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetTextColor(Color(0,200,0,255))
						else
							acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetText("REMPLACEMENT DONE")
							acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetTextColor(Color(0,200,0,255))
						end
						--replace table
						ReplaceTable(DupeFixer.EnginesListChanged)
					end
					acfmenupanelfixer.CustomDisplay:AddItem(acfmenupanelfixer["CData"]["EngineFoundBox"..v])
				end
				if not acfmenupanelfixer["CData"]["EngineTextDone"..v] then
					acfmenupanelfixer["CData"]["EngineTextDone"..v] = vgui.Create("DLabel")
					acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetText("NOT DONE")
					acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetTextColor(Color(200,0,0,255))
					acfmenupanelfixer["CData"]["EngineTextDone"..v]:SetFont( "DefaultBold" )
					acfmenupanelfixer["CData"]["EngineTextDone"..v]:SizeToContents()
					acfmenupanelfixer.CustomDisplay:AddItem(acfmenupanelfixer["CData"]["EngineTextDone"..v])
				end
				
				CheckReplacement(v)
			--Not allowed engines menu (unofficial acf)
			elseif DupeFixer.AllowedMode == 2 then
				if not acfmenupanelfixer["CData"]["EngineFoundText"..v] then
					acfmenupanelfixer["CData"]["EngineFoundText"..v] = vgui.Create("DLabel")
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetText("CAN'T replace '"..v.."' from ACF unofficial")
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetTextColor(Color(200,0,0,255))
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SetFont( "DefaultBold" )
					acfmenupanelfixer["CData"]["EngineFoundText"..v]:SizeToContents()
					acfmenupanelfixer.CustomDisplay:AddItem(acfmenupanelfixer["CData"]["EngineFoundText"..v])
				end
			end
			--Add some spacing
			if not acfmenupanelfixer["CData"]["EngineFoundSpace"..v] then
				acfmenupanelfixer["CData"]["EngineFoundSpace"..v] = vgui.Create("DLabel")
				acfmenupanelfixer["CData"]["EngineFoundSpace"..v]:SetText("\n")
				acfmenupanelfixer.CustomDisplay:AddItem(acfmenupanelfixer["CData"]["EngineFoundSpace"..v])
			end
		end
	end
	
	--Change not used values in acf original
	ChangeBadValues()
end
--------------------------------------
--	Position DPanelList
--------------------------------------
function PositionPanel()
	acfmenupanelfixer.CustomDisplay:PerformLayout()
	
	return true
end

