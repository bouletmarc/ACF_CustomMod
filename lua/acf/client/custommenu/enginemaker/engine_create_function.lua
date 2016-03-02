--------------------------------------
--	Set invalid's models
--------------------------------------
local InvalidModelsTable = {}
table.insert(InvalidModelsTable, "linear_l.mdl")
table.insert(InvalidModelsTable, "linear_m.mdl")
table.insert(InvalidModelsTable, "linear_s.mdl")
table.insert(InvalidModelsTable, "linear_t.mdl")
table.insert(InvalidModelsTable, "t5large.mdl")
table.insert(InvalidModelsTable, "t5med.mdl")
table.insert(InvalidModelsTable, "t5small.mdl")
table.insert(InvalidModelsTable, "t5tiny.mdl")
table.insert(InvalidModelsTable, "transaxial_l.mdl")
table.insert(InvalidModelsTable, "transaxial_m.mdl")
table.insert(InvalidModelsTable, "transaxial_s.mdl")
table.insert(InvalidModelsTable, "transaxial_t.mdl")
table.insert(InvalidModelsTable, "flywheelclutchb.mdl")
table.insert(InvalidModelsTable, "flywheelclutchm.mdl")
table.insert(InvalidModelsTable, "flywheelclutchs.mdl")
table.insert(InvalidModelsTable, "flywheelclutcht.mdl")
table.insert(InvalidModelsTable, "pulsejets.mdl")
table.insert(InvalidModelsTable, "pulsejetm.mdl")
table.insert(InvalidModelsTable, "pulsejetl.mdl")
table.insert(InvalidModelsTable, "turbine_s.mdl")
table.insert(InvalidModelsTable, "turbine_m.mdl")
table.insert(InvalidModelsTable, "turbine_l.mdl")
table.insert(InvalidModelsTable, "gasturbine_s.mdl")
table.insert(InvalidModelsTable, "gasturbine_m.mdl")
table.insert(InvalidModelsTable, "gasturbine_l.mdl")
--------------------------------------
--	Set invalid's char
--------------------------------------
local invalid_filename_chars = {
	["\\"] = "",
	["|"] = "",
	['"'] = "",
}
--------------------------------------
--	Load all models
--------------------------------------
function LoadAllModels(OnlyTurbine, OnlyPulseJet)
	//Clear List
	ModelsList:Clear()
	
	local LastAdded
	if !OnlyTurbine and !OnlyPulseJet then
		local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
		for k, v in pairs(Name) do
			if not table.HasValue(InvalidModelsTable, v) then
				if v != LastAdded then
					LastAdded = v
					ModelsList:AddLine(v)
				end
			end
		end
		--Reload Model
		local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
		MdlText = "models/engines/"..tostring(Name[1])
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SizeToContents()
		DisplayModel:SetModel( MdlText )
		ModelsList:SelectFirstItem()
	elseif OnlyTurbine and !OnlyPulseJet then
		ModelsList:AddLine("turbine_s.mdl")
		ModelsList:AddLine("turbine_m.mdl")
		ModelsList:AddLine("turbine_l.mdl")
		ModelsList:AddLine("gasturbine_s.mdl")
		ModelsList:AddLine("gasturbine_m.mdl")
		ModelsList:AddLine("gasturbine_l.mdl")
		--Reload Model
		MdlText = "models/engines/".."turbine_s.mdl"
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SizeToContents()
		DisplayModel:SetModel( MdlText )
		ModelsList:SelectFirstItem()
	elseif !OnlyTurbine and OnlyPulseJet then
		ModelsList:AddLine("pulsejets.mdl")
		ModelsList:AddLine("pulsejetm.mdl")
		ModelsList:AddLine("pulsejetl.mdl")
		--Reload Model
		MdlText = "models/engines/".."pulsejets.mdl"
		EngineModel2:SetText( "Models :\n"..MdlText )
		EngineModel2:SizeToContents()
		DisplayModel:SetModel( MdlText )
		ModelsList:SelectFirstItem()
	end
end
------------------------------------------
--	Set Flywheel Override Entry to true/false
------------------------------------------
function SetFlywheelOver(Text, Editable)
	if Editable then
		FlywheelOverEntry:SetDrawBackground(true)
		FlywheelOverEntry:SetEditable(true)
	else
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
	end
	if Text != "" then
		FlywheelOverEntry:SetText(Text)
	end
