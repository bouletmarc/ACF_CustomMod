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
	local Consumption = self:GetNetworkedBeamInt("Consumption")
	--##################################################################
	local txt = Type.."\nMax Power : "..Power.."KW / "..math.Round(Power*1.34).."HP \nMax Torque : "..Torque.."N/m / "..math.Round(Torque*0.73).."ft-lb \nPowerband : "..MinRPM.." - "..MaxRPM.."RPM\nRedline : "..LimitRPM.."RPM\nFlywheelMass : "..FlywheelMass.."Grams\nIdle : "..Idle.."RPM\nWeight : "..Weight.."Kg\nRpm : "..Rpm.."RPM\nConsumption : "..Consumption.." liters/min" or ""
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

function ACFEngine4GUICreate( Table )

	if not acfmenupanel.ModData then
		acfmenupanel.ModData = {}
	end
	if not acfmenupanel.ModData[Table.id] then
		acfmenupanel.ModData[Table.id] = {}
		acfmenupanel.ModData[Table.id]["ModTable"] = Table.modtable
	end
	
	--#######################
	--acfmenupanel:CPanelText("Name", Table.name)
	TextName = vgui.Create( "DLabel" )
		TextName:SetText( "Name : "..Table.name)
		TextName:SetTextColor(Color(0,0,200,255))
		TextName:SetFont( "CloseCaption_BoldItalic" )
	acfmenupanel.CustomDisplay:AddItem( TextName )
	
	acfmenupanel.CData.DisplayModel = vgui.Create( "DModelPanel", acfmenupanel.CustomDisplay )
		acfmenupanel.CData.DisplayModel:SetModel( Table.model )
		acfmenupanel.CData.DisplayModel:SetCamPos( Vector( 250 , 500 , 250 ) )
		acfmenupanel.CData.DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		acfmenupanel.CData.DisplayModel:SetFOV( 20 )
		acfmenupanel.CData.DisplayModel:SetSize(acfmenupanel:GetWide(),acfmenupanel:GetWide())
		acfmenupanel.CData.DisplayModel.LayoutEntity = function( panel , entity ) end
	acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.DisplayModel )
		
	--acfmenupanel:CPanelText("Desc", Table.desc)
	TextDesc = vgui.Create( "DLabel" )
		TextDesc:SetText( "Desc : "..Table.desc)
		TextDesc:SetTextColor(Color(0,0,200,255))
		TextDesc:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextDesc )
	
	local TorqueVal = 0
	local PeakRpmval = 0
	for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
		if ID == 1 then
			ACF_ModdingSlider1(1, Value, Table.id, "Torque")
			TorqueVal = Value
		elseif ID == 2 then
			ACF_ModdingSlider2(2, Value, Table.id, "Idle Rpm")
		elseif ID == 3 then
			ACF_ModdingSlider3(3, Value, Table.id, "Peak Minimum Rpm")
		elseif ID == 4 then
			ACF_ModdingSlider4(4, Value, Table.id, "Peak Maximum Rpm")
			PeakRpmval = Value
		elseif ID == 5 then
			ACF_ModdingSlider4(5, Value, Table.id, "Limit Rpm")
		elseif ID == 6 then
			ACF_ModdingSlider5(6, Value, Table.id, "Flywheel Mass")
		end
	end
	
	--####
	local peakkw = TorqueVal * PeakRpmval / 9548.8
	local peakkwrpm = PeakRpmval
	--menu updating value's
	RunConsoleCommand( "acfmenu_data8", Table.fuel )
	RunConsoleCommand( "acfmenu_data9", Table.enginetype )
	--####
	if Table.requiresfuel then --if fuel required, show max power with fuel at top, no point in doing it twice
		--acfmenupanel:CPanelText("Power", "\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
		TextPower = vgui.Create( "DLabel" )
			TextPower:SetText( "Peak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
			TextPower:SetTextColor(Color(0,0,200,255))
			TextPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextPower )
		--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
		TextTorque = vgui.Create( "DLabel" )
			TextTorque:SetText( "Peak Torque : "..(GetConVar("acfmenu_data1")*ACF.TorqueBoost).." n/m  / "..math.Round(GetConVar("acfmenu_data1")*ACF.TorqueBoost*0.73).." ft-lb")
			TextTorque:SetTextColor(Color(0,0,200,255))
			TextTorque:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextTorque )
	else
		--acfmenupanel:CPanelText("Power", "\nPeak Power : "..math.floor(peakkw).." kW / "..math.Round(peakkw*1.34).." HP @ "..peakkwrpm.." RPM")
		TextPower = vgui.Create( "DLabel" )
			TextPower:SetText( "Peak Power : "..math.floor(peakkw).." kW / "..math.Round(peakkw*1.34).." HP @ "..peakkwrpm.." RPM")
			TextPower:SetTextColor(Color(0,0,200,255))
			TextPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextPower )
		--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
		TextTorque = vgui.Create( "DLabel" )
			TextTorque:SetText( "Peak Torque : "..GetConVar("acfmenu_data1").." n/m  / "..math.Round(GetConVar("acfmenu_data1")*0.73).." ft-lb")
			TextTorque:SetTextColor(Color(0,0,200,255))
			TextTorque:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextTorque )
	end
	--acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
	TextWeight = vgui.Create( "DLabel" )
		TextWeight:SetText( "Weight : "..(Table.weight).." kg")
		TextWeight:SetTextColor(Color(0,0,200,255))
		TextWeight:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextWeight )
	--acfmenupanel:CPanelText("FuelType", "\nFuel Type : "..(Table.fuel))
	TextFuelType = vgui.Create( "DLabel" )
		TextFuelType:SetText( "Fuel Type : "..(Table.fuel))
		TextFuelType:SetTextColor(Color(0,0,200,255))
		TextFuelType:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextFuelType )
	
	if Table.fuel == "Electric" then
		local cons = ACF.ElecRate * peakkw / ACF.Efficiency[Table.enginetype]
		--acfmenupanel:CPanelText("FuelCons", "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
		TextFuelCons = vgui.Create( "DLabel" )
			TextFuelCons:SetText( "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
			TextFuelCons:SetTextColor(Color(0,0,200,255))
			TextFuelCons:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFuelCons )
	elseif Table.fuel == "Any" then
		local petrolcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Petrol"])
		local dieselcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Diesel"])
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
		local fuelcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity[Table.fuel])
		--acfmenupanel:CPanelText("FuelCons", (Table.fuel).." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
		TextFuelCons = vgui.Create( "DLabel" )
			TextFuelCons:SetText( (Table.fuel).." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
			TextFuelCons:SetTextColor(Color(0,0,200,255))
			TextFuelCons:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFuelCons )
	end
	
	if Table.requiresfuel then
		--acfmenupanel:CPanelText("Fuelreq", "REQUIRES FUEL")
		TextFuelreq = vgui.Create( "DLabel" )
			TextFuelreq:SetText( "REQUIRES FUEL")
			TextFuelreq:SetTextColor(Color(0,200,0,255))
			TextFuelreq:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFuelreq )
	else
		--acfmenupanel:CPanelText("FueledPower", "\nWhen supplied with fuel:\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
		TextFueledPower = vgui.Create( "DLabel" )
			TextFueledPower:SetText( "When supplied with fuel:\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
			TextFueledPower:SetTextColor(Color(200,0,0,255))
			TextFueledPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFueledPower )
		--acfmenupanel:CPanelText("FueledTorque", "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
		TextFueledTorque = vgui.Create( "DLabel" )
			TextFueledTorque:SetText( "Peak Torque : "..(GetConVar("acfmenu_data1")*ACF.TorqueBoost).." n/m  / "..math.Round(GetConVar("acfmenu_data1")*ACF.TorqueBoost*0.73).." ft-lb")
			TextFueledTorque:SetTextColor(Color(200,0,0,255))
			TextFueledTorque:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFueledTorque )
	end
	--##################################################################
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end

--##################################################################
--##################################################################

function ACF_ModdingSlider1(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Torque"..Mod )
			acfmenupanel["CData"][Mod].Label:SizeToContents()
			acfmenupanel["CData"][Mod]:SetMin( 950 )
			acfmenupanel["CData"][Mod]:SetMax( 3000 )
			acfmenupanel["CData"][Mod]:SetDecimals( 0 )
			acfmenupanel["CData"][Mod]["Mod"] = Mod
			acfmenupanel["CData"][Mod]["ID"] = ID
			acfmenupanel["CData"][Mod]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Mod, Value )
			acfmenupanel["CData"][Mod].OnValueChanged = function( slider, val )
				acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
				RunConsoleCommand( "acfmenu_data"..Mod, val )
				ACF_UpdatingPanel()
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Mod] )
	end

