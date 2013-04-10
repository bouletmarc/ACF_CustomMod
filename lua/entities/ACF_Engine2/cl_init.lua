include("shared.lua")

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

ENT.AutomaticFrameAdvance = true 

function ENT:Draw()
	self:DoNormalDraw()
	self:DrawModel()
    Wire_Render(self.Entity)
end

function ENT:DoNormalDraw()
	local e = self.Entity
	if (LocalPlayer():GetEyeTrace().Entity == e and EyePos():Distance(e:GetPos()) < 256) then
		if(self:GetOverlayText() ~= "") then
			AddWorldTip(e:EntIndex(),self:GetOverlayText(),0.5,e:GetPos(),e)
		end
	end
end

function ENT:GetOverlayText()
	local name = self.Entity:GetNetworkedString("WireName")
	local Type = self.Entity:GetNetworkedBeamString("Type")
	local Power = self.Entity:GetNetworkedBeamInt("Power")
	local Torque = self.Entity:GetNetworkedBeamInt("Torque")
	local MinRPM = self.Entity:GetNetworkedBeamInt("MinRPM")
	local MaxRPM = self.Entity:GetNetworkedBeamInt("MaxRPM")
	local LimitRPM = self.Entity:GetNetworkedBeamInt("LimitRPM")
	--##################################################################
	local FlywheelMass = self.Entity:GetNetworkedBeamInt("FlywheelMass2")
	local Idle = self.Entity:GetNetworkedBeamInt("Idle")
	local Weight = self.Entity:GetNetworkedBeamInt("Weight")
	local Rpm = self.Entity:GetNetworkedBeamInt("Rpm")
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

function ACFEngine2GUICreate( Table )

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
	
	for ID,Value in pairs(acfmenupanel.ModData[Table.id]["ModTable"]) do
		if ID == 1 then
			ACF_ModingSlider1(1, Value, Table.id, "Torque")
		elseif ID == 2 then
			ACF_ModingSlider2(2, Value, Table.id, "Idle Rpm")
		elseif ID == 3 then
			ACF_ModingSlider3(3, Value, Table.id, "Peak Minimum Rpm")
		elseif ID == 4 then
			ACF_ModingSlider4(4, Value, Table.id, "Peak Maximum Rpm")
		elseif ID == 5 then
			ACF_ModingSlider4(5, Value, Table.id, "Limit Rpm")
		elseif ID == 6 then
			ACF_ModingSlider5(6, Value, Table.id, "Flywheel Mass")
		end
	end
	
	--acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
	TextWeight = vgui.Create( "DLabel" )
		TextWeight:SetText( "Weight : "..(Table.weight).." kg")
		TextWeight:SetTextColor(Color(0,0,200,255))
		TextWeight:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextWeight )
	--##################################################################
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end

--##################################################################
--##################################################################

function ACF_ModingSlider1(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Torque"..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 40 )
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

function ACF_ModingSlider2(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Idle Rpm"..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 600 )
			acfmenupanel["CData"][Mod]:SetMax( 1500 )
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

function ACF_ModingSlider3(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Peak Minimum Rpm"..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 1300 )
			acfmenupanel["CData"][Mod]:SetMax( 4500 )
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

function ACF_ModingSlider4(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Rpm"..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 4500 )
			acfmenupanel["CData"][Mod]:SetMax( 12000 )
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

function ACF_ModingSlider5(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Flywheel Mass"..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 0.01 )
			acfmenupanel["CData"][Mod]:SetMax( 1 )
			acfmenupanel["CData"][Mod]:SetDecimals( 2 )
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
