--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil

--Saving New Engine
function NewEngineSaveFunc()
	local LastEngineText = file.Read("acf/lastengine.txt")
	local EngT = {}
	for w in string.gmatch(LastEngineText, "([^,]+)") do
		table.insert(EngT, w)
	end

	local invalid_filename_chars = {
		["*"] = "",
		["?"] = "",
		[">"] = "",
		["<"] = "",
		["|"] = "",
		["\\"] = "",
		['"'] = "",
		[" "] = "_",
	}
	local Nametxtfile = string.lower(string.gsub(EngT[1], ".", invalid_filename_chars))
	
	file.Write("acf/custom.engines/"..Nametxtfile..".txt", tostring(LastEngineText)	--Save the engine
	file.Write("acf/lastengine.txt", tostring(LastEngineText))	--Save the engine also as
end
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetPos(500,200)
	MainPanel:SetSize(450, 450)

	MainPanel:SetMinWidth(450)
	MainPanel:SetMinHeight(450)

	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("Engine Menu V"..ACFCUSTOM.EngineMakerVersion.." - SAVE MENU")
	MainPanel:SetVisible(false)
	MainPanel:SetCookieName( "wire_sound_browser" )
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel	
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(5, 5, 5, 5)
	SecondPanel:Dock(TOP)
	SecondPanel:SetTall(440)
	SecondPanel:SetWide(MainPanel:GetWide())
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--text 
		SaveText1 = SecondPanel:Add("DLabel")
		SaveText1:SetText("Save Menu")
		SaveText1:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		SaveText1:SetPos(180,10)
		SaveText1:SetFont( "DefaultBold" )
		SaveText1:SizeToContents()
		
		
		DermaListView = SecondPanel:Add("DListView")
		DermaListView:SetParent(SecondPanel)
		DermaListView:SetPos(40, 30)
		DermaListView:SetSize(350, 280)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Descriptions")
		DermaListView:Clear()
		--load text for menu
		local LastEngineText2 = file.Read("acf/lastengine.txt")
		local EngT = {}
		for w in string.gmatch(LastEngineText2, "([^,]+)") do
			table.insert(EngT, w)
		end
		
		DermaListView:AddLine("1. Name : "..EngT[1])
		DermaListView:AddLine("2. Sound : "..EngT[2])
		DermaListView:AddLine("3. Model : "..EngT[3])
		DermaListView:AddLine("4. Fuel : "..EngT[4])
		DermaListView:AddLine("5. EngineType : "..EngT[5])
		DermaListView:AddLine("6. Torque : "..EngT[6])
		DermaListView:AddLine("7. Idle : "..EngT[7])
		DermaListView:AddLine("8. Peak Min : "..EngT[8])
		DermaListView:AddLine("9. Peak Max : "..EngT[9])
		DermaListView:AddLine("10. Limit : "..EngT[10])
		DermaListView:AddLine("11. Flywheel : "..EngT[11])
		DermaListView:AddLine("12. Weight : "..EngT[12])
		DermaListView:AddLine("13. iSelect : "..EngT[15])
		DermaListView:AddLine("14. IsTrans : "..EngT[16])
		DermaListView:AddLine("15. Flywheel Override : "..EngT[17])
		DermaListView:PerformLayout( )
		DermaListView:SetSortable(false)
		
		--button
		BackButton	= SecondPanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BackButton:SetPos(40,330)
		BackButton:SetWide(80)
		BackButton:SetTall(60)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginesound_open")
			MainPanel:Close()
		end
		
		NextButton	= SecondPanel:Add("DButton")
		NextButton:SetText("Quit without save")
		NextButton:SetToolTip("Dont forget to update the menu !")
		NextButton:SetTextColor(Color(255,0,0,255))
		NextButton:SetPos(300,330)
		NextButton:SetWide(100)
		NextButton:SetTall(60)
		NextButton.DoClick = function()
			MainPanel:Close()
			notification.AddLegacy("Dont forget to Update Engine Maker", NOTIFY_HINT, 5)
		end
		
		SaveButton	= SecondPanel:Add("DButton")
		SaveButton:SetText("Save")
		SaveButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		SaveButton:SetPos(170,330)
		SaveButton:SetWide(80)
		SaveButton:SetTall(60)
		SaveButton.DoClick = function()
			NewEngineSaveFunc()
			NextButton:SetText("Quit")
			NextButton:SetWide(80)
			NextButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		end

	MainPanel:InvalidateLayout(false)
	
end
--------------------------------------
--	Open Menu
--------------------------------------
local function OpenMenu(pl, cmd, args)
	if (!IsValid(MainPanel)) then
		CreateMenu(path)
	end

	MainPanel:SetVisible(true)
	MainPanel:MakePopup()
	MainPanel:InvalidateLayout(true)

	WireLib.Timedcall(function(MainPanel)
		if (!IsValid(MainPanel)) then return end

		MainPanel:InvalidateLayout(true)
	end, MainPanel)
end
concommand.Add("acf_enginesave_open", OpenMenu)