end

function ACF_ModdingSlider2(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Idle Rpm"..Mod )
			acfmenupanel["CData"][Mod].Label:SizeToContents()
			acfmenupanel["CData"][Mod]:SetMin( 300 )
			acfmenupanel["CData"][Mod]:SetMax( 1000 )
			acfmenupanel["CData"][Mod]:SetDecimals( 0 )
			acfmenupanel["CData"][Mod]["Mod"] = Mod
			acfmenupanel["CData"][Mod]["ID"] = ID
			acfmenupanel["CData"][Mod]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Mod, Value )
			acfmenupanel["CData"][Mod].OnValueChanged = function( slider, val )
				acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
				RunConsoleCommand( "acfmenu_data"..Mod, val )
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Mod] )
	end

end

function ACF_ModdingSlider3(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Peak Minimum Rpm"..Mod )
			acfmenupanel["CData"][Mod].Label:SizeToContents()
			acfmenupanel["CData"][Mod]:SetMin( 500 )
			acfmenupanel["CData"][Mod]:SetMax( 2000 )
			acfmenupanel["CData"][Mod]:SetDecimals( 0 )
			acfmenupanel["CData"][Mod]["Mod"] = Mod
			acfmenupanel["CData"][Mod]["ID"] = ID
			acfmenupanel["CData"][Mod]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Mod, Value )
			acfmenupanel["CData"][Mod].OnValueChanged = function( slider, val )
				acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
				RunConsoleCommand( "acfmenu_data"..Mod, val )
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Mod] )
	end

