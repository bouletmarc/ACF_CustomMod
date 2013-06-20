// Made by Bouletmarc.

local StartBrowserPanel = nil

--model functions
local function SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
			if Eng2 == "" then
				MdlText = "Choose a model first"
				EngineModel:SetTextColor(Color(200,0,0,255))
				EngineModel:SetText( MdlText )
			else
				MdlText = "models/engines/"..Eng1..Eng2..".mdl"
				EngineModel:SetTextColor(Color(0,0,200,255))
				EngineModel:SetText( MdlText )
				DisplayModel:SetModel( MdlText )
				RunConsoleCommand("wire_soundemitter_model", MdlText)
			end
			
			if CheckBoxEng:GetChecked()==false and CheckBoxEng2:GetChecked()==false and CheckBoxEng3:GetChecked()==false and CheckBoxEng4:GetChecked()==false and CheckBoxEng5:GetChecked()==false and CheckBoxEng6:GetChecked()==false and CheckBoxEng7:GetChecked()==false and CheckBoxEng8:GetChecked()==false then
					CheckBoxEng:SetTextColor(Color(200,0,0,255))
					CheckBoxEng2:SetTextColor(Color(200,0,0,255))
					CheckBoxEng3:SetTextColor(Color(200,0,0,255))
					CheckBoxEng4:SetTextColor(Color(200,0,0,255))
					CheckBoxEng5:SetTextColor(Color(200,0,0,255))
					CheckBoxEng6:SetTextColor(Color(200,0,0,255))
					CheckBoxEng7:SetTextColor(Color(200,0,0,255))
					CheckBoxEng8:SetTextColor(Color(200,0,0,255))
				else
					CheckBoxEng:SetTextColor(Color(0,0,200,255))
					CheckBoxEng2:SetTextColor(Color(0,0,200,255))
					CheckBoxEng3:SetTextColor(Color(0,0,200,255))
					CheckBoxEng4:SetTextColor(Color(0,0,200,255))
					CheckBoxEng5:SetTextColor(Color(0,0,200,255))
					CheckBoxEng6:SetTextColor(Color(0,0,200,255))
					CheckBoxEng7:SetTextColor(Color(0,0,200,255))
					CheckBoxEng8:SetTextColor(Color(0,0,200,255))
				end
end

--Size functions
local function SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
				if Eng1 == "" then
					MdlText = "Choose a model first"
					EngineModel:SetTextColor(Color(200,0,0,255))
					EngineModel:SetText( MdlText )
				else
					MdlText = "models/engines/"..Eng1..Eng2..".mdl"
					EngineModel:SetTextColor(Color(0,0,200,255))
					EngineModel:SetText( MdlText )
					DisplayModel:SetModel( MdlText )
					RunConsoleCommand("wire_soundemitter_model", MdlText)
				end
				if CheckBoxSize:GetChecked()==false and CheckBoxSize2:GetChecked()==false and CheckBoxSize3:GetChecked()==false then
					CheckBoxSize:SetTextColor(Color(200,0,0,255))
					CheckBoxSize2:SetTextColor(Color(200,0,0,255))
					CheckBoxSize3:SetTextColor(Color(200,0,0,255))
				else
					CheckBoxSize:SetTextColor(Color(0,0,200,255))
					CheckBoxSize2:SetTextColor(Color(0,0,200,255))
					CheckBoxSize3:SetTextColor(Color(0,0,200,255))
				end
end

