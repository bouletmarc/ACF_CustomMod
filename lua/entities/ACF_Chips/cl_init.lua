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
	local TorqueAdd = self:GetNetworkedBeamInt("TorqueAdd")
	local MaxRPMAdd = self:GetNetworkedBeamInt("MaxRPMAdd")
	local LimitRPMAdd = self:GetNetworkedBeamInt("LimitRPMAdd")
	local Weight = self:GetNetworkedBeamInt("Weight")
	
	local txt = Type.."\nTorque Add : "..TorqueAdd.."Tq\nMax Rpm Add : "..MaxRPMAdd.."Rpm\nLimit Rpm Add : "..LimitRPMAdd.."Rpm\nWeight : "..Weight.."Kg\n" or ""
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

function ACFChipsGUICreate( Table )

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
			ACF_ChipSlider1(1, Value, Table.id, "Torque Adding")
		elseif ID == 2 then
			ACF_ChipSlider2(2, Value, Table.id, "Rpm Max Adding")
		elseif ID == 3 then
			ACF_ChipSlider2(3, Value, Table.id, "Rpm Limit Adding")
		end
	end
	
	--acfmenupanel:CPanelText("Weight", "Weight : "..(Table.weight).." kg")
	TextWeight = vgui.Create( "DLabel" )
		TextWeight:SetText( "Weight : "..(Table.weight).." kg")
		TextWeight:SetTextColor(Color(0,0,200,255))
		TextWeight:SetFont( "DefaultBold" )
	acfmenupanel.CustomDisplay:AddItem( TextWeight )
	
	acfmenupanel.CustomDisplay:PerformLayout()
	
end

function ACF_ChipSlider1(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Torque Adding "..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 10 )
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

function ACF_ChipSlider2(Mod, Value, ID, Desc)

	if Mod and not acfmenupanel["CData"][Mod] then	
		acfmenupanel["CData"][Mod] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Mod]:SetText( Desc or "Adding "..Mod )
			acfmenupanel["CData"][Mod]:SetMin( 100 )
			acfmenupanel["CData"][Mod]:SetMax( 5000 )
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