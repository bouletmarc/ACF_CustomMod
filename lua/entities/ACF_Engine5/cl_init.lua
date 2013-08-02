include("shared.lua")

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

ENT.AutomaticFrameAdvance = true 

function ENT:Draw()
	self:DoNormalDraw()
	self:DrawModel()
    Wire_Render(self)
end

function ENT:DoNormalDraw()
	local e = self
	if (LocalPlayer():GetEyeTrace().Entity == e and EyePos():Distance(e:GetPos()) < 256) then
		if(self:GetOverlayText() ~= "") then
			AddWorldTip(e:EntIndex(),self:GetOverlayText(),0.5,e:GetPos(),e)
		end
	end
end

function ENT:GetOverlayText()
	local name = self:GetNetworkedString("WireName")
	local Type = self:GetNetworkedBeamString("Type")
	local Power = self:GetNetworkedBeamInt("Power")
	local Torque = self:GetNetworkedBeamInt("Torque")
	local MinRPM = self:GetNetworkedBeamInt("MinRPM")
	local MaxRPM = self:GetNetworkedBeamInt("MaxRPM")
	local LimitRPM = self:GetNetworkedBeamInt("LimitRPM")
	--##################################################################
	local FlywheelMass = self:GetNetworkedBeamInt("FlywheelMass2")
	local Idle = self:GetNetworkedBeamInt("Idle")
	local Weight = self:GetNetworkedBeamInt("Weight")
	local Rpm = self:GetNetworkedBeamInt("Rpm")
	--##################################################################
	local txt = Type.."\nMax Power : "..Power.."KW / "..math.Round(Power*1.34).."HP \nMax Torque : "..Torque.."N/m / "..math.Round(Torque*0.73).."ft-lb \nPowerband : "..MinRPM.." - "..MaxRPM.."RPM\nRedline : "..LimitRPM.."RPM\nFlywheelMass : "..FlywheelMass.."Grams\nIdle : "..Idle.."RPM\nWeight : "..Weight.."Kg\nRpm : "..Rpm.."RPM" or ""
	if (not game.SinglePlayer()) then
		local PlayerName = self:GetPlayerName()
		txt = txt .. "\n(" .. PlayerName .. ")"
	end
	if(name and name ~= "") then
	    if (txt == "") then
	        return "- "..name.." -"
	    end
	    return "- "..name.." -\n"..txt
	end
	return txt
end

function ACFEngine5GUICreate( Table )

	if not acfmenupanel.ModData then
		acfmenupanel.ModData = {}
	end
	if not acfmenupanel.ModData[Table.id] then
		acfmenupanel.ModData[Table.id] = {}
		acfmenupanel.ModData[Table.id]["ModTable"] = Table.modtable
	end
		
	--acfmenupanel:CPanelText("Desc", Table.desc)
	TextDesc = vgui.Create( "DLabel" )
		TextDesc:SetText( "Desc : "..Table.desc)
		TextDesc:SetTextColor(Color(0,0,200,255))
		TextDesc:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextDesc )
	
	for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
		if ID == 1 then
			ACF_ModingSound(1, Value, Table.id)
		end
	end

	acfmenupanel.CustomDisplay:PerformLayout()
	
end

--##################################################################
--##################################################################