// Open the Sound Browser.
local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetPos(350,125)
	StartBrowserPanel:SetSize(250, 400)

	StartBrowserPanel:SetMinWidth(250)
	StartBrowserPanel:SetMinHeight(400)
	
	StartBrowserPanel:SetDeleteOnClose( false )
	StartBrowserPanel:SetTitle("Engine Menu V3.3 - SETUP MENU")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################	 MODEL
		EngineNameTitle = ButtonsSidePanel:Add( "DLabel" )
			EngineNameTitle:SetText( "Engine Name :" )
			EngineNameTitle:SetFont( "DefaultBold" )
			EngineNameTitle:SetTextColor(Color(0,0,200,255))
			EngineNameTitle:SetPos( 20,10 )
			EngineNameTitle:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		
		EngineName = ButtonsSidePanel:Add( "DTextEntry" )
			EngineName:SetText( "PUT NAME HERE" )
			EngineName:SetTextColor(Color(200,0,0,255))
			EngineName:SetPos( 20,30 )
			EngineName:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
			EngineName.OnTextChanged = function( )
				if EngineName:GetValue() == "" then
					EngineName:SetText( "PUT NAME HERE" )
					EngineName:SetTextColor(Color(200,0,0,255))
				else
					RunConsoleCommand( "acfmenu_data10", EngineName:GetValue() )
					EngineName:SetTextColor(Color(0,0,200,255))
				end
			end
			
		local Eng1 = ""
		local Eng2 = ""
		local MdlText = "Choose a model first"
		
		EngineType = ButtonsSidePanel:Add( "DLabel" )
			EngineType:SetText( "Engine Type :" )
			EngineType:SetFont( "DefaultBold" )
			EngineType:SetTextColor(Color(0,0,200,255))
			EngineType:SetPos( 20,70 )
			EngineType:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		
		CheckBoxEng = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng:SetPos( 20,90 )
			CheckBoxEng:SetText( "I4" )
			CheckBoxEng:SetTextColor(Color(0,0,200,255))
			CheckBoxEng:SetChecked( false )
			CheckBoxEng.OnChange = function( )
				Eng1 = "inline4"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "small" then Eng2 = "s" end
				if Eng2 == "med" then Eng2 = "m" end
				if Eng2 == "large" then Eng2 = "l" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
		CheckBoxEng2 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng2:SetPos( 20,110 )
			CheckBoxEng2:SetText( "I6" )
			CheckBoxEng2:SetTextColor(Color(0,0,200,255))
			CheckBoxEng2:SetChecked( false )
			CheckBoxEng2.OnChange = function( )
				Eng1 = "inline6"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "small" then Eng2 = "s" end
				if Eng2 == "med" then Eng2 = "m" end
				if Eng2 == "large" then Eng2 = "l" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
		CheckBoxEng3 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng3:SetPos( 80,90 )
			CheckBoxEng3:SetText( "V6" )
			CheckBoxEng3:SetTextColor(Color(0,0,200,255))
			CheckBoxEng3:SetChecked( false )
			CheckBoxEng3.OnChange = function( )
				Eng1 = "v6"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "s" then Eng2 = "small" end
				if Eng2 == "m" then Eng2 = "med" end
				if Eng2 == "l" then Eng2 = "large" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
		CheckBoxEng4 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng4:SetPos( 80,110 )
			CheckBoxEng4:SetText( "V8" )
			CheckBoxEng4:SetTextColor(Color(0,0,200,255))
			CheckBoxEng4:SetChecked( false )
			CheckBoxEng4.OnChange = function( )
				Eng1 = "v8"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "small" then Eng2 = "s" end
				if Eng2 == "med" then Eng2 = "m" end
				if Eng2 == "large" then Eng2 = "l" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
		CheckBoxEng5 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng5:SetPos( 140,90 )
			CheckBoxEng5:SetText( "V12" )
			CheckBoxEng5:SetTextColor(Color(0,0,200,255))
			CheckBoxEng5:SetChecked( false )
			CheckBoxEng5.OnChange = function( )
				Eng1 = "v12"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "small" then Eng2 = "s" end
				if Eng2 == "med" then Eng2 = "m" end
				if Eng2 == "large" then Eng2 = "l" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
		CheckBoxEng6 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng6:SetPos( 140,110 )
			CheckBoxEng6:SetText( "Rotary" )
			CheckBoxEng6:SetTextColor(Color(0,0,200,255))
			CheckBoxEng6:SetChecked( false )
			CheckBoxEng6.OnChange = function( )
				Eng1 = "wankel"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "s" then Eng2 = "small" end
				if Eng2 == "m" then Eng2 = "med" end
				if Eng2 == "l" then Eng2 = "large" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
			
		CheckBoxEng7 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng7:SetPos( 20,130 )
			CheckBoxEng7:SetText( "B4" )
			CheckBoxEng7:SetTextColor(Color(0,0,200,255))
			CheckBoxEng7:SetChecked( false )
			CheckBoxEng7.OnChange = function( )
				Eng1 = "b4"
				CheckBoxSize3:SetDisabled( true )
				if Eng2 == "s" then Eng2 = "small" end
				if Eng2 == "m" then Eng2 = "med" end
				if Eng2 == "l" or Eng2 == "large" then 
					Eng2 = "med" 
					CheckBoxSize3:SetChecked( false )
					CheckBoxSize2:SetChecked( true )
				end --change to medium
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng8:GetChecked() then CheckBoxEng8:SetChecked( false ) end
			end
			
			CheckBoxEng8 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxEng8:SetPos( 80,130 )
			CheckBoxEng8:SetText( "B6" )
			CheckBoxEng8:SetTextColor(Color(0,0,200,255))
			CheckBoxEng8:SetChecked( false )
			CheckBoxEng8.OnChange = function( )
				Eng1 = "b6"
				CheckBoxSize3:SetDisabled( false )
				if Eng2 == "s" then Eng2 = "small" end
				if Eng2 == "m" then Eng2 = "med" end
				if Eng2 == "l" then Eng2 = "large" end
				
				SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				
				if CheckBoxEng:GetChecked() then CheckBoxEng:SetChecked( false ) end
				if CheckBoxEng2:GetChecked() then CheckBoxEng2:SetChecked( false ) end
				if CheckBoxEng3:GetChecked() then CheckBoxEng3:SetChecked( false ) end
				if CheckBoxEng4:GetChecked() then CheckBoxEng4:SetChecked( false ) end
				if CheckBoxEng5:GetChecked() then CheckBoxEng5:SetChecked( false ) end
				if CheckBoxEng6:GetChecked() then CheckBoxEng6:SetChecked( false ) end
				if CheckBoxEng7:GetChecked() then CheckBoxEng7:SetChecked( false ) end
			end
			
			
			--basic checkup
			--SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
				 
			--#######################  SIZE
		EngineSize = ButtonsSidePanel:Add( "DLabel" )
			EngineSize:SetText( "Engine Size :" )
			EngineSize:SetFont( "DefaultBold" )
			EngineSize:SetTextColor(Color(0,0,200,255))
			EngineSize:SetPos( 20,160 )
			EngineSize:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
			
		CheckBoxSize = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxSize:SetPos( 20,180 )
			CheckBoxSize:SetText( "Small" )
			CheckBoxSize:SetTextColor(Color(0,0,200,255))
			CheckBoxSize:SetChecked( false )
			CheckBoxSize.OnChange = function( )
				if Eng1 == "v8" or Eng1 == "v12" or Eng1 == "inline4" or Eng1 == "inline6" then
					Eng2 = "s"
				else
					Eng2 = "small"
				end
				DisplayModel:SetFOV( 7 )
				
				SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
				
				if CheckBoxSize2:GetChecked() then CheckBoxSize2:SetChecked( false ) end
				if CheckBoxSize3:GetChecked() then CheckBoxSize3:SetChecked( false ) end
			end
			
		CheckBoxSize2 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxSize2:SetPos( 20,200 )
			CheckBoxSize2:SetText( "Medium" )
			CheckBoxSize2:SetTextColor(Color(0,0,200,255))
			CheckBoxSize2:SetChecked( false )
			CheckBoxSize2.OnChange = function( )
				if Eng1 == "v8" or Eng1 == "v12" or Eng1 == "inline4" or Eng1 == "inline6" then
					Eng2 = "m"
				else
					Eng2 = "med"
				end
				DisplayModel:SetFOV( 8 )
				
				SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
				
				if CheckBoxSize:GetChecked() then CheckBoxSize:SetChecked( false ) end
				if CheckBoxSize3:GetChecked() then CheckBoxSize3:SetChecked( false ) end
			end
			
		CheckBoxSize3 = ButtonsSidePanel:Add( "DCheckBoxLabel" )
			CheckBoxSize3:SetPos( 20,220 )
			CheckBoxSize3:SetText( "Large" )
			CheckBoxSize3:SetTextColor(Color(0,0,200,255))
			CheckBoxSize3:SetChecked( false )
			CheckBoxSize3.OnChange = function( )
				if Eng1 == "v8" or Eng1 == "v12" or Eng1 == "inline4" or Eng1 == "inline6" then
					Eng2 = "l"
				else
					Eng2 = "large"
				end
				DisplayModel:SetFOV( 10 )
				
				SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
				
				if CheckBoxSize:GetChecked() then CheckBoxSize:SetChecked( false ) end
				if CheckBoxSize2:GetChecked() then CheckBoxSize2:SetChecked( false ) end
			end
			
			--basic checkup
			--SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
			
			--#########################
		EngineModel2 = ButtonsSidePanel:Add( "DLabel" )
			EngineModel2:SetText( "Models : " )
			EngineModel2:SetFont( "DefaultBold" )
			EngineModel2:SetTextColor(Color(0,0,200,255))
			EngineModel2:SetPos( 20,245 )
			EngineModel2:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
			
		EngineModel = ButtonsSidePanel:Add( "DLabel" )
			EngineModel:SetText( MdlText )
			EngineModel:SetFont( "DefaultBold" )
			EngineModel:SetTextColor(Color(200,0,0,255))
			EngineModel:SetPos( 20,260 )
			EngineModel:SetWide(ButtonsSidePanel:GetWide() / 1.1 - 1.2)
			
			--basic checkup
			SetupModelText(Eng1, Eng2, CheckBoxEng, CheckBoxEng2, CheckBoxEng3, CheckBoxEng4, CheckBoxEng5, CheckBoxEng6, CheckBoxEng7, CheckBoxEng8, EngineModel, DisplayModel)
			SetupModelText2(Eng1, Eng2, CheckBoxSize, CheckBoxSize2, CheckBoxSize3, EngineModel, DisplayModel)
			
			
		--#### DISPLAY
		DisplayModel = ButtonsSidePanel:Add("DModelPanel")
		DisplayModel:SetModel( MdlText )
		DisplayModel:SetCamPos( Vector( 250 , 500 , 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 20 )
		DisplayModel:SetSize( 130 , 130 )
		DisplayModel:SetPos( 90,150 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
			
			
		BackButton	= ButtonsSidePanel:Add("DButton") // The play button.
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(0,0,155,255))
		BackButton:SetPos( 20, 280 )
		BackButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.8)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_start_browser_open")
			StartBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton") // The play button.
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(0,0,255,255))
		NextButton:SetPos( 20, 320 )
		NextButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.5)
		NextButton:SetTall( 40 )
		NextButton.DoClick = function()
			RunConsoleCommand("acf_engine2_browser_open")
			StartBrowserPanel:Close()
		end

	StartBrowserPanel.OnClose = function() // Set effects back and mute when closing.
		--###
	end

	StartBrowserPanel:InvalidateLayout(true)
	
end

--###################################################################################################

// Open the Sound Browser.
local function OpenSartBrowser(pl, cmd, args)
	if (!IsValid(StartBrowserPanel)) then
		CreateSoundBrowser()
	end

	StartBrowserPanel:SetVisible(true)
	StartBrowserPanel:MakePopup()
	StartBrowserPanel:InvalidateLayout(true)

	//Replaces the timer, doesn't get paused in singleplayer.
	WireLib.Timedcall(function(StartBrowserPanel)
		if (!IsValid(StartBrowserPanel)) then return end

		StartBrowserPanel:InvalidateLayout(true)

	end, StartBrowserPanel)
end

concommand.Add("acf_engine_browser_open", OpenSartBrowser)