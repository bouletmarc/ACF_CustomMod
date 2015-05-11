--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil

FuelTypeValue = 0		--Petrol, Diesel, etc...
EngTypeValue = 0		--I4, I6, etc..
EngSizeValue = 0		--Small, Medium, Fat
MdlText = ""
iSelectVal = "false"
IsTransVal = "false"
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(580, 400)
	
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))

	MainPanel:SetMinWidth(580)
	MainPanel:SetMinHeight(400)
	
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("Engine Menu V"..ACFCUSTOM.EngineMakerVersion.." - SETUP MENU")
	MainPanel:SetVisible(false)
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
		EngineNameTitle = SecondPanel:Add( "DLabel" )
		EngineNameTitle:SetText( "Engine Name :" )
		EngineNameTitle:SetFont( "DefaultBold" )
		EngineNameTitle:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		EngineNameTitle:SetPos( 5,0 )
		EngineNameTitle:SizeToContents()
		
		EngineName = SecondPanel:Add( "DTextEntry" )
		EngineName:SetText( "PUT NAME HERE" )
		EngineName:SetTextColor(Color(200,0,0,255))
		EngineName:SetPos( 5, 18 )
		EngineName:SetWide( 130 )
		EngineName.OnMousePressed = function( )
			EngineName:SetText( "" )
		end
		EngineName.OnTextChanged = function( )
			SetEngineName()
		end
		
		FuelTypeButton = SecondPanel:Add("DButton")
		FuelTypeButton:SetText("Petrol")
		FuelTypeButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FuelTypeButton:SetPos( 20, 60 )
		FuelTypeButton:SetWide( 140 )
		FuelTypeButton:SetTall( 30 )
		
		ModelsList = SecondPanel:Add("DListView")
		ModelsList:SetParent(SecondPanel)
		ModelsList:SetPos(415, 0)
		ModelsList:SetSize(145, 360)
		ModelsList:SetMultiSelect(false)
		ModelsList:AddColumn("Models")
		ModelsList.OnClickLine = function(parent,selected,isselected)
			GetLineName = tostring(selected:GetValue(1))
			if GetLineName != "" then
				SetEngineModel(GetLineName)
			end
		end
		
		EngineModel2 = SecondPanel:Add( "DLabel" )
		EngineModel2:SetText( "Models :\n\n"..MdlText )
		EngineModel2:SetFont( "DefaultBold" )
		EngineModel2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		EngineModel2:SetPos( 148, 0 )
		EngineModel2:SizeToContents()
		
		DisplayModel = SecondPanel:Add("DModelPanel")
		DisplayModel:SetModel( MdlText )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 12 )
		DisplayModel:SetSize( 200, 200 )
		DisplayModel:SetPos( 0, 120 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
		
		--Side Text Entry Setup and Hint
		TorqueHint = SecondPanel:Add("DButton")
		TorqueHint:SetToolTip("This is your Torque amount value\nUse Small value for Small Engine(ex:75)\nUse Medium value for Medium Engine(ex:450)\nUse Big value for Big Engine(ex:2000)\nTake note Diesel and Turbine engines need\na bit bigger value than others engines")
		TorqueHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TorqueHint:SetWide(100)
		TorqueHint:SetTall(25)
		TorqueHint:SetPos( 190, 50 )
		TorqueHint:SetText("Torque Hint")
		
		TorqueEntry = SecondPanel:Add( "DTextEntry" )
		TorqueEntry:SetText( "Torque Number" )
		TorqueEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TorqueEntry:SetPos( 295, 50 )
		TorqueEntry:SetWide( 115 )
		TorqueEntry.OnMousePressed = function( )
			TorqueEntry:SetText( "" )
		end
		TorqueEntry.OnTextChanged = function( )
			NumberCheck(tostring(TorqueEntry:GetValue()))
		end
		
		IdleHint = SecondPanel:Add("DButton")
		IdleHint:SetToolTip("Use value between 500-2000 RPM\nFuel Engine Only")
		IdleHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		IdleHint:SetWide(100)
		IdleHint:SetTall(25)
		IdleHint:SetPos( 190, 90 )
		IdleHint:SetText("Idle RPM Hint")
		
		IdleEntry = SecondPanel:Add( "DTextEntry" )
		IdleEntry:SetText( "Idle Number" )
		IdleEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		IdleEntry:SetPos( 295, 90 )
		IdleEntry:SetWide( 115 )
		IdleEntry.OnMousePressed = function( )
			IdleEntry:SetText( "" )
		end
		IdleEntry.OnTextChanged = function( )
			NumberCheck(tostring(IdleEntry:GetValue()))
		end
		
		PeakMinHint = SecondPanel:Add("DButton")
		PeakMinHint:SetToolTip("Use value between 2000-4000 RPM\nFuel Engine Only")
		PeakMinHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMinHint:SetWide(100)
		PeakMinHint:SetTall(25)
		PeakMinHint:SetPos( 190, 130 )
		PeakMinHint:SetText("Peak Min RPM Hint")
		
		PeakMinEntry = SecondPanel:Add( "DTextEntry" )
		PeakMinEntry:SetText( "PeakMin RPM Number" )
		PeakMinEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMinEntry:SetPos( 295, 130 )
		PeakMinEntry:SetWide( 115 )
		PeakMinEntry.OnMousePressed = function( )
			PeakMinEntry:SetText( "" )
		end
		PeakMinEntry.OnTextChanged = function( )
			NumberCheck(tostring(PeakMinEntry:GetValue()))
		end
		
		PeakMaxHint = SecondPanel:Add("DButton")
		PeakMaxHint:SetToolTip("Use value between 4000-10000 RPM\nDONT use higher value than Limit RPM\nYou can use the same value as Limit RPM\nFuel Engine Only")
		PeakMaxHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMaxHint:SetWide(100)
		PeakMaxHint:SetTall(25)
		PeakMaxHint:SetPos( 190, 170 )
		PeakMaxHint:SetText("Peak Max RPM Hint")
		
		PeakMaxEntry = SecondPanel:Add( "DTextEntry" )
		PeakMaxEntry:SetText( "PeakMax RPM Number" )
		PeakMaxEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		PeakMaxEntry:SetPos( 295, 170 )
		PeakMaxEntry:SetWide( 115 )
		PeakMaxEntry.OnMousePressed = function( )
			PeakMaxEntry:SetText( "" )
		end
		PeakMaxEntry.OnTextChanged = function( )
			NumberCheck(tostring(PeakMaxEntry:GetValue()))
		end
		
		LimitHint = SecondPanel:Add("DButton")
		LimitHint:SetToolTip("Use value between 4500-10000 RPM\nDONT use lower value than PeakMax RPM\nYou can use the same value as PeakMax RPM")
		LimitHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		LimitHint:SetWide(100)
		LimitHint:SetTall(25)
		LimitHint:SetPos( 190, 210 )
		LimitHint:SetText("Limit RPM Hint")
		
		LimitEntry = SecondPanel:Add( "DTextEntry" )
		LimitEntry:SetText( "Limit RPM Number" )
		LimitEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		LimitEntry:SetPos( 295, 210 )
		LimitEntry:SetWide( 115 )
		LimitEntry.OnMousePressed = function( )
			LimitEntry:SetText( "" )
		end
		LimitEntry.OnTextChanged = function( )
			NumberCheck(tostring(LimitEntry:GetValue()))
		end
		
		FlywheelHint = SecondPanel:Add("DButton")
		FlywheelHint:SetToolTip("Use value between 0.01-1 with Petrol engines\nUse value between 0.5-10 with :\nDiesel engines\nElectric engines\nTurbine engines")
		FlywheelHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelHint:SetWide(100)
		FlywheelHint:SetTall(25)
		FlywheelHint:SetPos( 190, 250 )
		FlywheelHint:SetText("Flywheel Hint")
		
		FlywheelEntry = SecondPanel:Add( "DTextEntry" )
		FlywheelEntry:SetText( "Flywheel Number" )
		FlywheelEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelEntry:SetPos( 295, 250 )
		FlywheelEntry:SetWide( 115 )
		FlywheelEntry.OnMousePressed = function( )
			FlywheelEntry:SetText( "" )
		end
		FlywheelEntry.OnTextChanged = function( )
			NumberCheck(tostring(FlywheelEntry:GetValue()))
		end
		
		FlywheelOverHint = SecondPanel:Add("DButton")
		FlywheelOverHint:SetToolTip("Use value between 5000-10000\nOnly on Electrics and Turbines engines")
		FlywheelOverHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelOverHint:SetWide(100)
		FlywheelOverHint:SetTall(25)
		FlywheelOverHint:SetPos( 190, 290 )
		FlywheelOverHint:SetText("Override Hint")
		
		FlywheelOverEntry = SecondPanel:Add( "DTextEntry" )
		FlywheelOverEntry:SetText( "Override Number" )
		FlywheelOverEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		FlywheelOverEntry:SetPos( 295, 290 )
		FlywheelOverEntry:SetWide( 115 )
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
		FlywheelOverEntry.OnMousePressed = function( )
			FlywheelOverEntry:SetText( "" )
		end
		FlywheelOverEntry.OnTextChanged = function( )
			NumberCheck(tostring(FlywheelOverEntry:GetValue()))
		end
		
		WeightHint = SecondPanel:Add("DButton")
		WeightHint:SetToolTip("Use value between 50-1000 for good Weight\nBigger your model are, bigger the number should be")
		WeightHint:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		WeightHint:SetWide(100)
		WeightHint:SetTall(25)
		WeightHint:SetPos( 190, 330 )
		WeightHint:SetText("Weight Hint")
		
		WeightEntry = SecondPanel:Add( "DTextEntry" )
		WeightEntry:SetText( "Weight Number" )
		WeightEntry:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		WeightEntry:SetPos( 295, 330 )
		WeightEntry:SetWide( 115 )
		WeightEntry.OnMousePressed = function( )
			WeightEntry:SetText( "" )
		end
		WeightEntry.OnTextChanged = function( )
			NumberCheck(tostring(WeightEntry:GetValue()))
		end
		
		--Fuel Do clic
		FuelTypeButton.DoClick = function()
			SetEngineFuelType()
		end
		
		--Back and Next Button
		BackButton	= SecondPanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BackButton:SetPos( 5, 315 )
		BackButton:SetWide(80)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginestart_open")
			MainPanel:Close()
		end
			
		NextButton	= SecondPanel:Add("DButton")
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		NextButton:SetPos( 100, 315 )
		NextButton:SetWide(80)
		NextButton:SetTall( 40 )
		NextButton.DoClick = function()
			if SaveAndNextStep() then
				RunConsoleCommand("acf_enginesound_open")
				MainPanel:Close()
			else
				notification.AddLegacy("CAN'T GO TO NEXT PAGE - ERROR(S) FOUND", NOTIFY_ERROR, 5)
			end
		end
		
		--load all models list
		LoadAllModels()
		
		if not EngineMakerUseLoad then
			local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
			MdlText = "models/engines/"..tostring(Name[1])
			EngineModel2:SetText( "Models :\n"..MdlText )
			EngineModel2:SizeToContents()
			DisplayModel:SetModel( MdlText )
			ModelsList:SelectFirstItem()
		--RELOAD IF USED OPTION LOAD OR EDIT LAST ENGINE
		else
			ReloadLastEngine()
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