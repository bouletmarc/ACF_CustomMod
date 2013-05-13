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
		TextDesc:SetText( "Desc : "..Table.desc)
		TextDesc:SetTextColor(Color(0,0,200,255))
		TextDesc:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextDesc )
	
	--####################
	if (Table.iselec == true )then
		--acfmenupanel:CPanelText("Power", "Peak Power : "..Table.elecpower.." kW / "..math.Round(Table.elecpower*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
		TextPower = vgui.Create( "DLabel" )
			TextPower:SetText( "Peak Power : "..Table.elecpower.." kW / "..math.Round(Table.elecpower*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
			TextPower:SetTextColor(Color(0,0,200,255))
			TextPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextPower )
	else	
		--acfmenupanel:CPanelText("Power", "Peak Power : "..(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)).." kW / "..math.Round(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
		TextPower = vgui.Create( "DLabel" )
			TextPower:SetText( "Peak Power : "..(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)).." kW / "..math.Round(math.floor(Table.torque * Table.peakmaxrpm / 9548.8)*1.34).." HP @ "..(Table.peakmaxrpm).." RPM")
			TextPower:SetTextColor(Color(0,0,200,255))
			TextPower:SetFont( "DefaultBold" )
		acfmenupanel.CustomDisplay:AddItem( TextPower )
	end

	--acfmenupanel:CPanelText("Torque", "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
	TextTorque = vgui.Create( "DLabel" )
		TextTorque:SetText( "Peak Torque : "..(Table.torque).." n/m  / "..math.Round(Table.torque*0.73).." ft-lb")
		TextTorque:SetTextColor(Color(0,0,200,255))
		TextTorque:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextTorque )
	--acfmenupanel:CPanelText("RPM", "Idle : "..(Table.idlerpm).." RPM\nIdeal RPM Range : "..(Table.peakminrpm).."-"..(Table.peakmaxrpm).." RPM\nRedline : "..(Table.limitprm).." RPM")
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
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end