end
------------------------------------------
--	Set Flywheel Override Entry to true/false
------------------------------------------
function SetPulsetJetLock(Locking)
	if Locking then
		LimitEntry:SetDrawBackground(false)
		LimitEntry:SetEditable(false)
		FlywheelEntry:SetDrawBackground(false)
		FlywheelEntry:SetEditable(false)
	else
		LimitEntry:SetDrawBackground(true)
		LimitEntry:SetEditable(true)
		FlywheelEntry:SetDrawBackground(true)
		FlywheelEntry:SetEditable(true)
	end
end
--------------------------------------------------
--	Set Entry to true(gaz or diesel) or false (electric or any)
--------------------------------------------------
function SetEntryTo(Entry)
	if Entry then
		IdleEntry:SetEditable(true)
		PeakMinEntry:SetEditable(true)
		PeakMaxEntry:SetEditable(true)
		IdleEntry:SetDrawBackground(true)
		PeakMinEntry:SetDrawBackground(true)
		PeakMaxEntry:SetDrawBackground(true)
	else
		IdleEntry:SetEditable(false)
		PeakMinEntry:SetEditable(false)
		PeakMaxEntry:SetEditable(false)
		IdleEntry:SetDrawBackground(false)
		PeakMinEntry:SetDrawBackground(false)
		PeakMaxEntry:SetDrawBackground(false)
	end
end
-------------------------------------------
--	Reload Last Engine is used the option
-------------------------------------------
function ReloadLastEngine()
	local EngT = {}
	local GetFile = file.Read("acf/lastengine.txt", "DATA")
	for w in string.gmatch(GetFile, "([^,]+)") do
		table.insert(EngT, w)
	end
	local ModelLoad = tostring(EngT[3])
	local EngineTypeLoad = tostring(EngT[5])
	local iSelectLoad = tostring(EngT[15])
	local IsTransLoad = tostring(EngT[16])
	
	EngineTypeButton:SetText(tostring(EngT[5]))
	
	--Set Fuel Type
	if string.find(ModelLoad, "/pulsejet") then
		--Pulsejet
		FuelTypeValue = 6
		SetEntryTo(false)
		LoadAllModels(false, true)
	else
		--All Others Types
		if EngineTypeLoad == "GenericPetrol" then
			FuelTypeValue = 0
			EngineTypeButton:SetText("Petrol")
		elseif EngineTypeLoad == "GenericDiesel" then
			FuelTypeValue = 1
			EngineTypeButton:SetText("Diesel")
		elseif EngineTypeLoad == "Wankel" then
			FuelTypeValue = 2
		elseif EngineTypeLoad == "Radial" then
			FuelTypeValue = 3
		elseif EngineTypeLoad == "Electric" then
			FuelTypeValue = 4
			SetEntryTo(false)
			SetFlywheelOver(EngT[17], true)
		elseif EngineTypeLoad == "Turbine" then
			FuelTypeValue = 5
			SetFlywheelOver(EngT[17], true)
			SetEntryTo(false)
			LoadAllModels(true, false)
		end
	end
	
	--Set FlywheelOverride
	if EngineTypeLoad == "Electric" or EngineTypeLoad == "Turbine" then
		SetFlywheelOver(EngT[17], true)
	else
		SetFlywheelOver("", false)
	end
	
	--PulseJet Lock
	if EngineTypeLoad == "Pulsejet" then
		SetPulsetJetLock(true)
	end
	
	--Set Values
	EngineName:SetText(EngT[1])
	EngineModel2:SetText("Models :\n"..ModelLoad)
	EngineModel2:SizeToContents()
	DisplayModel:SetModel(ModelLoad)
	TorqueEntry:SetText(EngT[6])
	IdleEntry:SetText(EngT[7])
	PeakMinEntry:SetText(EngT[8])
	PeakMaxEntry:SetText(EngT[9])
	LimitEntry:SetText(EngT[10])
	FlywheelEntry:SetText(EngT[11])
	WeightEntry:SetText(EngT[12])
	iSelectVal = tostring(EngT[15])
	IsTransVal = tostring(EngT[16])
	MdlText = ModelLoad
end
--------------------------------------
--	Set Engine Name
--------------------------------------
function SetEngineName()
	local NewName = EngineName:GetValue()
	for k, v in pairs(invalid_filename_chars) do
		if string.find(EngineName:GetValue(), k) then
			notification.AddLegacy("INVALID CHAR FOUND '"..k.."' - REMOVED", NOTIFY_ERROR, 5)
			NewName = string.gsub(EngineName:GetValue(), ".", invalid_filename_chars)
		end
		
	end
	--set color
	EngineName:SetTextColor(Color(ACFC.R,ACFC.G,ACFC.B,255))
	--set replaced name
	if EngineName:GetValue() != NewName then
		EngineName:SetText(NewName)
	end
