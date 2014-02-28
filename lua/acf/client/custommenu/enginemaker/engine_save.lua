// Made by Bouletmarc

local SoundBrowserPanel = nil

--Saving New Engine
function NewEngineSaveFunc()
	local LastEngineText = file.Read("acf/lastengine.txt")
	local LastEngineTable = {}
	for w in string.gmatch(LastEngineText, "([^,]+)") do
		table.insert(LastEngineTable, w)
	end
	local NameLoadT = tostring(LastEngineTable[1])
	local SoundLoadT = tostring(LastEngineTable[2])
	local ModelLoadT = tostring(LastEngineTable[3])
	local FuelTypeLoadT = tostring(LastEngineTable[4])
	local EngineTypeLoadT = tostring(LastEngineTable[5])
	local TorqueLoadT = tonumber(LastEngineTable[6])
	local IdleLoadT = tonumber(LastEngineTable[7])
	local PeakMinLoadT = tonumber(LastEngineTable[8])
	local PeakMaxLoadT = tonumber(LastEngineTable[9])
	local LimitRpmLoadT = tonumber(LastEngineTable[10])
	local FlywheelLoadT = tonumber(LastEngineTable[11])
	local WeightLoadT = tonumber(LastEngineTable[12])
	local EngineSizeLoadT = tonumber(LastEngineTable[13])
	local EngineTypeLoadText = tonumber(LastEngineTable[14])
	local iSelectLoad = tostring(LastEngineTable[15])
	local IsTransLoad = tostring(LastEngineTable[16])
	local FlywheelOverLoad = tonumber(LastEngineTable[17])
	RunConsoleCommand( "acfmenu_data1", NameLoadT )
	RunConsoleCommand( "acf_menudata2", SoundLoadT )
	RunConsoleCommand( "acf_menudata3", ModelLoadT )
	RunConsoleCommand( "acf_menudata4", FuelTypeLoadT )
	RunConsoleCommand( "acf_menudata5", EngineTypeLoadT )
	RunConsoleCommand( "acfmenu_data6", TorqueLoadT )
	RunConsoleCommand( "acfmenu_data7", IdleLoadT )
	RunConsoleCommand( "acfmenu_data8", PeakMinLoadT )
	RunConsoleCommand( "acfmenu_data9", PeakMaxLoadT )
	RunConsoleCommand( "acfmenu_data10", LimitRpmLoadT )
	RunConsoleCommand( "acfmenu_data11", FlywheelLoadT )
	RunConsoleCommand( "acfmenu_data12", WeightLoadT )
	RunConsoleCommand( "acfmenu_data13", iSelectLoad )
	RunConsoleCommand( "acfmenu_data14", IsTransLoad )
	RunConsoleCommand( "acfmenu_data15", FlywheelOverLoad )
	
	local txt = NameLoadT..","..SoundLoadT..","..ModelLoadT..","..FuelTypeLoadT..","..EngineTypeLoadT..","..TorqueLoadT..","
	txt = txt ..IdleLoadT..","..PeakMinLoadT..","..PeakMaxLoadT..","..LimitRpmLoadT..","..FlywheelLoadT..","..WeightLoadT..","
	txt = txt ..EngineSizeLoadT..","..EngineTypeLoadText..","..iSelectLoad..","..IsTransLoad..","..FlywheelOverLoad
	
	local invalid_filename_chars = {
		["*"] = "",
		["?"] = "",
		[">"] = "",
		["<"] = "",
		["|"] = "",
		["\\"] = "",
		['"'] = "",
		[" "] = "_",
	}
	local Nametxtfile = string.lower(string.gsub(NameLoadT, ".", invalid_filename_chars))
	
	file.Write("acf/custom.engines/"..Nametxtfile..".txt", txt)	--Save the engine
	file.Write("acf/lastengine.txt", txt)	--Save the engine also as
end

