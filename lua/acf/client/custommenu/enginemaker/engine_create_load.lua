// Made by Bouletmarc.

local StartBrowserPanel = nil

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
	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetSize(450, 400)
	--Set Center
	StartBrowserPanel:SetPos((ScrW()/2)-(StartBrowserPanel:GetWide()/2),(ScrH()/2)-(StartBrowserPanel:GetTall()/2))

	StartBrowserPanel:SetMinWidth(450)
	StartBrowserPanel:SetMinHeight(400)
	
	StartBrowserPanel:SetSizable(false)
	StartBrowserPanel:SetDeleteOnClose( true )
	StartBrowserPanel:SetTitle("Engine Menu V8.5 - SETUP MENU")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel")
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(430, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################
		local FuelTypeValue = 0		--Petrol, Diesel, etc...
		local EngTypeValue = 0		--I4, I6, etc..
		local EngSizeValue = 0		--Small, Medium, Fat
		local MdlText = ""
		local iSelectVal = "false"
		local IsTransVal = "false"
		RunConsoleCommand( "acfmenu_data4", "Petrol" )
		RunConsoleCommand( "acfmenu_data5", "GenericPetrol" )
		RunConsoleCommand( "acfmenu_data13", "false" )
		RunConsoleCommand( "acfmenu_data14", "false" )
		
		EngineNameTitle = ButtonsSidePanel:Add( "DLabel" )
		EngineNameTitle:SetText( "Engine Name :" )
		EngineNameTitle:SetFont( "DefaultBold" )
		EngineNameTitle:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		EngineNameTitle:SetPos( 20,10 )
		EngineNameTitle:SizeToContents()
		
		EngineName = ButtonsSidePanel:Add( "DTextEntry" )
		EngineName:SetText( "PUT NAME HERE" )
		EngineName:SetTextColor(Color(200,0,0,255))
		EngineName:SetPos( 20,30 )
		EngineName:SetWide( 120 )
		EngineName.OnTextChanged = function( )
			if EngineName:GetValue() == "" then
				EngineName:SetText( "PUT NAME HERE" )
				EngineName:SetTextColor(Color(200,0,0,255))
			else
				RunConsoleCommand( "acfmenu_data1", EngineName:GetValue() )
				EngineName:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
			end
		end
		
		FuelTypeButton = ButtonsSidePanel:Add("DButton")
		FuelTypeButton:SetText("Petrol")
		FuelTypeButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		FuelTypeButton:SetPos( 0, 60 )
		FuelTypeButton:SetWide( 60 )
		FuelTypeButton:SetTall( 40 )
		
		ModelsList = ButtonsSidePanel:Add("DComboBox")
		ModelsList:SetPos(70,70)
		ModelsList:SetSize( 120, 20 )
		ModelsList.OnSelect = function( panel, index, value )
			MdlText = "models/engines/"..tostring(value)
			EngineModel2:SetText( "Models :\n"..MdlText )
			EngineModel2:SizeToContents()
			DisplayModel:SetModel( MdlText )
			RunConsoleCommand("acf_menudata3", MdlText)
		end
		
		--#######################
		EngineModel2 = ButtonsSidePanel:Add( "DLabel" )
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SetFont( "DefaultBold" )
		EngineModel2:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		EngineModel2:SetPos( 180, 10 )
		EngineModel2:SizeToContents()
		
		--#### DISPLAY
		DisplayModel = ButtonsSidePanel:Add("DModelPanel")
		DisplayModel:SetModel( MdlText )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 12 )
		DisplayModel:SetSize( 200, 200 )
		DisplayModel:SetPos( 0, 120 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
		--########################
		--Side Text Entry Setup and Hint
		TorqueHint = ButtonsSidePanel:Add("DButton")
		TorqueHint:SetToolTip("This is your Torque amount value\nUse Small value for Small Engine(ex:75)\nUse Medium value for Medium Engine(ex:450)\nUse Big value for Big Engine(ex:2000)\nTake note Diesel and Turbine engines need\na bit bigger value than others engines")
		TorqueHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		TorqueHint:SetWide(100)
		TorqueHint:SetTall(25)
		TorqueHint:SetPos( 210, 50 )
		TorqueHint:SetText("Torque Hint")
		
		TorqueEntry = ButtonsSidePanel:Add( "DTextEntry" )
		TorqueEntry:SetText( "Torque Number" )
		TorqueEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		TorqueEntry:SetPos( 320, 50 )
		TorqueEntry:SetWide( 120 )
		TorqueEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data6", TorqueEntry:GetValue() )
		end
		
		IdleHint = ButtonsSidePanel:Add("DButton")
		IdleHint:SetToolTip("Use value between 500-2000 RPM\nFuel Engine Only")
		IdleHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		IdleHint:SetWide(100)
		IdleHint:SetTall(25)
		IdleHint:SetPos( 210, 90 )
		IdleHint:SetText("Idle RPM Hint")
		
		IdleEntry = ButtonsSidePanel:Add( "DTextEntry" )
		IdleEntry:SetText( "Idle Number" )
		IdleEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		IdleEntry:SetPos( 320, 90 )
		IdleEntry:SetWide( 120 )
		IdleEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data7", IdleEntry:GetValue() )
		end
		
		PeakMinHint = ButtonsSidePanel:Add("DButton")
		PeakMinHint:SetToolTip("Use value between 2000-4000 RPM\nFuel Engine Only")
		PeakMinHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		PeakMinHint:SetWide(100)
		PeakMinHint:SetTall(25)
		PeakMinHint:SetPos( 210, 130 )
		PeakMinHint:SetText("Peak Min RPM Hint")
		
		PeakMinEntry = ButtonsSidePanel:Add( "DTextEntry" )
		PeakMinEntry:SetText( "PeakMin RPM Number" )
		PeakMinEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		PeakMinEntry:SetPos( 320, 130 )
		PeakMinEntry:SetWide( 120 )
		PeakMinEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data8", PeakMinEntry:GetValue() )
		end
		
		PeakMaxHint = ButtonsSidePanel:Add("DButton")
		PeakMaxHint:SetToolTip("Use value between 4000-10000 RPM\nDONT use higher value than Limit RPM\nYou can use the same value as Limit RPM\nFuel Engine Only")
		PeakMaxHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		PeakMaxHint:SetWide(100)
		PeakMaxHint:SetTall(25)
		PeakMaxHint:SetPos( 210, 170 )
		PeakMaxHint:SetText("Peak Max RPM Hint")
		
		PeakMaxEntry = ButtonsSidePanel:Add( "DTextEntry" )
		PeakMaxEntry:SetText( "PeakMax RPM Number" )
		PeakMaxEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		PeakMaxEntry:SetPos( 320, 170 )
		PeakMaxEntry:SetWide( 120 )
		PeakMaxEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data9", PeakMaxEntry:GetValue() )
		end
		
		LimitHint = ButtonsSidePanel:Add("DButton")
		LimitHint:SetToolTip("Use value between 4500-10000 RPM\nDONT use lower value than PeakMax RPM\nYou can use the same value as PeakMax RPM")
		LimitHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		LimitHint:SetWide(100)
		LimitHint:SetTall(25)
		LimitHint:SetPos( 210, 210 )
		LimitHint:SetText("Limit RPM Hint")
		
		LimitEntry = ButtonsSidePanel:Add( "DTextEntry" )
		LimitEntry:SetText( "Limit RPM Number" )
		LimitEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		LimitEntry:SetPos( 320, 210 )
		LimitEntry:SetWide( 120 )
		LimitEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data10", LimitEntry:GetValue() )
		end
		
		FlywheelHint = ButtonsSidePanel:Add("DButton")
		FlywheelHint:SetToolTip("Use value between 0.01-1 with Petrol engines\nUse value between 0.5-10 with :\nDiesel engines\nElectric engines\nTurbine engines")
		FlywheelHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		FlywheelHint:SetWide(100)
		FlywheelHint:SetTall(25)
		FlywheelHint:SetPos( 210, 250 )
		FlywheelHint:SetText("Flywheel Hint")
		
		FlywheelEntry = ButtonsSidePanel:Add( "DTextEntry" )
		FlywheelEntry:SetText( "Flywheel Number" )
		FlywheelEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		FlywheelEntry:SetPos( 320, 250 )
		FlywheelEntry:SetWide( 120 )
		FlywheelEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data11", FlywheelEntry:GetValue() )
		end
		
		FlywheelOverHint = ButtonsSidePanel:Add("DButton")
		FlywheelOverHint:SetToolTip("Use value between 5000-10000\nOnly on Electrics and Turbines engines")
		FlywheelOverHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		FlywheelOverHint:SetWide(100)
		FlywheelOverHint:SetTall(25)
		FlywheelOverHint:SetPos( 210, 290 )
		FlywheelOverHint:SetText("Override Hint")
		
		FlywheelOverEntry = ButtonsSidePanel:Add( "DTextEntry" )
		FlywheelOverEntry:SetText( "Override Number" )
		FlywheelOverEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		FlywheelOverEntry:SetPos( 320, 290 )
		FlywheelOverEntry:SetWide( 120 )
		FlywheelOverEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data15", FlywheelOverEntry:GetValue() )
		end
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
		
		WeightHint = ButtonsSidePanel:Add("DButton")
		WeightHint:SetToolTip("Use value between 50-1000 for good Weight\nBigger your model are, bigger the number should be")
		WeightHint:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WeightHint:SetWide(100)
		WeightHint:SetTall(25)
		WeightHint:SetPos( 210, 330 )
		WeightHint:SetText("Weight Hint")
		
		WeightEntry = ButtonsSidePanel:Add( "DTextEntry" )
		WeightEntry:SetText( "Weight Number" )
		WeightEntry:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		WeightEntry:SetPos( 320, 330 )
		WeightEntry:SetWide( 120 )
		WeightEntry.OnTextChanged = function( )
			RunConsoleCommand( "acfmenu_data12", WeightEntry:GetValue() )
		end
		--#######################
		--Fuel Do clic
		FuelTypeButton.DoClick = function()
			if FuelTypeValue == 0 then
				FuelTypeValue = 1
				FuelTypeButton:SetText("Diesel")
				RunConsoleCommand( "acfmenu_data4", "Diesel" )
				RunConsoleCommand( "acfmenu_data5", "GenericDiesel" )
			elseif FuelTypeValue == 1 then
				FuelTypeValue = 2
				FuelTypeButton:SetText("Electric")
				RunConsoleCommand( "acfmenu_data4", "Electric" )
				RunConsoleCommand( "acfmenu_data5", "Electric" )
				RunConsoleCommand( "acfmenu_data13", "true" )
				RunConsoleCommand( "acfmenu_data14", "false" )
				iSelectVal = "true"
				IsTransVal = "false"
				--Set False Values
				IdleEntry:SetText( "10" )
				PeakMinEntry:SetText( "10" )
				PeakMaxEntry:SetText( "10" )
				IdleEntry:SetEditable(false)
				PeakMinEntry:SetEditable(false)
				PeakMaxEntry:SetEditable(false)
				IdleEntry:SetDrawBackground(false)
				PeakMinEntry:SetDrawBackground(false)
				PeakMaxEntry:SetDrawBackground(false)
				RunConsoleCommand( "acfmenu_data7", 10 )
				RunConsoleCommand( "acfmenu_data8", 10 )
				RunConsoleCommand( "acfmenu_data9", 10 )
				--Set True Value
				FlywheelOverEntry:SetDrawBackground(true)
				FlywheelOverEntry:SetEditable(true)
			elseif FuelTypeValue == 2 then
				FuelTypeValue = 3
				FuelTypeButton:SetText("Turbine")
				RunConsoleCommand( "acfmenu_data4", "Any" )
				RunConsoleCommand( "acfmenu_data5", "Turbine" )
				RunConsoleCommand( "acfmenu_data13", "true" )
				RunConsoleCommand( "acfmenu_data14", "true" )
				iSelectVal = "true"
				IsTransVal = "true"
				--Set False Values
				IdleEntry:SetText( "1" )
				PeakMinEntry:SetText( "1" )
				PeakMaxEntry:SetText( "1" )
				IdleEntry:SetEditable(false)
				PeakMinEntry:SetEditable(false)
				PeakMaxEntry:SetEditable(false)
				IdleEntry:SetDrawBackground(false)
				PeakMinEntry:SetDrawBackground(false)
				PeakMaxEntry:SetDrawBackground(false)
				RunConsoleCommand( "acfmenu_data7", 1 )
				RunConsoleCommand( "acfmenu_data8", 1 )
				RunConsoleCommand( "acfmenu_data9", 1 )
				--Set True Value
				FlywheelOverEntry:SetDrawBackground(true)
				FlywheelOverEntry:SetEditable(true)
			elseif FuelTypeValue == 3 then
				FuelTypeValue = 0
				FuelTypeButton:SetText("Petrol")
				RunConsoleCommand( "acfmenu_data4", "Petrol" )
				RunConsoleCommand( "acfmenu_data5", "GenericPetrol" )
				RunConsoleCommand( "acfmenu_data13", "false" )
				RunConsoleCommand( "acfmenu_data14", "false" )
				iSelectVal = "false"
				IsTransVal = "false"
				--Reset True Value
				IdleEntry:SetText( "Idle Number" )
				PeakMinEntry:SetText( "PeakMin RPM Number" )
				PeakMaxEntry:SetText( "PeakMax RPM Number" )
				IdleEntry:SetEditable(true)
				PeakMinEntry:SetEditable(true)
				PeakMaxEntry:SetEditable(true)
				IdleEntry:SetDrawBackground(true)
				PeakMinEntry:SetDrawBackground(true)
				PeakMaxEntry:SetDrawBackground(true)
				RunConsoleCommand( "acfmenu_data7", 500 )
				RunConsoleCommand( "acfmenu_data8", 1200 )
				RunConsoleCommand( "acfmenu_data9", 3500 )
				--Reset False Value
				FlywheelOverEntry:SetDrawBackground(false)
				FlywheelOverEntry:SetEditable(false)
				FlywheelOverEntry:SetText( "Override Number" )
			end
		end
		
		
		--########################
		--Back and Next Button
		BackButton	= ButtonsSidePanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		BackButton:SetPos( 20, 320 )
		BackButton:SetWide(80)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginestart_browser_open")
			StartBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton")
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(Redcolor,Greencolor,Bluecolor,255))
		NextButton:SetPos( 120, 320 )
		NextButton:SetWide(80)
		NextButton:SetTall( 40 )
		NextButton.DoClick = function()
			--Save and Next
			local NameLoadT = EngineName:GetValue()
			local FuelTypeLoadT = ""
			local EngineTypeLoadT = ""
			local TorqueLoadT = TorqueEntry:GetValue()
			local IdleLoadT = IdleEntry:GetValue()
			local PeakMinLoadT = PeakMinEntry:GetValue()
			local PeakMaxLoadT = PeakMaxEntry:GetValue()
			local LimitRpmLoadT = LimitEntry:GetValue()
			local FlywheelLoadT = FlywheelEntry:GetValue()
			local WeightLoadT = WeightEntry:GetValue()
			local FlywheelOverLoad = FlywheelOverEntry:GetValue()
			local FlywheelOverLoadT = 0
			local BadValues = 0
			
			if FlywheelOverLoad == "Override Number" then FlywheelOverLoadT = 0 else FlywheelOverLoadT = FlywheelOverLoad end
			
			local EngineLast = file.Read("acf/lastengine.txt", "DATA")
			local EngineLastTable = {}
			for w in string.gmatch(EngineLast, "([^,]+)") do
				table.insert(EngineLastTable, w)
			end
			local SoundLoadT = tostring(EngineLastTable[2])
			
			if FuelTypeValue == 0 then
				FuelTypeLoadT = "Petrol"
				EngineTypeLoadT = "GenericPetrol"
			elseif FuelTypeValue == 1 then
				FuelTypeLoadT = "Diesel"
				EngineTypeLoadT = "GenericDiesel"
			elseif FuelTypeValue == 2 then
				FuelTypeLoadT = "Electric"
				EngineTypeLoadT = "Electric"
			elseif FuelTypeValue == 3 then
				FuelTypeLoadT = "Any"
				EngineTypeLoadT = "Turbine"
			end
			local txt = NameLoadT..","..SoundLoadT..","..MdlText..","..FuelTypeLoadT..","..EngineTypeLoadT..","..TorqueLoadT..","
			txt = txt ..IdleLoadT..","..PeakMinLoadT..","..PeakMaxLoadT..","..LimitRpmLoadT..","..FlywheelLoadT..","..WeightLoadT..","
			txt = txt ..EngSizeValue..","..EngTypeValue..","..iSelectVal..","..IsTransVal..","..FlywheelOverLoadT
			file.Write("acf/lastengine.txt", txt)
			RunConsoleCommand("acf_enginesound_browser_open")
			StartBrowserPanel:Close()
		end
		
	--Reload Values, used for engine Loading or Menu Back Button
	--Load all models
	local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
	for k, v in pairs(Name) do
		ModelsList:AddChoice(v)
	end
		
	local CustomEngineTable = {}
	local GetFile = file.Read("acf/lastengine.txt", "DATA")
	for w in string.gmatch(GetFile, "([^,]+)") do
		table.insert(CustomEngineTable, w)
	end
	NameLoad = tostring(CustomEngineTable[1])
	ModelLoad = tostring(CustomEngineTable[3])
	FuelTypeLoad = tostring(CustomEngineTable[4])
	EngineTypeLoad = tostring(CustomEngineTable[5])
	TorqueLoad = tonumber(CustomEngineTable[6])
	IdleLoad = tonumber(CustomEngineTable[7])
	PeakMinLoad = tonumber(CustomEngineTable[8])
	PeakMaxLoad = tonumber(CustomEngineTable[9])
	LimitRpmLoad = tonumber(CustomEngineTable[10])
	FlywheelLoad = tonumber(CustomEngineTable[11])
	WeightLoad = tonumber(CustomEngineTable[12])
	ModelSizeMenu = tonumber(CustomEngineTable[13])
	ModelTypeMenu = tonumber(CustomEngineTable[14])
	iSelectLoad = tostring(CustomEngineTable[15])
	IsTransLoad = tostring(CustomEngineTable[16])
	FlywheelOverNumber = tonumber(CustomEngineTable[17])
	
	ModelsList:SetValue(ModelLoad)
	--Set Fuel Type
	if FuelTypeLoad == "Petrol" then
		FuelTypeValue = 0
	elseif FuelTypeLoad == "Diesel" then
		FuelTypeValue = 1
	elseif FuelTypeLoad == "Electric" then
		FuelTypeValue = 2
		IdleEntry:SetEditable(false)
		PeakMinEntry:SetEditable(false)
		PeakMaxEntry:SetEditable(false)
		IdleEntry:SetDrawBackground(false)
		PeakMinEntry:SetDrawBackground(false)
		PeakMaxEntry:SetDrawBackground(false)
	elseif FuelTypeLoad == "Any" then
		IdleEntry:SetEditable(false)
		PeakMinEntry:SetEditable(false)
		PeakMaxEntry:SetEditable(false)
		IdleEntry:SetDrawBackground(false)
		PeakMinEntry:SetDrawBackground(false)
		PeakMaxEntry:SetDrawBackground(false)
		FuelTypeValue = 3
	end
	--Set Engine Type
	if iSelectLoad == "true" and IsTransLoad == "false" then	--Set Electric
		FlywheelOverEntry:SetDrawBackground(true)
		FlywheelOverEntry:SetEditable(true)
		FlywheelOverEntry:SetText( FlywheelOverNumber )
	elseif iSelectLoad == "true" and IsTransLoad == "true" then	--Set Turbine
		FlywheelOverEntry:SetDrawBackground(true)
		FlywheelOverEntry:SetEditable(true)
		FlywheelOverEntry:SetText( FlywheelOverNumber )
	else	--Set Engine Models
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
		FlywheelOverEntry:SetText( "Override Number" )
	end
	--Set Values
	EngineName:SetText(NameLoad)
	FuelTypeButton:SetText(FuelTypeLoad)
	EngineModel2:SetText( "Models :\n"..ModelLoad )
	EngineModel2:SizeToContents()
	DisplayModel:SetModel( ModelLoad )
	TorqueEntry:SetText( TorqueLoad )
	IdleEntry:SetText( IdleLoad )
	PeakMinEntry:SetText( PeakMinLoad )
	PeakMaxEntry:SetText( PeakMaxLoad )
	LimitEntry:SetText( LimitRpmLoad )
	FlywheelEntry:SetText( FlywheelLoad )
	WeightEntry:SetText( WeightLoad )
	iSelectVal = iSelectLoad
	IsTransVal = IsTransLoad
	MdlText = ModelLoad
	--######

	StartBrowserPanel.OnClose = function() end

	StartBrowserPanel:InvalidateLayout(true)
	
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

concommand.Add("acf_enginecreateload_browser_open", OpenSartBrowser)