end
--------------------------------------
--	Set Engine Model
--------------------------------------
function SetEngineModel(value)
	MdlText = "models/engines/"..tostring(value)
	EngineModel2:SetText( "Models :\n"..MdlText )
	EngineModel2:SizeToContents()
	DisplayModel:SetModel( MdlText )
end
--------------------------------------
--	Set Engine Fuel Type
--------------------------------------
function SetEngineFuelType()
	if FuelTypeValue == 0 then
		FuelTypeValue = 1
		EngineTypeButton:SetText("Diesel")
	elseif FuelTypeValue == 1 then
		FuelTypeValue = 2
		EngineTypeButton:SetText("Wankel")
	elseif FuelTypeValue == 2 then
		FuelTypeValue = 3
		EngineTypeButton:SetText("Radial")
	elseif FuelTypeValue == 3 then
		FuelTypeValue = 4
		EngineTypeButton:SetText("Electric")
		iSelectVal = "true"
		IsTransVal = "false"
		--Set False Values
		IdleEntry:SetText( "10" )
		PeakMinEntry:SetText( "10" )
		PeakMaxEntry:SetText( "10" )
		IdleEntry:SetTextColor(Color(0,0,200,255))
		PeakMinEntry:SetTextColor(Color(0,0,200,255))
		PeakMaxEntry:SetTextColor(Color(0,0,200,255))
		FlywheelOverEntry:SetTextColor(Color(200,0,0,255))
		--Reset Available Entry
		SetEntryTo(false)
		SetFlywheelOver("", true)
	elseif FuelTypeValue == 4 then
		FuelTypeValue = 5
		EngineTypeButton:SetText("Turbine")
		iSelectVal = "true"
		IsTransVal = "true"
		--Set False Values
		IdleEntry:SetText( "1" )
		PeakMinEntry:SetText( "1" )
		PeakMaxEntry:SetText( "1" )
		LoadAllModels(true, false)
	elseif FuelTypeValue == 5 and ACFCUSTOM.HasUnofficialExtra then
		FuelTypeValue = 6
		EngineTypeButton:SetText("Pulsejet")
		iSelectVal = "false"
		IsTransVal = "false"
		--Set False Values
		IdleEntry:SetText( "100" )
		PeakMinEntry:SetText( "1" )
		PeakMaxEntry:SetText( "1" )
		FlywheelEntry:SetText( "0.001" )
		LimitEntry:SetText( "50000" )
		LimitEntry:SetTextColor(Color(0,0,200,255))
		FlywheelEntry:SetTextColor(Color(0,0,200,255))
		FlywheelOverEntry:SetTextColor(Color(0,0,200,255))
		--Reset Available Entry
		SetFlywheelOver("1", false)
		SetPulsetJetLock(true)
		LoadAllModels(false, true)
	elseif (FuelTypeValue == 5 and !ACFCUSTOM.HasUnofficialExtra) or FuelTypeValue == 6 then
		FuelTypeValue = 0
		EngineTypeButton:SetText("Petrol")
		--Reset True Value
		IdleEntry:SetText( "Idle Number" )
		PeakMinEntry:SetText( "PeakMin RPM Number" )
		PeakMaxEntry:SetText( "PeakMax RPM Number" )
		LimitEntry:SetText( "Limit RPM Number" )
		IdleEntry:SetTextColor(Color(200,0,0,255))
		PeakMinEntry:SetTextColor(Color(200,0,0,255))
		PeakMaxEntry:SetTextColor(Color(200,0,0,255))
		LimitEntry:SetTextColor(Color(200,0,0,255))
		--Reset Available Entry
		SetFlywheelOver("Override Number", false)
		SetEntryTo(true)
		SetPulsetJetLock(false)
		LoadAllModels(false, false)
	end
end
--------------------------------------
--	Check if its number
--------------------------------------
function NumberCheck(CurrentNumberString)
	if string.match(CurrentNumberString, "[%a]") then
		notification.AddLegacy("FOUND A LETTER IN '"..CurrentNumberString.."' NUMBER!", NOTIFY_ERROR, 5)
		return false
	else
		return true
	end