local function CreateSoundBrowser()
	--###########################################
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
	--###########################################

	SoundBrowserPanel = vgui.Create("DFrame") // The main frame.
	SoundBrowserPanel:SetPos(500,200)
	SoundBrowserPanel:SetSize(450, 450)

	SoundBrowserPanel:SetMinWidth(450)
	SoundBrowserPanel:SetMinHeight(450)

	SoundBrowserPanel:SetSizable(false)
	SoundBrowserPanel:SetDeleteOnClose( true )
	SoundBrowserPanel:SetTitle("Engine Menu V3.3 - SAVE MENU")
	SoundBrowserPanel:SetVisible(false)
	SoundBrowserPanel:SetCookieName( "wire_sound_browser" )
	SoundBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.

	--Button Panel
	local ButtonsSidePanel = SoundBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(5, 5, 5, 5)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetTall(440)
	ButtonsSidePanel:SetWide(SoundBrowserPanel:GetWide())
	ButtonsSidePanel:SetDrawBackground(false)
		--#########################################################################
		--text 
		SaveText1 = ButtonsSidePanel:Add("DLabel")
		SaveText1:SetText("Save Menu")
		SaveText1:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SaveText1:SetPos(180,10)
		SaveText1:SetFont( "DefaultBold" )
		SaveText1:SizeToContents()
		
		
		DermaListView = ButtonsSidePanel:Add("DListView")
		DermaListView:SetParent(ButtonsSidePanel)
		DermaListView:SetPos(40, 30)
		DermaListView:SetSize(350, 280)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Descriptions")
		DermaListView:Clear()
		--load text for menu
		local LastEngineText2 = file.Read("acf/lastengine.txt")
		local LastEngineTable2 = {}
		for w in string.gmatch(LastEngineText2, "([^,]+)") do
			table.insert(LastEngineTable2, w)
		end
		local NameLoadT2 = tostring(LastEngineTable2[1])
		local SoundLoadT2 = tostring(LastEngineTable2[2])
		local ModelLoadT2 = tostring(LastEngineTable2[3])
		local FuelTypeLoadT2 = tostring(LastEngineTable2[4])
		local EngineTypeLoadT2 = tostring(LastEngineTable2[5])
		local TorqueLoadT2 = tonumber(LastEngineTable2[6])
		local IdleLoadT2 = tonumber(LastEngineTable2[7])
		local PeakMinLoadT2 = tonumber(LastEngineTable2[8])
		local PeakMaxLoadT2 = tonumber(LastEngineTable2[9])
		local LimitRpmLoadT2 = tonumber(LastEngineTable2[10])
		local FlywheelLoadT2 = tonumber(LastEngineTable2[11])
		local WeightLoadT2 = tonumber(LastEngineTable2[12])
		local iselectT2 = tostring(LastEngineTable2[15])
		local IsTransT2 = tostring(LastEngineTable2[16])
		local FlywheelOverT2 = tonumber(LastEngineTable2[17])
		DermaListView:AddLine("1. Name : "..NameLoadT2)
		DermaListView:AddLine("2. Sound : "..SoundLoadT2)
		DermaListView:AddLine("3. Model : "..ModelLoadT2)
		DermaListView:AddLine("4. Fuel : "..FuelTypeLoadT2)
		DermaListView:AddLine("5. EngineType : "..EngineTypeLoadT2)
		DermaListView:AddLine("6. Torque : "..TorqueLoadT2)
		DermaListView:AddLine("7. Idle : "..IdleLoadT2)
		DermaListView:AddLine("8. Peak Min : "..PeakMinLoadT2)
		DermaListView:AddLine("9. Peak Max : "..PeakMaxLoadT2)
		DermaListView:AddLine("10. Limit : "..LimitRpmLoadT2)
		DermaListView:AddLine("11. Flywheel : "..FlywheelLoadT2)
		DermaListView:AddLine("12. Weight : "..WeightLoadT2)
		DermaListView:AddLine("13. iSelect : "..iselectT2)
		DermaListView:AddLine("14. IsTrans : "..IsTransT2)
		DermaListView:AddLine("15. Flywheel Override : "..FlywheelOverT2)
		DermaListView:PerformLayout( )
		DermaListView:SetSortable(false)
		
		--button
		BackButton	= ButtonsSidePanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		BackButton:SetPos(40,330)
		BackButton:SetWide(80)
		BackButton:SetTall(60)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginesound_browser_open")
			SoundBrowserPanel:Close()
		end
		
		NextButton	= ButtonsSidePanel:Add("DButton")
		NextButton:SetText("Quit without save")
		NextButton:SetToolTip("Dont forget to update the menu !")
		NextButton:SetTextColor(Color(255,0,0,255))
		NextButton:SetPos(300,330)
		NextButton:SetWide(100)
		NextButton:SetTall(60)
		NextButton.DoClick = function()
			--Reload and Quit
			local LastEngineText = file.Read("acf/lastengine.txt")
			local LastEngineTable = {}
			for w in string.gmatch(LastEngineText, "([^,]+)") do
				table.insert(LastEngineTable, w)
			end
			local NameLoadT = tostring(LastEngineTable[1])
			local SoundLoadT = tostring(LastEngineTable[2])
			local ModelLoadT = tostring(LastEngineTable[3])
			local FuelTypeLoadT = tostring(LastEngineTable[4])
			local EngineTypeLoadT = tostring(LastEngineTable[5])
			local TorqueLoadT = tonumber(LastEngineTable[6])
			local IdleLoadT = tonumber(LastEngineTable[7])
			local PeakMinLoadT = tonumber(LastEngineTable[8])
			local PeakMaxLoadT = tonumber(LastEngineTable[9])
			local LimitRpmLoadT = tonumber(LastEngineTable[10])
			local FlywheelLoadT = tonumber(LastEngineTable[11])
			local WeightLoadT = tonumber(LastEngineTable[12])
			local iSelectLoad = tostring(LastEngineTable[15])
			local IsTransLoad = tostring(LastEngineTable[16])
			local FlywheelOverLoad = tonumber(LastEngineTable[17])
			RunConsoleCommand( "acfmenu_data1", NameLoadT )
			RunConsoleCommand( "acf_menudata2", SoundLoadT )
			RunConsoleCommand( "acf_menudata3", ModelLoadT )
			RunConsoleCommand( "acf_menudata4", FuelTypeLoadT )
			RunConsoleCommand( "acf_menudata5", EngineTypeLoadT )
			RunConsoleCommand( "acfmenu_data6", TorqueLoadT )
			RunConsoleCommand( "acfmenu_data7", IdleLoadT )
			RunConsoleCommand( "acfmenu_data8", PeakMinLoadT )
			RunConsoleCommand( "acfmenu_data9", PeakMaxLoadT )
			RunConsoleCommand( "acfmenu_data10", LimitRpmLoadT )
			RunConsoleCommand( "acfmenu_data11", FlywheelLoadT )
			RunConsoleCommand( "acfmenu_data12", WeightLoadT )
			RunConsoleCommand( "acfmenu_data13", iSelectLoad )
			RunConsoleCommand( "acfmenu_data14", IsTransLoad )
			RunConsoleCommand( "acfmenu_data15", FlywheelOverLoad )
			SoundBrowserPanel:Close()
			notification.AddLegacy("Dont forget to Update Engine Maker", NOTIFY_HINT, 5)
		end
		
		SaveButton	= ButtonsSidePanel:Add("DButton")
		SaveButton:SetText("Save")
		SaveButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SaveButton:SetPos(170,330)
		SaveButton:SetWide(80)
		SaveButton:SetTall(60)
		SaveButton.DoClick = function()
			NewEngineSaveFunc()
			NextButton:SetText("Quit")
			NextButton:SetWide(80)
			NextButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		end

	SoundBrowserPanel:InvalidateLayout(false)
	
end

local function OpenSoundBrowser(pl, cmd, args)
	if (!IsValid(SoundBrowserPanel)) then
		CreateSoundBrowser(path)
	end

	SoundBrowserPanel:SetVisible(true)
	SoundBrowserPanel:MakePopup()
	SoundBrowserPanel:InvalidateLayout(true)

	WireLib.Timedcall(function(SoundBrowserPanel)
		if (!IsValid(SoundBrowserPanel)) then return end

		SoundBrowserPanel:InvalidateLayout(true)
	end, SoundBrowserPanel)
end

concommand.Add("acf_enginesave_browser_open", OpenSoundBrowser)