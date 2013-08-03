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

function ACFEngineGUICreate( Table )
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
		TextDesc:SetText( "\nDesc : "..Table.desc)
		TextDesc:SetTextColor(Color(0,0,200,255))
		TextDesc:SetFont( "DefaultBold" )
		TextDesc:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( TextDesc )
	
	--RunConsoleCommand( "acfmenu_data1", 1 )
	/*Check1 = vgui.Create( "DCheckBoxLabel" )
	Check1:SetText( "Cutoff ?" )
	Check1:SetTextColor(Color(0,0,255,255))
	Check1:SetConVar( "acfmenu_data1" ) -- ConCommand must be a 1 or 0 value
	Check1:SetValue( 1 )
	Check1:OnChange( self, Value )
		Value=GetConVar("acfmenu_data1")
		RunConsoleCommand( "acfmenu_data1", Value )
	Check1:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( Check1 )*/
	
	--####################
	local peakkw
	local peakkwrpm
	if (Table.iselec == true )then --elecs and turbs get peak power in middle of rpm range
		peakkw = Table.torque * Table.limitrpm / (4*9548.8)
		peakkwrpm = math.floor(Table.limitrpm / 2)
	else	
		peakkw = Table.torque * Table.peakmaxrpm / 9548.8
		peakkwrpm = Table.peakmaxrpm
	end
	if Table.requiresfuel then --if fuel required, show max power with fuel at top, no point in doing it twice
		--acfmenupanel:CPanelText("Power", "\nPeak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
		TextPower = vgui.Create( "DLabel" )
			TextPower:SetText( "Peak Power : "..math.floor(peakkw*ACF.TorqueBoost).." kW / "..math.Round(peakkw*ACF.TorqueBoost*1.34).." HP @ "..peakkwrpm.." RPM")
			TextPower:SetTextColor(Color(0,0,200,255))
			TextPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextPower )
		--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
		TextTorque = vgui.Create( "DLabel" )
			TextTorque:SetText( "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
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
			TextTorque:SetText( "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
			TextTorque:SetTextColor(Color(0,0,200,255))
			TextTorque:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextTorque )
	end
	--#################
	--acfmenupanel:CPanelText("RPM", "Idle : "..(Table.idlerpm).." RPM\nIdeal RPM Range : "..(Table.peakminrpm).."-"..(Table.peakmaxrpm).." RPM\nRedline : "..(Table.limitrpm).." RPM")
	TextRPM = vgui.Create( "DLabel" )
		TextRPM:SetText( "Idle : "..(Table.idlerpm).." RPM\nIdeal RPM Range : "..(Table.peakminrpm).."-"..(Table.peakmaxrpm).." RPM\nRedline : "..(Table.limitrpm).." RPM")
		TextRPM:SetTextColor(Color(0,0,200,255))
		TextRPM:SetFont( "DefaultBold" )
		TextRPM:SizeToContents()
	acfmenupanel.CustomDisplay:AddItem( TextRPM )
	--acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
	TextWeight = vgui.Create( "DLabel" )
		TextWeight:SetText( "Weight : "..(Table.weight).." kg")
		TextWeight:SetTextColor(Color(0,0,200,255))
		TextWeight:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextWeight )
	--acfmenupanel:CPanelText("FlywheelMass", "FlywheelMass : "..(Table.flywheelmass).." kg")
	TextFly = vgui.Create( "DLabel" )
		TextFly:SetText( "FlywheelMass : "..(Table.flywheelmass).." kg")
		TextFly:SetTextColor(Color(0,0,200,255))
		TextFly:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextFly )
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
			TextFuelCons:SizeToContents()
		acfmenupanel.CustomDisplay:AddItem( TextFuelCons )
	elseif Table.fuel == "Any" then
		local petrolcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Petrol"])
		local dieselcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity["Diesel"])
		--acfmenupanel:CPanelText("FuelConsP", "Petrol Use at "..peakkwrpm.." rpm : "..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
		TextFuelConsP = vgui.Create( "DLabel" )
			TextFuelConsP:SetText( "Petrol Use at "..peakkwrpm.." rpm : \n"..math.Round(petrolcons,2).." liters/min / "..math.Round(0.264*petrolcons,2).." gallons/min")
			TextFuelConsP:SetTextColor(Color(0,0,200,255))
			TextFuelConsP:SetFont( "DefaultBold" )
			TextFuelConsP:SizeToContents()
		acfmenupanel.CustomDisplay:AddItem( TextFuelConsP )
		--acfmenupanel:CPanelText("FuelConsD", "Diesel Use at "..peakkwrpm.." rpm : "..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
		TextFuelConsD = vgui.Create( "DLabel" )
			TextFuelConsD:SetText( "Diesel Use at "..peakkwrpm.." rpm : \n"..math.Round(dieselcons,2).." liters/min / "..math.Round(0.264*dieselcons,2).." gallons/min")
			TextFuelConsD:SetTextColor(Color(0,0,200,255))
			TextFuelConsD:SetFont( "DefaultBold" )
			TextFuelConsD:SizeToContents()
		acfmenupanel.CustomDisplay:AddItem( TextFuelConsD )
	else
		local fuelcons = ACF.FuelRate * ACF.Efficiency[Table.enginetype] * ACF.TorqueBoost * peakkw / (60 * ACF.FuelDensity[Table.fuel])
		--acfmenupanel:CPanelText("FuelCons", (Table.fuel).." Use at "..peakkwrpm.." rpm : "..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
		TextFuelCons = vgui.Create( "DLabel" )
			TextFuelCons:SetText( (Table.fuel).." Use at "..peakkwrpm.." rpm : \n"..math.Round(fuelcons,2).." liters/min / "..math.Round(0.264*fuelcons,2).." gallons/min")
			TextFuelCons:SetTextColor(Color(0,0,200,255))
			TextFuelCons:SetFont( "DefaultBold" )
			TextFuelCons:SizeToContents()
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
			TextFueledTorque:SetText( "Peak Torque : "..(Table.torque*ACF.TorqueBoost).." n/m  / "..math.Round(Table.torque*ACF.TorqueBoost*0.73).." ft-lb")
			TextFueledTorque:SetTextColor(Color(200,0,0,255))
			TextFueledTorque:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextFueledTorque )
	end
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end
