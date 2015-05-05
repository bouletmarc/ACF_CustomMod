--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(450, 400)
	
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))

	MainPanel:SetMinWidth(450)
	MainPanel:SetMinHeight(400)
	
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("Engine Menu V"..ACFCUSTOM.EngineMakerVersion.." - SETUP MENU")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(4, 4, 4, 4)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(430, 360)
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--Set local vars
		local FuelTypeValue = 0		--Petrol, Diesel, etc...
		local EngTypeValue = 0		--I4, I6, etc..
		local EngSizeValue = 0		--Small, Medium, Fat
		local MdlText = ""
		local iSelectVal = "false"
		local IsTransVal = "false"
		
		EngineNameTitle = SecondPanel:Add( "DLabel" )
		EngineNameTitle:SetText( "Engine Name :" )
		EngineNameTitle:SetFont( "DefaultBold" )
		EngineNameTitle:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		EngineNameTitle:SetPos( 20,10 )
		EngineNameTitle:SizeToContents()
		
		EngineName = SecondPanel:Add( "DTextEntry" )
		EngineName:SetText( "PUT NAME HERE" )
		EngineName:SetTextColor(Color(200,0,0,255))
		EngineName:SetPos( 20,30 )
		EngineName:SetWide( 120 )
		EngineName.OnTextChanged = function( )
			if EngineName:GetValue() == "" then
				EngineName:SetText( "PUT NAME HERE" )
				EngineName:SetTextColor(Color(200,0,0,255))
			else
				EngineName:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
			end
		end
		
		FuelTypeButton = SecondPanel:Add("DButton")
		FuelTypeButton:SetText("Petrol")
		FuelTypeButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FuelTypeButton:SetPos( 0, 60 )
		FuelTypeButton:SetWide( 60 )
		FuelTypeButton:SetTall( 40 )
		
		ModelsList = SecondPanel:Add("DComboBox")
		ModelsList:SetPos(70,70)
		ModelsList:SetSize( 120, 20 )
		ModelsList.OnSelect = function( panel, index, value )
			MdlText = "models/engines/"..tostring(value)
			EngineModel2:SetText( "Models :\n"..MdlText )
			EngineModel2:SizeToContents()
			DisplayModel:SetModel( MdlText )
		end
		
		--#######################
		EngineModel2 = SecondPanel:Add( "DLabel" )
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SetFont( "DefaultBold" )
		EngineModel2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		EngineModel2:SetPos( 180, 10 )
		EngineModel2:SizeToContents()
		
		--#### DISPLAY
		DisplayModel = SecondPanel:Add("DModelPanel")
		DisplayModel:SetModel( MdlText )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 12 )
		DisplayModel:SetSize( 200, 200 )
		DisplayModel:SetPos( 0, 120 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
		--########################
		--Side Text Entry Setup and Hint
		TorqueHint = SecondPanel:Add("DButton")
		TorqueHint:SetToolTip("This is your Torque amount value\nUse Small value for Small Engine(ex:75)\nUse Medium value for Medium Engine(ex:450)\nUse Big value for Big Engine(ex:2000)\nTake note Diesel and Turbine engines need\na bit bigger value than others engines")
		TorqueHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TorqueHint:SetWide(100)
		TorqueHint:SetTall(25)
		TorqueHint:SetPos( 210, 50 )
		TorqueHint:SetText("Torque Hint")
		
		TorqueEntry = SecondPanel:Add( "DTextEntry" )
		TorqueEntry:SetText( "Torque Number" )
		TorqueEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TorqueEntry:SetPos( 320, 50 )
		TorqueEntry:SetWide( 120 )
		
		IdleHint = SecondPanel:Add("DButton")
		IdleHint:SetToolTip("Use value between 500-2000 RPM\nFuel Engine Only")
		IdleHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		IdleHint:SetWide(100)
		IdleHint:SetTall(25)
		IdleHint:SetPos( 210, 90 )
		IdleHint:SetText("Idle RPM Hint")
		
		IdleEntry = SecondPanel:Add( "DTextEntry" )
		IdleEntry:SetText( "Idle Number" )
		IdleEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		IdleEntry:SetPos( 320, 90 )
		IdleEntry:SetWide( 120 )
		
		PeakMinHint = SecondPanel:Add("DButton")
		PeakMinHint:SetToolTip("Use value between 2000-4000 RPM\nFuel Engine Only")
		PeakMinHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMinHint:SetWide(100)
		PeakMinHint:SetTall(25)
		PeakMinHint:SetPos( 210, 130 )
		PeakMinHint:SetText("Peak Min RPM Hint")
		
		PeakMinEntry = SecondPanel:Add( "DTextEntry" )
		PeakMinEntry:SetText( "PeakMin RPM Number" )
		PeakMinEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMinEntry:SetPos( 320, 130 )
		PeakMinEntry:SetWide( 120 )
		
		PeakMaxHint = SecondPanel:Add("DButton")
		PeakMaxHint:SetToolTip("Use value between 4000-10000 RPM\nDONT use higher value than Limit RPM\nYou can use the same value as Limit RPM\nFuel Engine Only")
		PeakMaxHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMaxHint:SetWide(100)
		PeakMaxHint:SetTall(25)
		PeakMaxHint:SetPos( 210, 170 )
		PeakMaxHint:SetText("Peak Max RPM Hint")
		
		PeakMaxEntry = SecondPanel:Add( "DTextEntry" )
		PeakMaxEntry:SetText( "PeakMax RPM Number" )
		PeakMaxEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMaxEntry:SetPos( 320, 170 )
		PeakMaxEntry:SetWide( 120 )
		
		LimitHint = SecondPanel:Add("DButton")
		LimitHint:SetToolTip("Use value between 4500-10000 RPM\nDONT use lower value than PeakMax RPM\nYou can use the same value as PeakMax RPM")
		LimitHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		LimitHint:SetWide(100)
		LimitHint:SetTall(25)
		LimitHint:SetPos( 210, 210 )
		LimitHint:SetText("Limit RPM Hint")
		
		LimitEntry = SecondPanel:Add( "DTextEntry" )
		LimitEntry:SetText( "Limit RPM Number" )
		LimitEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		LimitEntry:SetPos( 320, 210 )
		LimitEntry:SetWide( 120 )
		
		FlywheelHint = SecondPanel:Add("DButton")
		FlywheelHint:SetToolTip("Use value between 0.01-1 with Petrol engines\nUse value between 0.5-10 with :\nDiesel engines\nElectric engines\nTurbine engines")
		FlywheelHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelHint:SetWide(100)
		FlywheelHint:SetTall(25)
		FlywheelHint:SetPos( 210, 250 )
		FlywheelHint:SetText("Flywheel Hint")
		
		FlywheelEntry = SecondPanel:Add( "DTextEntry" )
		FlywheelEntry:SetText( "Flywheel Number" )
		FlywheelEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelEntry:SetPos( 320, 250 )
		FlywheelEntry:SetWide( 120 )
		
		FlywheelOverHint = SecondPanel:Add("DButton")
		FlywheelOverHint:SetToolTip("Use value between 5000-10000\nOnly on Electrics and Turbines engines")
		FlywheelOverHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelOverHint:SetWide(100)
		FlywheelOverHint:SetTall(25)
		FlywheelOverHint:SetPos( 210, 290 )
		FlywheelOverHint:SetText("Override Hint")
		
		FlywheelOverEntry = SecondPanel:Add( "DTextEntry" )
		FlywheelOverEntry:SetText( "Override Number" )
		FlywheelOverEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelOverEntry:SetPos( 320, 290 )
		FlywheelOverEntry:SetWide( 120 )
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
		
		WeightHint = SecondPanel:Add("DButton")
		WeightHint:SetToolTip("Use value between 50-1000 for good Weight\nBigger your model are, bigger the number should be")
		WeightHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		WeightHint:SetWide(100)
		WeightHint:SetTall(25)
		WeightHint:SetPos( 210, 330 )
		WeightHint:SetText("Weight Hint")
		
		WeightEntry = SecondPanel:Add( "DTextEntry" )
		WeightEntry:SetText( "Weight Number" )
		WeightEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		WeightEntry:SetPos( 320, 330 )
		WeightEntry:SetWide( 120 )
		
		--Fuel Do clic
		FuelTypeButton.DoClick = function()
			if FuelTypeValue == 0 then
				FuelTypeValue = 1
				FuelTypeButton:SetText("Diesel")
			elseif FuelTypeValue == 1 then
				FuelTypeValue = 2
				FuelTypeButton:SetText("Electric")
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
				--Set True Value
				FlywheelOverEntry:SetDrawBackground(true)
				FlywheelOverEntry:SetEditable(true)
			elseif FuelTypeValue == 2 then
				FuelTypeValue = 3
				FuelTypeButton:SetText("Turbine")
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
				--Set True Value
				FlywheelOverEntry:SetDrawBackground(true)
				FlywheelOverEntry:SetEditable(true)
			elseif FuelTypeValue == 3 then
				FuelTypeValue = 0
				FuelTypeButton:SetText("Petrol")
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
				--Reset False Value
				FlywheelOverEntry:SetDrawBackground(false)
				FlywheelOverEntry:SetEditable(false)
				FlywheelOverEntry:SetText( "Override Number" )
			end
		end
		
		--Load all models
		local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
		ModelsList:SetValue(Name[1])
		MdlText = "models/engines/"..tostring(Name[1])
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SizeToContents()
		DisplayModel:SetModel( MdlText )
		for k, v in pairs(Name) do
			if not table.HasValue( { "linear_l.mdl", "linear_m.mdl", "linear_s.mdl", "t5large.mdl", "t5med.mdl", "t5small.mdl", "transaxial_l.mdl", "transaxial_m.mdl", "transaxial_s.mdl" }, v ) then
				ModelsList:AddChoice(v)
			end
		end
		
		--Back and Next Button
		BackButton	= SecondPanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BackButton:SetPos( 20, 320 )
		BackButton:SetWide(80)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginestart_open")
			MainPanel:Close()
		end
			
		NextButton	= SecondPanel:Add("DButton")
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
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
			RunConsoleCommand("acf_enginesound_open")
			MainPanel:Close()
		end

	MainPanel:InvalidateLayout(true)
	
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
concommand.Add("acf_enginecreate_open", OpenMenu)