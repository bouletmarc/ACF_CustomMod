// Made by Bouletmarc

local SoundBrowserPanel = nil

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
	SoundBrowserPanel:SetSize(550, 450)
	--Set Center
	SoundBrowserPanel:SetPos((ScrW()/2)-(SoundBrowserPanel:GetWide()/2),(ScrH()/2)-(SoundBrowserPanel:GetTall()/2))

	SoundBrowserPanel:SetMinWidth(550)
	SoundBrowserPanel:SetMinHeight(450)

	SoundBrowserPanel:SetSizable(false)
	SoundBrowserPanel:SetDeleteOnClose( true )
	SoundBrowserPanel:SetTitle("Engine Menu V8.1 - LOAD MENU")
	SoundBrowserPanel:SetVisible(false)
	SoundBrowserPanel:SetCookieName( "wire_sound_browser" )
	SoundBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.

	--Button Panel
	local ButtonsSidePanel = SoundBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(5, 5, 5, 5)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetTall(430)
	ButtonsSidePanel:SetWide(SoundBrowserPanel:GetWide())
	ButtonsSidePanel:SetDrawBackground(false)
		--#########################################################################
		--text 
		SaveText1 = ButtonsSidePanel:Add("DLabel")
		SaveText1:SetText("Load Menu")
		SaveText1:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		SaveText1:SetPos(245,20)
		SaveText1:SetFont( "DefaultBold" )
		SaveText1:SizeToContents()
		
		--button
		BackButton	= ButtonsSidePanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		BackButton:SetPos(60,320)
		BackButton:SetWide(80)
		BackButton:SetTall(60)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginestart_browser_open")
			SoundBrowserPanel:Close()
		end
		
		ExitButtonMode = 0
		ExitButton	= ButtonsSidePanel:Add("DButton")
		ExitButton:SetText("Close")
		ExitButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		ExitButton:SetPos(230,320)
		ExitButton:SetWide(100)
		ExitButton:SetTall(60)
		ExitButton.DoClick = function()
			SoundBrowserPanel:Close()
			if ExitButtonMode == 1 then
				notification.AddLegacy("Dont forget to Update Engine Maker", NOTIFY_HINT, 5)
				local CustomEngineTable = {}
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				for w in string.gmatch(GetFile, "([^,]+)") do
					table.insert(CustomEngineTable, w)
				end
				local NameLoad = tostring(CustomEngineTable[1])
				local SoundLoad = tostring(CustomEngineTable[2])
				local ModelLoad = tostring(CustomEngineTable[3])
				local FuelTypeLoad = tostring(CustomEngineTable[4])
				local EngineTypeLoad = tostring(CustomEngineTable[5])
				local TorqueLoad = tonumber(CustomEngineTable[6])
				local IdleLoad = tonumber(CustomEngineTable[7])
				local PeakMinLoad = tonumber(CustomEngineTable[8])
				local PeakMaxLoad = tonumber(CustomEngineTable[9])
				local LimitRpmLoad = tonumber(CustomEngineTable[10])
				local FlywheelLoad = tonumber(CustomEngineTable[11])
				local WeightLoad = tonumber(CustomEngineTable[12])
				local EngineSizeLoadT = tonumber(CustomEngineTable[13])
				local EngineTypeLoadText = tonumber(CustomEngineTable[14])
				local iSelectLoad = tostring(CustomEngineTable[15])
				local IsTransLoad = tostring(CustomEngineTable[16])
				local FlywheelOverLoad = tonumber(CustomEngineTable[17])
				local txt = NameLoad..","..SoundLoad..","..ModelLoad..","..FuelTypeLoad..","..EngineTypeLoad..","..TorqueLoad..","
				txt = txt ..IdleLoad..","..PeakMinLoad..","..PeakMaxLoad..","..LimitRpmLoad..","..FlywheelLoad..","..WeightLoad..","
				txt = txt ..EngineSizeLoadT..","..EngineTypeLoadText..","..iSelectLoad..","..IsTransLoad..","..FlywheelOverLoad
				file.CreateDir("acf")
				file.Write("acf/lastengine.txt", txt)
				RunConsoleCommand( "acfcustom_data1", NameLoad )
				RunConsoleCommand( "acf_menudata2", SoundLoad )
				RunConsoleCommand( "acf_menudata3", ModelLoad )
				RunConsoleCommand( "acf_menudata4", FuelTypeLoad )
				RunConsoleCommand( "acf_menudata5", EngineTypeLoad )
				RunConsoleCommand( "acfcustom_data6", TorqueLoad )
				RunConsoleCommand( "acfcustom_data7", IdleLoad )
				RunConsoleCommand( "acfcustom_data8", PeakMinLoad )
				RunConsoleCommand( "acfcustom_data9", PeakMaxLoad )
				RunConsoleCommand( "acfcustom_data10", LimitRpmLoad )
				RunConsoleCommand( "acfcustom_data11", FlywheelLoad )
				RunConsoleCommand( "acfcustom_data12", WeightLoad )
				RunConsoleCommand( "acfcustom_data13", iSelectLoad )
				RunConsoleCommand( "acfcustom_data14", IsTransLoad )
				RunConsoleCommand( "acfcustom_data15", FlywheelOverLoad )
			end
		end
		
		NextButton	= ButtonsSidePanel:Add("DButton")
		NextButton:SetText("Edit Engine")
		NextButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		NextButton:SetPos(400,320)
		NextButton:SetWide(80)
		NextButton:SetTall(60)
		NextButton:SetDisabled(true)
		NextButton.DoClick = function()
			if ExitButtonMode == 1 then
				local CustomEngineTable = {}
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				for w in string.gmatch(GetFile, "([^,]+)") do
					table.insert(CustomEngineTable, w)
				end
				local NameLoad = tostring(CustomEngineTable[1])
				local SoundLoad = tostring(CustomEngineTable[2])
				local ModelLoad = tostring(CustomEngineTable[3])
				local FuelTypeLoad = tostring(CustomEngineTable[4])
				local EngineTypeLoad = tostring(CustomEngineTable[5])
				local TorqueLoad = tonumber(CustomEngineTable[6])
				local IdleLoad = tonumber(CustomEngineTable[7])
				local PeakMinLoad = tonumber(CustomEngineTable[8])
				local PeakMaxLoad = tonumber(CustomEngineTable[9])
				local LimitRpmLoad = tonumber(CustomEngineTable[10])
				local FlywheelLoad = tonumber(CustomEngineTable[11])
				local WeightLoad = tonumber(CustomEngineTable[12])
				local EngineSizeLoadT = tonumber(CustomEngineTable[13])
				local EngineTypeLoadText = tonumber(CustomEngineTable[14])
				local iSelectLoad = tostring(CustomEngineTable[15])
				local IsTransLoad = tostring(CustomEngineTable[16])
				local FlywheelOverLoad = tonumber(CustomEngineTable[17])
				local txt = NameLoad..","..SoundLoad..","..ModelLoad..","..FuelTypeLoad..","..EngineTypeLoad..","..TorqueLoad..","
				txt = txt ..IdleLoad..","..PeakMinLoad..","..PeakMaxLoad..","..LimitRpmLoad..","..FlywheelLoad..","..WeightLoad..","
				txt = txt ..EngineSizeLoadT..","..EngineTypeLoadText..","..iSelectLoad..","..IsTransLoad..","..FlywheelOverLoad
				file.CreateDir("acf")
				file.Write("acf/lastengine.txt", txt)
				RunConsoleCommand( "acfcustom_data1", NameLoad )
				RunConsoleCommand( "acf_menudata2", SoundLoad )
				RunConsoleCommand( "acf_menudata3", ModelLoad )
				RunConsoleCommand( "acf_menudata4", FuelTypeLoad )
				RunConsoleCommand( "acf_menudata5", EngineTypeLoad )
				RunConsoleCommand( "acfcustom_data6", TorqueLoad )
				RunConsoleCommand( "acfcustom_data7", IdleLoad )
				RunConsoleCommand( "acfcustom_data8", PeakMinLoad )
				RunConsoleCommand( "acfcustom_data9", PeakMaxLoad )
				RunConsoleCommand( "acfcustom_data10", LimitRpmLoad )
				RunConsoleCommand( "acfcustom_data11", FlywheelLoad )
				RunConsoleCommand( "acfcustom_data12", WeightLoad )
				RunConsoleCommand( "acfcustom_data13", iSelectLoad )
				RunConsoleCommand( "acfcustom_data14", IsTransLoad )
				RunConsoleCommand( "acfcustom_data15", FlywheelOverLoad )
				
				RunConsoleCommand("acf_enginecreateload_browser_open")
				SoundBrowserPanel:Close()
			end
		end
		
		
		DermaListView = ButtonsSidePanel:Add("DListView")
		DermaListView:SetParent(ButtonsSidePanel)
		DermaListView:SetPos(20, 50)
		DermaListView:SetSize(160, 250)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Files")
		
		for _, file in ipairs( file.Find("acf/custom.engines/*.txt", "DATA") ) do
			DermaListView:AddLine(tostring(file))
		end
		
		DermaListViewSpec = ButtonsSidePanel:Add("DListView")
		DermaListViewSpec:SetParent(ButtonsSidePanel)
		DermaListViewSpec:SetPos(200, 50)
		DermaListViewSpec:SetSize(160, 250)
		DermaListViewSpec:SetMultiSelect(false)
		DermaListViewSpec:AddColumn("Engines Infos")
		
		DisplayModel = ButtonsSidePanel:Add("DModelPanel")
		DisplayModel:SetModel( "" )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 12 )
		DisplayModel:SetSize( 200, 200 )
		DisplayModel:SetPos( 360, 60 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
		
		--On Clic
		DermaListView.OnClickLine = function(parent,selected,isselected)
			DermaListViewSpec:Clear()
			DisplayModel:SetModel( "" )
			ExitButtonMode = 0
			GetLineName = tostring(selected:GetValue(1))
			if GetLineName != "" then
				NextButton:SetDisabled(false)
				ExitButton:SetText("Use This Engine")
				ExitButton:SetToolTip("Dont forget to update the menu !")
				ExitButtonMode = 1
				local CustomEngineTable = {}
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				for w in string.gmatch(GetFile, "([^,]+)") do
					DermaListViewSpec:AddLine(tostring(w))
					table.insert(CustomEngineTable, w)
				end
				local ModelLoad = tostring(CustomEngineTable[3])
				DisplayModel:SetModel( ModelLoad )
			end
		end

	SoundBrowserPanel:InvalidateLayout(true)
	
end

local function OpenSoundBrowser(pl, cmd, args)
	if (!IsValid(SoundBrowserPanel)) then
		CreateSoundBrowser()
	end

	SoundBrowserPanel:SetVisible(true)
	SoundBrowserPanel:MakePopup()
	SoundBrowserPanel:InvalidateLayout(true)

	WireLib.Timedcall(function(SoundBrowserPanel)
		if (!IsValid(SoundBrowserPanel)) then return end

		SoundBrowserPanel:InvalidateLayout(true)
		
	end, SoundBrowserPanel)
end

concommand.Add("acf_engineload_browser_open", OpenSoundBrowser)