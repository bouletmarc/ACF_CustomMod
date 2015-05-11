--------------------------------------
--	Set invalid's models
--------------------------------------
local InvalidModelsTable = {}
table.insert(InvalidModelsTable, "linear_l.mdl")
table.insert(InvalidModelsTable, "linear_m.mdl")
table.insert(InvalidModelsTable, "linear_s.mdl")
table.insert(InvalidModelsTable, "t5large.mdl")
table.insert(InvalidModelsTable, "t5med.mdl")
table.insert(InvalidModelsTable, "t5small.mdl")
table.insert(InvalidModelsTable, "transaxial_l.mdl")
table.insert(InvalidModelsTable, "transaxial_m.mdl")
table.insert(InvalidModelsTable, "transaxial_s.mdl")
table.insert(InvalidModelsTable, "flywheelclutchb.mdl")
table.insert(InvalidModelsTable, "flywheelclutchm.mdl")
table.insert(InvalidModelsTable, "flywheelclutchs.mdl")
table.insert(InvalidModelsTable, "flywheelclutcht.mdl")
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
function LoadAllModels()
	local LastAdded
	local Name, Ext = file.Find("models/engines/*.mdl", "GAME")
	for k, v in pairs(Name) do
		if not table.HasValue(InvalidModelsTable, v) then
			if v != LastAdded then
				LastAdded = v
				ModelsList:AddLine(v)
			end
		end
	end
end
------------------------------------------
--	Set Flywheel Override Entry to false
------------------------------------------
function SetFlywheelOverFalse(Text)
	FlywheelOverEntry:SetDrawBackground(false)
	FlywheelOverEntry:SetEditable(false)
	if Text then
		FlywheelOverEntry:SetText(Text)
	end
end
------------------------------------------
--	Set Flywheel Override Entry to true
------------------------------------------
function SetFlywheelOverTrue(Text)
	FlywheelOverEntry:SetDrawBackground(true)
	FlywheelOverEntry:SetEditable(true)
	if Text then
		FlywheelOverEntry:SetText(Text)
	end
end
--------------------------------------------------
--	Set Entry to true since its gaz or diesel
--------------------------------------------------
function SetEntryToTrue()
	IdleEntry:SetEditable(true)
	PeakMinEntry:SetEditable(true)
	PeakMaxEntry:SetEditable(true)
	IdleEntry:SetDrawBackground(true)
	PeakMinEntry:SetDrawBackground(true)
	PeakMaxEntry:SetDrawBackground(true)
end
--------------------------------------------------
--	Set Entry to false since its electric or any
--------------------------------------------------
function SetEntryToFalse()
	IdleEntry:SetEditable(false)
	PeakMinEntry:SetEditable(false)
	PeakMaxEntry:SetEditable(false)
	IdleEntry:SetDrawBackground(false)
	PeakMinEntry:SetDrawBackground(false)
	PeakMaxEntry:SetDrawBackground(false)
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
	local FuelTypeLoad = tostring(EngT[4])
	local WeightLoad = tonumber(EngT[12])
	local iSelectLoad = tostring(EngT[15])
	local IsTransLoad = tostring(EngT[16])
	
	--Set Fuel Type
	if FuelTypeLoad == "Petrol" then
		FuelTypeValue = 0
	elseif FuelTypeLoad == "Diesel" then
		FuelTypeValue = 1
	elseif FuelTypeLoad == "Electric" then
		FuelTypeValue = 2
		--set false entry
		SetEntryToFalse()
	elseif FuelTypeLoad == "Any" then
		FuelTypeValue = 3
		--set false entry
		SetEntryToFalse()
	end
	
	--Set Electric
	if iSelectLoad == "true" and IsTransLoad == "false" then
		SetFlywheelOverTrue(EngT[17])
	--Set Turbine
	elseif iSelectLoad == "true" and IsTransLoad == "true" then
		SetFlywheelOverTrue(EngT[17])
	--Set others Engines
	else
		FlywheelOverEntry:SetDrawBackground(false)
		FlywheelOverEntry:SetEditable(false)
		FlywheelOverEntry:SetText("Override Number")
	end
	
	--Set Values
	EngineName:SetText(EngT[1])
	FuelTypeButton:SetText(FuelTypeLoad)
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
	iSelectVal = iSelectLoad
	IsTransVal = IsTransLoad
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
		FuelTypeButton:SetText("Diesel")
	elseif FuelTypeValue == 1 then
		FuelTypeValue = 2
		FuelTypeButton:SetText("Electric")
		iSelectVal = "true"
		IsTransVal = "false"
		--Set False Values
		IdleEntry:SetText( "10" )
		PeakMinEntry:SetText( "10" )
		PeakMaxEntry:SetText( "10" )
		--set false entry
		SetEntryToFalse()
		--Set True Value
		SetFlywheelOverTrue()
	elseif FuelTypeValue == 2 then
		FuelTypeValue = 3
		FuelTypeButton:SetText("Turbine")
		iSelectVal = "true"
		IsTransVal = "true"
		--Set False Values
		IdleEntry:SetText( "1" )
		PeakMinEntry:SetText( "1" )
		PeakMaxEntry:SetText( "1" )
		--set false entry
		SetEntryToFalse()
		--Set True Value
		SetFlywheelOverTrue()
	elseif FuelTypeValue == 3 then
		FuelTypeValue = 0
		FuelTypeButton:SetText("Petrol")
		iSelectVal = "false"
		IsTransVal = "false"
		--Reset True Value
		IdleEntry:SetText( "Idle Number" )
		PeakMinEntry:SetText( "PeakMin RPM Number" )
		PeakMaxEntry:SetText( "PeakMax RPM Number" )
		--Set true entry
		SetEntryToTrue()
		--Reset False Value
		SetFlywheelOverFalse("Override Number")
	end