function ACF_ModingSound( Mod, Mod1, Value, ID )
	local wide = acfmenupanel.CustomDisplay:GetWide()
	
	Open = vgui.Create("DButton")
	Open:SetText("Open Engine Menu")
	Open:SetTextColor(Color(0,0,200,255))
	Open:SetWide(wide)
	Open:SetTall(30)
	Open:SetVisible(true)
		Open.DoClick = function()
			RunConsoleCommand("acf_start_browser_open",acfmenupanel["CData"][Mod]:GetValue())
		end
	acfmenupanel.CustomDisplay:AddItem(Open)
	
	SoundText = vgui.Create("DLabel")
	SoundText:SetText("Sound :")
	SoundText:SetFont( "DefaultBold" )
	SoundText:SetTextColor(Color(0,0,255,255))
	SoundText:SetWide(wide)
	SoundText:SetTall(20)
	acfmenupanel.CustomDisplay:AddItem(SoundText)
	
	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create("DTextEntry", acfmenupanel.CustomDisplay)
		acfmenupanel["CData"][Mod]:SetText("")
		acfmenupanel["CData"][Mod]:SetWide(wide)
		acfmenupanel["CData"][Mod]:SetTall(20)
		acfmenupanel["CData"][Mod]:SetMultiline(false)
		acfmenupanel["CData"][Mod]:SetCursorColor(Color(0,0,255,255))
		acfmenupanel["CData"][Mod]:SetHighlightColor(Color(0,255,0,200))
		acfmenupanel["CData"][Mod]:SetTextColor(Color(0,0,150,255))
		acfmenupanel["CData"][Mod]["Mod"] = Mod
		acfmenupanel["CData"][Mod]["ID"] = ID
		Value = GetConVarString("wire_soundemitter_sound")
		RunConsoleCommand("wire_soundemitter_sound", Value )
		acfmenupanel["CData"][Mod]:SetConVar( "wire_soundemitter_sound" )
		RunConsoleCommand( "acfmenu_data1", Value )
		acfmenupanel["CData"][Mod].ConVarChanged = function( sound, Value )
			acfmenupanel["CData"][Mod]:SetConVar( "wire_soundemitter_sound" )
			Value = GetConVarString("wire_soundemitter_sound")
			RunConsoleCommand( "acfmenu_data1", Value )
		end
		acfmenupanel["CData"][Mod]:SetVisible(true)
		acfmenupanel.CustomDisplay:AddItem(acfmenupanel["CData"][Mod])
	end
		
	ModelText = vgui.Create("DLabel")
	ModelText:SetText("Model :")
	ModelText:SetFont( "DefaultBold" )
	ModelText:SetTextColor(Color(0,0,255,255))
	ModelText:SetWide(wide)
	ModelText:SetTall(20)
	acfmenupanel.CustomDisplay:AddItem(ModelText)
	
	if Mod1 and not acfmenupanel["CData"][Mod1] then	
		acfmenupanel["CData"][Mod1] = vgui.Create("DTextEntry", acfmenupanel.CustomDisplay)
		acfmenupanel["CData"][Mod1]:SetText("")
		acfmenupanel["CData"][Mod1]:SetWide(wide)
		acfmenupanel["CData"][Mod1]:SetTall(20)
		acfmenupanel["CData"][Mod1]:SetMultiline(false)
		acfmenupanel["CData"][Mod1]:SetCursorColor(Color(0,0,255,255))
		acfmenupanel["CData"][Mod1]:SetHighlightColor(Color(0,255,0,200))
		acfmenupanel["CData"][Mod1]:SetTextColor(Color(0,0,150,255))
		acfmenupanel["CData"][Mod1]["Mod1"] = Mod1
		acfmenupanel["CData"][Mod1]["ID"] = ID
		Value = GetConVarString("wire_soundemitter_model")
		RunConsoleCommand("wire_soundemitter_model", Value )
		acfmenupanel["CData"][Mod1]:SetConVar( "wire_soundemitter_model" )
		RunConsoleCommand( "acfmenu_data2", Value )
		acfmenupanel["CData"][Mod1].ConVarChanged = function( sound, Value )
			acfmenupanel["CData"][Mod1]:SetConVar( "wire_soundemitter_model" )
			Value = GetConVarString("wire_soundemitter_model")
			RunConsoleCommand( "acfmenu_data2", Value )
		end
		acfmenupanel["CData"][Mod1]:SetVisible(true)
		acfmenupanel.CustomDisplay:AddItem(acfmenupanel["CData"][Mod1])
	end
	

		TextName = vgui.Create( "DLabel" )
			TextName:SetText( "Engine Name : "..GetConVarString("acfmenu_data10"))
			TextName:SetFont( "DefaultBold" )
			TextName:SetTextColor(Color(0,0,200,255))
		acfmenupanel.CustomDisplay:AddItem( TextName )
		
		--#####
		TextFuelType = vgui.Create( "DLabel" )
			TextFuelType:SetText( "Fuel Type : "..GetConVarString("acfmenu_data11"))
			TextFuelType:SetTextColor(Color(0,0,200,255))
			TextFuelType:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFuelType )
		--#####

		TextTorque = vgui.Create( "DLabel" )
			TextTorque:SetText( "Torque : "..GetConVarString("acfmenu_data3"))
			TextTorque:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data3") > 0) then
				TextTorque:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data3") <= 0) then
				TextTorque:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextTorque )
		
		TextIdle = vgui.Create( "DLabel" )
			TextIdle:SetText( "Idle Rpm : "..GetConVarString("acfmenu_data4"))
			TextIdle:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data4") > 0) then
				TextIdle:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data4") <= 0) then
				TextIdle:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextIdle )
		
		TextPeakMin = vgui.Create( "DLabel" )
			TextPeakMin:SetText( "Peak Min Rpm : "..GetConVarString("acfmenu_data5"))
			TextPeakMin:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data5") > 0) then
				TextPeakMin:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data5") <= 0) then
				TextPeakMin:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextPeakMin )
		
		TextPeakMax = vgui.Create( "DLabel" )
			TextPeakMax:SetText( "Peak Max Rpm : "..GetConVarString("acfmenu_data6"))
			TextPeakMax:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data6") > 0) then
				TextPeakMax:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data6") <= 0) then
				TextPeakMax:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextPeakMax )
		
		TextLimit = vgui.Create( "DLabel" )
			TextLimit:SetText( "Limit Rpm : "..GetConVarString("acfmenu_data7"))
			TextLimit:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data7") > 0) then
				TextLimit:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data7") <= 0) then
				TextLimit:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextLimit )
		
		TextFly = vgui.Create( "DLabel" )
			TextFly:SetText( "Flywheel Mass : "..GetConVarString("acfmenu_data8"))
			TextFly:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data8") > 0) then
				TextFly:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data8") <= 0) then
				TextFly:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextFly )
		
		TextWeight = vgui.Create( "DLabel" )
			TextWeight:SetText( "Weight : "..GetConVarString("acfmenu_data9"))
			TextWeight:SetFont( "DefaultBold" )
			if(GetConVarNumber("acfmenu_data9") > 0) then
				TextWeight:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data9") <= 0) then
				TextWeight:SetTextColor(Color(200,0,0,255))
			end
		acfmenupanel.CustomDisplay:AddItem( TextWeight )
		
		--####
		local peakkw = GetConVar("acfmenu_data3") * GetConVar("acfmenu_data6") / 9548.8
		local peakkwrpm = GetConVar("acfmenu_data6")
		--####
		if (GetConVar("acfmenu_data12") == 1) then --if fuel required, show max power with fuel at top, no point in doing it twice
			--acfmenupanel:CPanelText("Power", "\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
			TextPower = vgui.Create( "DLabel" )
				TextPower:SetText( "Peak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
				TextPower:SetTextColor(Color(0,0,200,255))
				TextPower:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextPower )
			--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
			TextTorque = vgui.Create( "DLabel" )
				TextTorque:SetText( "Peak Torque : "..(GetConVar("acfmenu_data3")*ACF.TorqueBoost).." n/m  / "..math.Round(GetConVar("acfmenu_data3")*ACF.TorqueBoost*0.73).." ft-lb")
				TextTorque:SetTextColor(Color(0,0,200,255))
				TextTorque:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextTorque )
			
			TextFuelreq = vgui.Create( "DLabel" )
				TextFuelreq:SetText( "REQUIRES FUEL")
				TextFuelreq:SetTextColor(Color(0,200,0,255))
				TextFuelreq:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFuelreq )
		else
			--acfmenupanel:CPanelText("Power", "\nPeak Power : "..math.floor(peakkw).." kW / "..math.Round(peakkw*1.34).." HP @ "..peakkwrpm.." RPM")
			TextPower = vgui.Create( "DLabel" )
				TextPower:SetText( "Peak Power : "..math.floor(peakkw).." kW / "..math.Round(peakkw*1.34).." HP @ "..peakkwrpm.." RPM")
				TextPower:SetTextColor(Color(0,0,200,255))
				TextPower:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextPower )
			--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
			TextTorque = vgui.Create( "DLabel" )
				TextTorque:SetText( "Peak Torque : "..GetConVar("acfmenu_data3").." n/m  / "..math.Round(GetConVar("acfmenu_data3")*0.73).." ft-lb")
				TextTorque:SetTextColor(Color(0,0,200,255))
				TextTorque:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextTorque )
			--acfmenupanel:CPanelText("FueledPower", "\nWhen supplied with fuel:\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
			TextFueledPower = vgui.Create( "DLabel" )
				TextFueledPower:SetText( "When supplied with fuel:\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
				TextFueledPower:SetTextColor(Color(200,0,0,255))
				TextFueledPower:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFueledPower )
			--acfmenupanel:CPanelText("FueledTorque", "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
			TextFueledTorque = vgui.Create( "DLabel" )
				TextFueledTorque:SetText( "Peak Torque : "..(GetConVar("acfmenu_data3")*ACF.TorqueBoost).." n/m  / "..math.Round(GetConVar("acfmenu_data3")*ACF.TorqueBoost*0.73).." ft-lb")
				TextFueledTorque:SetTextColor(Color(200,0,0,255))
				TextFueledTorque:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFueledTorque )
		end
		--###################
		if (GetConVar("acfmenu_data11") == "Electric") then
			local cons = ACF.ElecRate * peakkw / ACF.Efficiency[GetConVar("acfmenu_data13")]
			--acfmenupanel:CPanelText("FuelCons", "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
			TextFuelCons = vgui.Create( "DLabel" )
				TextFuelCons:SetText( "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
				TextFuelCons:SetTextColor(Color(0,0,200,255))
				TextFuelCons:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFuelCons )
		elseif (GetConVar("acfmenu_data11") == "Any") then
			local petrolcons = ACF.FuelRate * ACF.Efficiency[GetConVar("acfmenu_data13")] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Petrol"])
			local dieselcons = ACF.FuelRate * ACF.Efficiency[GetConVar("acfmenu_data13")] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Diesel"])
			--acfmenupanel:CPanelText("FuelConsP", "Petrol Use at "..peakkwrpm.." rpm : "..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
			TextFuelConsP = vgui.Create( "DLabel" )
				TextFuelConsP:SetText( "Petrol Use at "..peakkwrpm.." rpm : "..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
				TextFuelConsP:SetTextColor(Color(0,0,200,255))
				TextFuelConsP:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFuelConsP )
			--acfmenupanel:CPanelText("FuelConsD", "Diesel Use at "..peakkwrpm.." rpm : "..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
			TextFuelConsD = vgui.Create( "DLabel" )
				TextFuelConsD:SetText( "Diesel Use at "..peakkwrpm.." rpm : "..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
				TextFuelConsD:SetTextColor(Color(0,0,200,255))
				TextFuelConsD:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFuelConsD )
		else
			local fuelcons = ACF.FuelRate * ACF.Efficiency[GetConVar("acfmenu_data13")] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity[GetConVar("acfmenu_data11")])
			--acfmenupanel:CPanelText("FuelCons", (Table.fuel).." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
			TextFuelCons = vgui.Create( "DLabel" )
				TextFuelCons:SetText( GetConVar("acfmenu_data11").." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
				TextFuelCons:SetTextColor(Color(0,0,200,255))
				TextFuelCons:SetFont( "DefaultBold" )
			acfmenupanel.CustomDisplay:AddItem( TextFuelCons )
		end
		--###################
		
	UpdateAll = vgui.Create("DButton")
	UpdateAll:SetText("Update")
	UpdateAll:SetTextColor(Color(0,200,0,255))
	UpdateAll:SetWide(wide)
	UpdateAll:SetTall(20)
	UpdateAll:SetVisible(true)
	UpdateAll.DoClick = function( )
			acfmenupanel.CustomDisplay:PerformLayout()
			--update Sound
			acfmenupanel["CData"][Mod]:SetConVar( "wire_soundemitter_sound" )
			Value = GetConVarString("wire_soundemitter_sound")
			RunConsoleCommand( "acfmenu_data1", Value )
			--update Engine
			acfmenupanel["CData"][Mod1]:SetConVar( "wire_soundemitter_model" )
			Value = GetConVarString("wire_soundemitter_model")
			RunConsoleCommand( "acfmenu_data2", Value )
			--update Value
			--TextName:SetText( "Engine Name : "..GetConVarString("acfmenu_data10"))
			--TextTorque:SetText( "Torque : "..GetConVarString("acfmenu_data3"))
			if(GetConVarNumber("acfmenu_data3") > 0) then
				TextTorque:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data3") <= 0) then
				TextTorque:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextFuelType:SetText( "Fuel Type : "..GetConVarString("acfmenu_data11"))
			--####
			--TextIdle:SetText( "Idle Rpm : "..GetConVarString("acfmenu_data4"))
			if(GetConVarNumber("acfmenu_data4") > 0) then
				TextIdle:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data4") <= 0) then
				TextIdle:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextPeakMin:SetText( "Peak Min Rpm : "..GetConVarString("acfmenu_data5"))
			if(GetConVarNumber("acfmenu_data5") > 0) then
				TextPeakMin:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data5") <= 0) then
				TextPeakMin:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextPeakMax:SetText( "Peak Max Rpm : "..GetConVarString("acfmenu_data6"))
			if(GetConVarNumber("acfmenu_data6") > 0) then
				TextPeakMax:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data6") <= 0) then
				TextPeakMax:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextLimit:SetText( "Limit Rpm : "..GetConVarString("acfmenu_data7"))
			if(GetConVarNumber("acfmenu_data7") > 0) then
				TextLimit:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data7") <= 0) then
				TextLimit:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextFly:SetText( "Flywheel Mass : "..GetConVarString("acfmenu_data8"))
			if(GetConVarNumber("acfmenu_data8") > 0) then
				TextFly:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data8") <= 0) then
				TextFly:SetTextColor(Color(200,0,0,255))
			end
			--####
			--TextWeight:SetText( "Weight : "..GetConVarString("acfmenu_data9"))
			if(GetConVarNumber("acfmenu_data9") > 0) then
				TextWeight:SetTextColor(Color(0,0,200,255))
			elseif(GetConVarNumber("acfmenu_data9") <= 0) then
				TextWeight:SetTextColor(Color(200,0,0,255))
			end
			--####*/
		end
	acfmenupanel.CustomDisplay:AddItem(UpdateAll)
	
	Help = vgui.Create("DButton")
	Help:SetToolTip("1.Customizable engine in the Engine menu \n 2.Send info in the Acf menu \n 3.Press update Button \n 4.Spawn the Engine")
	Help:SetTextColor(Color(200,0,0,255))
	Help:SetWide(wide/2)
	Help:SetTall(20)
	Help:SetVisible(true)
	Help:SetText("Help")
	acfmenupanel.CustomDisplay:AddItem(Help)

end
