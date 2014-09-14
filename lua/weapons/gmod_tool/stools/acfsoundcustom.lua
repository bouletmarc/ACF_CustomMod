
TOOL.Category		= "Construction"
TOOL.Name			= "#Tool.acfsoundcustom.name"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar["pitch"] = "1"
if CLIENT then
	language.Add( "Tool.acfsoundcustom.name", "ACF Custom Sound Replacer" )
	language.Add( "Tool.acfsoundcustom.desc", "Change sound of customs engines." )
	language.Add( "Tool.acfsoundcustom.0", "Left click to apply sound. Right click to copy sound. Reload to set default sound." )
end

local function ReplaceSound( ply , Entity , data)
	if !IsValid( Entity ) then return end
	local sound = data[1]
	timer.Simple(1, function()
		if Entity:GetClass() == "acf_engine_custom" or Entity:GetClass() == "acf_enginemaker" then
			Entity.SoundPath = sound
			Entity.SoundPitch = ply:GetInfo("acfcustomsound_pitch")
		elseif Entity:GetClass() == "acf_turbo" or Entity:GetClass() == "acf_supercharger" then
			Entity.SoundPath = sound
		end
	end)
			
	duplicator.StoreEntityModifier( Entity, "acf_replacesound", {sound} )
end
duplicator.RegisterEntityModifier( "acf_replacesound", ReplaceSound )

local function IsReallyValid(trace, ply)
	local True = true
	local pl = ply;
	if not trace.Entity:IsValid() then True = false end
	if trace.Entity:IsPlayer() then True = false end
	if trace.Entity:GetClass() ~= "acf_engine_custom" and trace.Entity:GetClass() ~= "acf_enginemaker" and trace.Entity:GetClass() ~= "acf_turbo" and trace.Entity:GetClass() ~= "acf_supercharger" then True = false end
	if SERVER and not trace.Entity:GetPhysicsObject():IsValid() then True = false end
	
	if True then
		return false
	else
		ACFCUSTOM_SendNotify( pl, true, "You need to aim at engine or gun to change it's sound" );
		return true
	end
end

function TOOL:LeftClick(trace)
	if CLIENT or IsReallyValid( trace, self:GetOwner() ) then return false end
	local sound = self:GetOwner():GetInfo("wire_soundemitter_sound")
	ReplaceSound( self:GetOwner(), trace.Entity, {sound} )
	local pl = self:GetOwner();
	ACFCUSTOM_SendNotify( pl, true, "Sound Pasted successfully!" );
	return true
end

function TOOL:RightClick(trace)
	if CLIENT or IsReallyValid( trace, self:GetOwner() ) then return false end
	local pl = self:GetOwner();
	if trace.Entity:GetClass() == "acf_engine_custom" or trace.Entity:GetClass() == "acf_enginemaker" then
		self:GetOwner():ConCommand("wire_soundemitter_sound "..trace.Entity.SoundPath);
		self:GetOwner():ConCommand("acfcustomsound_pitch "..trace.Entity.SoundPitch);
		ACFCUSTOM_SendNotify( pl, true, "Engine Sound copied successfully!" );
	elseif trace.Entity:GetClass() == "acf_turbo" or trace.Entity:GetClass() == "acf_supercharger" then
		self:GetOwner():ConCommand("wire_soundemitter_sound "..trace.Entity.SoundPath);
		ACFCUSTOM_SendNotify( pl, true, "Turbo or Supercharger Sound copied successfully!" );
	end
	return true
end

function TOOL:Reload( trace )
	if CLIENT or IsReallyValid( trace, self:GetOwner() ) then return false end
	if trace.Entity:GetClass() == "acf_engine_custom" or trace.Entity:GetClass() == "acf_enginemaker" then
		local Id = trace.Entity.Id
		local List = list.Get("ACFCUSTOMEnts")
		self:GetOwner():ConCommand("acfcustomsound_pitch " ..(List["MobilityCustom"][Id]["pitch"] or 1));
		ReplaceSound( self:GetOwner(), trace.Entity, {List["MobilityCustom"][Id]["sound"]} )
	elseif trace.Entity:GetClass() == "acf_turbo" or trace.Entity:GetClass() == "acf_supercharger" then
		local Id = trace.Entity.Id
		local List = list.Get("ACFCUSTOMEnts")
		ReplaceSound( self:GetOwner(), trace.Entity, {List["MobilityCustom"][Id]["sound"]} )
	end
	return true
end

function TOOL.BuildCPanel(panel)
	local wide = panel:GetWide()

	local SoundNameText = vgui.Create("DTextEntry", ValuePanel)
	SoundNameText:SetText("")
	SoundNameText:SetWide(wide)
	SoundNameText:SetTall(20)
	SoundNameText:SetMultiline(false)
	SoundNameText:SetConVar("wire_soundemitter_sound")
	SoundNameText:SetVisible(true)
	panel:AddItem(SoundNameText)

	local SoundBrowserButton = vgui.Create("DButton")
	SoundBrowserButton:SetText("Open Sound Browser")
	SoundBrowserButton:SetWide(wide)
	SoundBrowserButton:SetTall(20)
	SoundBrowserButton:SetVisible(true)
	SoundBrowserButton.DoClick = function()
		RunConsoleCommand("wire_sound_browser_open",SoundNameText:GetValue())
	end
	panel:AddItem(SoundBrowserButton)

	local SoundPre = vgui.Create("DPanel")
	SoundPre:SetWide(wide)
	SoundPre:SetTall(20)
	SoundPre:SetVisible(true)

	local SoundPreWide = SoundPre:GetWide()

	local SoundPrePlay = vgui.Create("DButton", SoundPre)
	SoundPrePlay:SetText("Play")
	SoundPrePlay:SetWide(SoundPreWide / 2)
	SoundPrePlay:SetPos(0, 0)
	SoundPrePlay:SetTall(20)
	SoundPrePlay:SetVisible(true)
	SoundPrePlay.DoClick = function()
		RunConsoleCommand("play",SoundNameText:GetValue())
	end

	local SoundPreStop = vgui.Create("DButton", SoundPre)
	SoundPreStop:SetText("Stop")
	SoundPreStop:SetWide(SoundPreWide / 2)
	SoundPreStop:SetPos(SoundPreWide / 2, 0)
	SoundPreStop:SetTall(20)
	SoundPreStop:SetVisible(true)
	SoundPreStop.DoClick = function()
		RunConsoleCommand("play", "common/NULL.WAV") //Playing a silent sound will mute the preview but not the sound emitters.
	end
	panel:AddItem(SoundPre)
	SoundPre:InvalidateLayout(true)
	SoundPre.PerformLayout = function()
		local SoundPreWide = SoundPre:GetWide()
		SoundPrePlay:SetWide(SoundPreWide / 2)
		SoundPreStop:SetWide(SoundPreWide / 2)
		SoundPreStop:SetPos(SoundPreWide / 2, 0)
	end
	
	panel:AddControl("Slider", {
        Label = "Pitch:",
        Command = "acfcustomsound_pitch",
        Type = "Float",
        Min = "0.1",
        Max = "2",
    }):SetTooltip("Works only for engines.")
end