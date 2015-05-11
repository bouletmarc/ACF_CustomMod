--------------------------------------
--	Set vars
--------------------------------------
local MainPanel = nil
--------------------------------------
--	Create Menu
--------------------------------------
local function CreateMenu()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize(550, 450)
	
	MainPanel:SetPos((ScrW()/2)-(MainPanel:GetWide()/2),(ScrH()/2)-(MainPanel:GetTall()/2))

	MainPanel:SetMinWidth(550)
	MainPanel:SetMinHeight(450)

	MainPanel:SetSizable(false)
	MainPanel:SetDeleteOnClose( true )
	MainPanel:SetTitle("Engine Menu V"..ACFCUSTOM.EngineMakerVersion.." - LOAD MENU")
	MainPanel:SetVisible(false)
	MainPanel:GetParent():SetWorldClicker(true) // Allow the use of the toolgun while in menu.
	--Add 2nd panel	
	local SecondPanel = MainPanel:Add("DPanel")
	SecondPanel:DockMargin(5, 5, 5, 5)
	SecondPanel:Dock(TOP)
	SecondPanel:SetTall(430)
	SecondPanel:SetWide(MainPanel:GetWide())
	SecondPanel:SetDrawBackground(false)
	--------------------------------------
	--	2nd Panel Menu
	--------------------------------------
		--text 
		SaveText1 = SecondPanel:Add("DLabel")
		SaveText1:SetText("Load Menu")
		SaveText1:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		SaveText1:SetPos(245,20)
		SaveText1:SetFont( "DefaultBold" )
		SaveText1:SizeToContents()
		
		--button
		BackButton	= SecondPanel:Add("DButton")
		BackButton:SetText("Back")
		BackButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		BackButton:SetPos(60,320)
		BackButton:SetWide(80)
		BackButton:SetTall(60)
		BackButton.DoClick = function()
			RunConsoleCommand("acf_enginestart_open")
			MainPanel:Close()
		end
		
		ExitButtonMode = 0
		ExitButton	= SecondPanel:Add("DButton")
		ExitButton:SetText("Close")
		ExitButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		ExitButton:SetPos(230,320)
		ExitButton:SetWide(100)
		ExitButton:SetTall(60)
		ExitButton.DoClick = function()
			MainPanel:Close()
			if ExitButtonMode == 1 then
				notification.AddLegacy("Dont forget to Update Engine Maker", NOTIFY_HINT, 5)
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				file.CreateDir("acf")
				file.Write("acf/lastengine.txt", tostring(GetFile))
			end
		end
		
		NextButton	= SecondPanel:Add("DButton")
		NextButton:SetText("Edit Engine")
		NextButton:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
		NextButton:SetPos(400,320)
		NextButton:SetWide(80)
		NextButton:SetTall(60)
		NextButton:SetDisabled(true)
		NextButton.DoClick = function()
			if ExitButtonMode == 1 then
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				file.CreateDir("acf")
				file.Write("acf/lastengine.txt", tostring(GetFile))
				EngineMakerUseLoad = true
				RunConsoleCommand("acf_enginecreate_open")
				MainPanel:Close()
			end
		end
		
		
		DermaListView = SecondPanel:Add("DListView")
		DermaListView:SetParent(SecondPanel)
		DermaListView:SetPos(20, 50)
		DermaListView:SetSize(160, 250)
		DermaListView:SetMultiSelect(false)
		DermaListView:AddColumn("Files")
		
		for _, file in ipairs( file.Find("acf/custom.engines/*.txt", "DATA") ) do
			DermaListView:AddLine(tostring(file))
		end
		
		DermaListViewSpec = SecondPanel:Add("DListView")
		DermaListViewSpec:SetParent(SecondPanel)
		DermaListViewSpec:SetPos(200, 50)
		DermaListViewSpec:SetSize(160, 250)
		DermaListViewSpec:SetMultiSelect(false)
		DermaListViewSpec:AddColumn("Engines Infos")
		
		DisplayModel = SecondPanel:Add("DModelPanel")
		DisplayModel:SetModel( "" )
		DisplayModel:SetCamPos( Vector( 250, 500, 250 ) )
		DisplayModel:SetLookAt( Vector( 0, 0, 0 ) )
		DisplayModel:SetFOV( 12 )
		DisplayModel:SetSize( 200, 200 )
		DisplayModel:SetPos( 360, 60 )
		DisplayModel.LayoutEntity = function( panel , entity ) end
		
		--On Clic
		DermaListView.OnClickLine = function(parent,selected,isselected)
			DermaListViewSpec:Clear()
			DisplayModel:SetModel( "" )
			ExitButtonMode = 0
			GetLineName = tostring(selected:GetValue(1))
			if GetLineName != "" then
				NextButton:SetDisabled(false)
				ExitButton:SetText("Use This Engine")
				ExitButton:SetToolTip("Dont forget to update the menu !")
				ExitButtonMode = 1
				local CustomEngineTable = {}
				local GetFile = file.Read("acf/custom.engines/"..GetLineName, "DATA")
				for w in string.gmatch(GetFile, "([^,]+)") do
					DermaListViewSpec:AddLine(tostring(w))
					table.insert(CustomEngineTable, w)
				end
				local ModelLoad = tostring(CustomEngineTable[3])
				DisplayModel:SetModel( ModelLoad )
			end
		end

	MainPanel:InvalidateLayout(true)
	
end
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
concommand.Add("acf_engineload_open", OpenMenu)