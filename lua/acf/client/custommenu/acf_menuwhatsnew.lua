--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
local Changelog = {}
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()
	--Set frame
	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(350, 450)
	--Set Center
	MainPanel:SetPos(((ScrW()/2)-(MainPanel:GetWide()/2))+ScrW()/4,(ScrH()/2)-(MainPanel:GetTall()/2))
	--Set size
	MainPanel:SetMinWidth(350)
	MainPanel:SetMinHeight(450)
	--Set options
	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("Whats New Menu V8.1")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(4, 4, 4, 4)
	SecondPanel:Dock(TOP)
	SecondPanel:SetSize(330, 406)
	SecondPanel:SetDrawBackground(true)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--Set text
		local Text = SecondPanel:Add("DLabel")
		Text:SetPos(70,20)
		Text:SetFont( "DefaultBold" )
		Text:SetText("Whats New in ACF Custom Rev : "..ACFCUSTOM.Version)
		Text:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Text:SizeToContents()
		--Set close button
		local Close = SecondPanel:Add("DButton")
		Close:SetText("Close")
		Close:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		Close:SetPos( 120,340 )
		Close:SetWide(80)
		Close:SetTall( 50 )
		Close.DoClick = function()
			MainPanel:Close()
		end
		--Revision list
		Rev = SecondPanel:Add("DPanelList")
		Rev:SetSpacing( 10 )
		Rev:EnableHorizontal( false ) 
		Rev:EnableVerticalScrollbar( true )
		Rev:SetSize( 300, 240 )
		Rev:SetPos( 20, 50 )
		
	SecondPanel:PerformLayout()
	
	if Changelog then
		Rev:PerformLayout()
		UpdateMenu( {rev = table.maxn(Changelog)} )
	end
	
	MainPanel:InvalidateLayout(false)
end
--------------------------------------
--	Update Menu
--------------------------------------
function UpdateMenu( Table )
	--Clear text
	if TextLog2 then TextLog2:Remove() end
	--Set Changelog text
	TextLog2 = vgui.Create( "DLabel" )
		TextLog2:SetText( Changelog[Table["rev"]])
		TextLog2:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		TextLog2:SetFont( "DefaultBold" )
		TextLog2:SetWrap(true)
		TextLog2:SetAutoStretchVertical(true)
	Rev:AddItem( TextLog2 )
	
	Rev:PerformLayout()
end
--------------------------------------
--	Changelog Calling
--------------------------------------
local function ACFChangelogHTTPCallBack(contents , size)
	local Temp = string.Explode( "*", contents )
	Changelog = {}
	for Key,String in pairs(Temp) do
		Changelog[tonumber(string.sub(String,2,4))] = string.Trim(string.sub(String, 5))
	end
	table.SortByKey(Changelog,true)
end
http.Fetch("https://raw.github.com/bouletmarc/ACF_CustomMod/master/changelogcustom.txt", ACFChangelogHTTPCallBack, function() end)
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
concommand.Add("acf_whatsnew_open", OpenMenu)