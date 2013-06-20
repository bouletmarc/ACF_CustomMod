// Made by Bouletmarc.

local StartBrowserPanel = nil

// Open the Sound Browser.
local function CreateSoundBrowser()

	StartBrowserPanel = vgui.Create("DFrame") // The main frame.
	StartBrowserPanel:SetPos(350,125)
	StartBrowserPanel:SetSize(250, 400)

	StartBrowserPanel:SetMinWidth(250)
	StartBrowserPanel:SetMinHeight(400)
	
	StartBrowserPanel:SetDeleteOnClose( false )
	StartBrowserPanel:SetTitle("Engine Menu V3.3 - SETUP MENU SUITE")
	StartBrowserPanel:SetVisible(false)
	StartBrowserPanel:SetCookieName( "wire_sound_browser" )
	StartBrowserPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	
	local ButtonsSidePanel = StartBrowserPanel:Add("DPanel") // The buttons.
	ButtonsSidePanel:DockMargin(4, 4, 4, 4)
	ButtonsSidePanel:Dock(TOP)
	ButtonsSidePanel:SetSize(230, 360)
	ButtonsSidePanel:SetDrawBackground(false)
	--#############################################################	
		EngineNameTitle = ButtonsSidePanel:Add( "DLabel" )
			EngineNameTitle:SetText( "Engine Setup :" )
			EngineNameTitle:SetFont( "DefaultBold" )
			EngineNameTitle:SetTextColor(Color(0,0,200,255))
			EngineNameTitle:SetPos( 20,10 )
			EngineNameTitle:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.2)
		
		PowerText = ButtonsSidePanel:Add( "DLabel" )
			ValueText = math.floor(100 * 100 / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ ".."100 RPM")
			PowerText:SetTextColor(Color(0,0,200,255))
			PowerText:SetPos( 20,50 )
			PowerText:SizeToContents()

	
		SliderT = ButtonsSidePanel:Add( "DNumSlider" )
			SliderT:SetText( "Torque" )
			SliderT:SetMin( 40 )
			SliderT:SetMax( 3000 )
			SliderT:SetDecimals( 0 )
			SliderT:SetValue( 250 )
			RunConsoleCommand( "acfmenu_data3", SliderT:GetValue() )
			SliderT:SetPos( 20,70 )
			SliderT:SetWide( 210 )
			SliderT.Label:SetWide(50)
			SliderT.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data3", val )
				ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
				ValueText2 = math.Round(ValueText*1.34)
				PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
				PowerText:SizeToContents()
			end
			
		SliderIdle = ButtonsSidePanel:Add( "DNumSlider" )
			SliderIdle:SetText( "Idle Rpm" )
			SliderIdle:SetMin( 400 )
			SliderIdle:SetMax( 2500 )
			SliderIdle:SetDecimals( 0 )
			SliderIdle:SetValue( 1000 )
			RunConsoleCommand( "acfmenu_data4", SliderIdle:GetValue() )
			SliderIdle:SetPos( 20,100 )
			SliderIdle:SetWide( 210 )
			SliderIdle.Label:SetWide(50)
			SliderIdle.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data4", val )
				if(SliderIdle:GetValue() > SliderPeakMin:GetValue()) then
					SliderPeakMin:SetValue( SliderIdle:GetValue() )
					RunConsoleCommand( "acfmenu_data5", SliderPeakMin:GetValue() )
				end
			end
			
		SliderPeakMin = ButtonsSidePanel:Add( "DNumSlider" )
			SliderPeakMin:SetText( "Peak Min" )
			SliderPeakMin:SetMin( 1000 )
			SliderPeakMin:SetMax( 4500 )
			SliderPeakMin:SetDecimals( 0 )
			SliderPeakMin:SetValue( 2500 )
			RunConsoleCommand( "acfmenu_data5", SliderPeakMin:GetValue() )
			SliderPeakMin:SetPos( 20,130 )
			SliderPeakMin:SetWide( 210 )
			SliderPeakMin.Label:SetWide(50)
			SliderPeakMin.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data5", val )
				if(SliderPeakMin:GetValue() > SliderPeakMax:GetValue()) then
					SliderPeakMax:SetValue( SliderPeakMin:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
				end
				if(SliderPeakMin:GetValue() < SliderIdle:GetValue()) then
					SliderIdle:SetValue( SliderPeakMin:GetValue() )
					RunConsoleCommand( "acfmenu_data4", SliderIdle:GetValue() )
				end
			end
			
		SliderPeakMax = ButtonsSidePanel:Add( "DNumSlider" )
			SliderPeakMax:SetText( "Peak Max" )
			SliderPeakMax:SetMin( 4000 )
			SliderPeakMax:SetMax( 12000 )
			SliderPeakMax:SetDecimals( 0 )
			SliderPeakMax:SetValue( 6500 )
			RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
			SliderPeakMax:SetPos( 20,160 )
			SliderPeakMax:SetWide( 210 )
			SliderPeakMax.Label:SetWide(50)
			SliderPeakMax.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data6", val )
				ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
				ValueText2 = math.Round(ValueText*1.34)
				PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
				PowerText:SizeToContents()
				if(SliderPeakMax:GetValue() > SliderLimit:GetValue()) then
					SliderLimit:SetValue( SliderPeakMax:GetValue() )
					RunConsoleCommand( "acfmenu_data7", SliderLimit:GetValue() )
				end
				if(SliderPeakMax:GetValue() < SliderPeakMin:GetValue()) then
					SliderPeakMin:SetValue( SliderPeakMax:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMin:GetValue() )
				end
			end
			ValueText = math.floor(SliderT:GetValue() * SliderPeakMax:GetValue() / 9548.8)
			ValueText2 = math.Round(ValueText*1.34)
			PowerText:SetText( "Power : "..ValueText.." kW / "..ValueText2.." HP @ "..SliderPeakMax:GetValue().." RPM")
			PowerText:SizeToContents()
			
		SliderLimit = ButtonsSidePanel:Add( "DNumSlider" )
			SliderLimit:SetText( "Limit Rpm" )
			SliderLimit:SetMin( 4000 )
			SliderLimit:SetMax( 12000 )
			SliderLimit:SetDecimals( 0 )
			SliderLimit:SetValue( 7000 )
			RunConsoleCommand( "acfmenu_data7", SliderLimit:GetValue() )
			SliderLimit:SetPos( 20,190 )
			SliderLimit:SetWide( 210 )
			SliderLimit.Label:SetWide(50)
			SliderLimit.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data7", val )
				if(SliderLimit:GetValue() < SliderPeakMax:GetValue()) then
					SliderPeakMax:SetValue( SliderLimit:GetValue() )
					RunConsoleCommand( "acfmenu_data6", SliderPeakMax:GetValue() )
				end
			end
			
		SliderFly = ButtonsSidePanel:Add( "DNumSlider" )
			SliderFly:SetText( "Flywheel Mass" )
			SliderFly:SetMin( 0.01 )
			SliderFly:SetMax( 4 )
			SliderFly:SetDecimals( 2 )
			SliderFly:SetValue( 0.15 )
			RunConsoleCommand( "acfmenu_data8", SliderFly:GetValue() )
			SliderFly:SetPos( 20,220 )
			SliderFly:SetWide( 210 )
			SliderFly.Label:SetWide(60)
			SliderFly.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data8", val )
			end
			
		SliderWeight = ButtonsSidePanel:Add( "DNumSlider" )
			SliderWeight:SetText( "Weight" )
			SliderWeight:SetMin( 50 )
			SliderWeight:SetMax( 400 )
			SliderWeight:SetDecimals( 0 )
			SliderWeight:SetValue( 150 )
			RunConsoleCommand( "acfmenu_data9", SliderWeight:GetValue() )
			SliderWeight:SetPos( 20,250 )
			SliderWeight:SetWide( 210 )
			SliderWeight.Label:SetWide(50)
			SliderWeight.OnValueChanged = function( self, val )
				RunConsoleCommand( "acfmenu_data9", val )
			end
			
		BackButton	= ButtonsSidePanel:Add("DButton") // The play button.
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(0,0,155,255))
		BackButton:SetPos( 20, 280 )
		BackButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.8)
		BackButton:SetTall( 40 )
		BackButton.DoClick = function()
			RunConsoleCommand("acf_engine_browser_open")
			StartBrowserPanel:Close()
		end
			
		NextButton	= ButtonsSidePanel:Add("DButton") // The play button.
		NextButton:SetText("Next Step")
		NextButton:SetTextColor(Color(0,0,255,255))
		NextButton:SetPos( 20, 320 )
		NextButton:SetWide(ButtonsSidePanel:GetWide() / 1.2 - 1.5)
		NextButton:SetTall( 40 )
		NextButton.DoClick = function()
			RunConsoleCommand("acf_engine3_browser_open")
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

concommand.Add("acf_engine2_browser_open", OpenSartBrowser)