end

function ACF_ModdingSlider4(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Rpm"..Mod )
			acfmenupanel["CData"][Mod].Label:SizeToContents()
			acfmenupanel["CData"][Mod]:SetMin( 1500 )
			acfmenupanel["CData"][Mod]:SetMax( 6500 )
			acfmenupanel["CData"][Mod]:SetDecimals( 0 )
			acfmenupanel["CData"][Mod]["Mod"] = Mod
			acfmenupanel["CData"][Mod]["ID"] = ID
			acfmenupanel["CData"][Mod]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Mod, Value )
			acfmenupanel["CData"][Mod].OnValueChanged = function( slider, val )
				acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
				RunConsoleCommand( "acfmenu_data"..Mod, val )
				if Mod == 4 then
					ACF_UpdatingPanel()
				end
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Mod] )
	end

end

function ACF_ModdingSlider5(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Flywheel Mass"..Mod )
			acfmenupanel["CData"][Mod].Label:SizeToContents()
			acfmenupanel["CData"][Mod]:SetMin( 1 )
			acfmenupanel["CData"][Mod]:SetMax( 8 )
			acfmenupanel["CData"][Mod]:SetDecimals( 1 )
			acfmenupanel["CData"][Mod]["Mod"] = Mod
			acfmenupanel["CData"][Mod]["ID"] = ID
			acfmenupanel["CData"][Mod]:SetValue(Value)
			RunConsoleCommand( "acfmenu_data"..Mod, Value )
			acfmenupanel["CData"][Mod].OnValueChanged = function( slider, val )
				acfmenupanel.ModData[slider.ID]["ModTable"][slider.Mod] = val
				RunConsoleCommand( "acfmenu_data"..Mod, val )
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Mod] )
	end

end

function ACF_UpdatingPanel()
	--Get Value's
	local TorqueVal = GetConVarNumber("acfmenu_data1")
	local PeakRpmval = GetConVarNumber("acfmenu_data4")
	local FuelTypeText = GetConVar("acfmenu_data8")
	local EngineTypeText = GetConVar("acfmenu_data9")
	--Set Value's
	local peakkw = TorqueVal * PeakRpmval / 9548.8
	local peakkwrpm = PeakRpmval
	TextPower:SetText( "Peak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
	if FuelTypeText == "Electric" then
		local cons = ACF.ElecRate * peakkw / ACF.Efficiency[EngineTypeText]
		TextFuelCons:SetText( "Peak energy use : "..math.Round(cons,1).." kW / "..math.Round(0.06*cons,1).." MJ/min")
	elseif FuelTypeText == "Any" then
		local petrolcons = ACF.FuelRate * ACF.Efficiency[EngineTypeText] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Petrol"])
		local dieselcons = ACF.FuelRate * ACF.Efficiency[EngineTypeText] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Diesel"])
		TextFuelConsP:SetText( "Petrol Use at "..peakkwrpm.." rpm \n "..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
		TextFuelConsD:SetText( "Diesel Use at "..peakkwrpm.." rpm \n "..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
	else
		local fuelcons = ACF.FuelRate * ACF.Efficiency[EngineTypeText] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity[FuelTypeText])
		TextFuelCons:SetText( FuelTypeText.." Use at "..peakkwrpm.." rpm \n "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
	end
	
end