end
--------------------------------------
--	Check if its number
--------------------------------------
function NumberCheck(CurrentNumberString, ReturnMode)
	local HasLetter = false
	if string.match(CurrentNumberString, "[%a]") != nil then
		HasLetter = true
	end
	--check for letters
	if HasLetter then
		--set error message
		notification.AddLegacy("FOUND A LETTER IN '"..CurrentNumberString.."' NUMBER!", NOTIFY_ERROR, 5)
		if ReturnMode then
			return false
		end
	elseif ReturnMode then
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
	
	--torque
	if NumberCheck(tostring(TorqueEntry:GetValue()), true) then
		TorqueLoadT = TorqueEntry:GetValue()
	else
		return false
	end
	--idle
	if NumberCheck(tostring(IdleEntry:GetValue()), true) then
		IdleLoadT = IdleEntry:GetValue()
	else
		return false
	end
	--peak min
	if NumberCheck(tostring(PeakMinEntry:GetValue()), true) then
		PeakMinLoadT = PeakMinEntry:GetValue()
	else
		return false
	end
	--peak max
	if NumberCheck(tostring(PeakMaxEntry:GetValue()), true) then
		PeakMaxLoadT = PeakMaxEntry:GetValue()
	else
		return false
	end
	--limit
	if NumberCheck(tostring(LimitEntry:GetValue()), true) then
		LimitRpmLoadT = LimitEntry:GetValue()
	else
		return false
	end
	--flywheel
	if NumberCheck(tostring(FlywheelEntry:GetValue()), true) then
		FlywheelLoadT = FlywheelEntry:GetValue()
	else
		return false
	end
	--weight
	if NumberCheck(tostring(WeightEntry:GetValue()), true) then
		WeightLoadT = WeightEntry:GetValue()
	else
		return false
	end
	--flywheel override
	if tostring(FlywheelOverEntry:GetValue()) != "Override Number" then
		if NumberCheck(tostring(FlywheelOverEntry:GetValue()), true) then
			FlywheelOverLoad = FlywheelOverEntry:GetValue()
		else
			return false
		end
	else
		FlywheelOverLoad = FlywheelOverEntry:GetValue()
	end
	
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
		FuelTypeLoadT = "Electric"
		EngineTypeLoadT = "Electric"
	elseif FuelTypeValue == 3 then
		FuelTypeLoadT = "Any"
		EngineTypeLoadT = "Turbine"
	end
	
	local txt = NameLoadT..","..SoundLoadT..","..MdlText..","..FuelTypeLoadT..","..EngineTypeLoadT..","..TorqueLoadT..","
	txt = txt ..IdleLoadT..","..PeakMinLoadT..","..PeakMaxLoadT..","..LimitRpmLoadT..","..FlywheelLoadT..","..WeightLoadT..","
	txt = txt ..EngSizeValue..","..EngTypeValue..","..iSelectVal..","..IsTransVal..","..FlywheelOverLoadT
	file.Write("acf/lastengine.txt", txt)
	
	return true
end