end
--------------------------------------
--	Save & Next Step
--------------------------------------
function SaveAndNextStep()
	--set vars
	local NameLoadT = EngineName:GetValue()
	local FuelTypeLoadT = ""
	local EngineTypeLoadT = ""
	local TorqueLoadT = 1
	local IdleLoadT = 1
	local PeakMinLoadT = 1
	local PeakMaxLoadT = 1
	local LimitRpmLoadT = 1
	local FlywheelLoadT = 1
	local WeightLoadT = 1
	local FlywheelOverLoad = 1
	local FlywheelOverLoadT = 0
	
	local ErrorDetected = false
	
	if NumberCheck(tostring(TorqueEntry:GetValue())) then TorqueLoadT = TorqueEntry:GetValue() else ErrorDetected = true, TorqueEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(IdleEntry:GetValue())) then IdleLoadT = IdleEntry:GetValue() else ErrorDetected = true, IdleEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(PeakMinEntry:GetValue())) then PeakMinLoadT = PeakMinEntry:GetValue() else ErrorDetected = true, PeakMinEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(PeakMaxEntry:GetValue())) then PeakMaxLoadT = PeakMaxEntry:GetValue() else ErrorDetected = true, PeakMaxEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(LimitEntry:GetValue())) then LimitRpmLoadT = LimitEntry:GetValue() else ErrorDetected = true, LimitEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(FlywheelEntry:GetValue())) then FlywheelLoadT = FlywheelEntry:GetValue() else ErrorDetected = true, FlywheelEntry:SetTextColor(Color(200,0,0,255)) end
	if NumberCheck(tostring(WeightEntry:GetValue())) then WeightLoadT = WeightEntry:GetValue() else ErrorDetected = true, WeightEntry:SetTextColor(Color(200,0,0,255)) end
	if tostring(FlywheelOverEntry:GetValue()) != "Override Number" then
		if NumberCheck(tostring(FlywheelOverEntry:GetValue())) then FlywheelOverLoad = FlywheelOverEntry:GetValue() else ErrorDetected = true, FlywheelOverEntry:SetTextColor(Color(200,0,0,255)) end
	else
		FlywheelOverLoad = FlywheelOverEntry:GetValue()
	end
	
	--Go Back Error Detected
	if ErrorDetected then return false end
	
	--Reset Override Number
	if FlywheelOverLoad == "Override Number" then FlywheelOverLoadT = 0 else FlywheelOverLoadT = FlywheelOverLoad end
	
	local EngineLast = file.Read("acf/lastengine.txt", "DATA")
	local EngineLastTable = {}
	for w in string.gmatch(EngineLast, "([^,]+)") do
		table.insert(EngineLastTable, w)
	end
	local SoundLoadT = tostring(EngineLastTable[2])
	
	if FuelTypeValue == 0 then
		FuelTypeLoadT = "Petrol"
		EngineTypeLoadT = "GenericPetrol"
	elseif FuelTypeValue == 1 then
		FuelTypeLoadT = "Diesel"
		EngineTypeLoadT = "GenericDiesel"
	elseif FuelTypeValue == 2 then
		FuelTypeLoadT = "Petrol"
		EngineTypeLoadT = "Wankel"
	elseif FuelTypeValue == 3 then
		EngineTypeLoadT = "Radial"
	elseif FuelTypeValue == 4 then
		FuelTypeLoadT = "Electric"
		EngineTypeLoadT = "Electric"
	elseif FuelTypeValue == 5 then
		FuelTypeLoadT = "Multifuel"
		EngineTypeLoadT = "Turbine"
	elseif FuelTypeValue == 6 then
		FuelTypeLoadT = "Multifuel"
		--EngineTypeLoadT = "Pulsejet" --It Doesnt Work return this type, since its unavailable yet
		EngineTypeLoadT = "Turbine"
	end
	
	local txt = NameLoadT..","..SoundLoadT..","..MdlText..","..FuelTypeLoadT..","..EngineTypeLoadT..","..TorqueLoadT..","
	txt = txt ..IdleLoadT..","..PeakMinLoadT..","..PeakMaxLoadT..","..LimitRpmLoadT..","..FlywheelLoadT..","..WeightLoadT..","
	txt = txt ..EngSizeValue..","..EngTypeValue..","..iSelectVal..","..IsTransVal..","..FlywheelOverLoadT
	file.Write("acf/lastengine.txt", txt)
	
	return true
end
