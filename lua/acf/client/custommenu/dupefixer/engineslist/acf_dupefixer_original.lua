--------------------------------------
--	Set all ACF original engine
--------------------------------------
EnginesOriginalTable = {}
--b4
table.insert(EnginesOriginalTable, "1.4-B4"..",models/engines/b4small.mdl")
table.insert(EnginesOriginalTable, "2.1-B4"..",models/engines/b4small.mdl")
table.insert(EnginesOriginalTable, "2.4-B4"..",models/engines/b4small.mdl")
table.insert(EnginesOriginalTable, "3.2-B4"..",models/engines/b4med.mdl")
--b6
table.insert(EnginesOriginalTable, "2.8-B6"..",models/engines/b6small.mdl")
table.insert(EnginesOriginalTable, "5.0-B6"..",models/engines/b6med.mdl")
table.insert(EnginesOriginalTable, "5.4-B6"..",models/engines/b6med.mdl")
table.insert(EnginesOriginalTable, "10.0-B6"..",models/engines/b6large.mdl")
--electric
table.insert(EnginesOriginalTable, "Electric-Small"..",models/engines/emotorsmall.mdl")
table.insert(EnginesOriginalTable, "Electric-Medium"..",models/engines/emotormed.mdl")
table.insert(EnginesOriginalTable, "Electric-Large"..",models/engines/emotorlarge.mdl")
table.insert(EnginesOriginalTable, "Electric-Small-NoBatt"..",models/engines/emotor-standalone-sml.mdl")
table.insert(EnginesOriginalTable, "Electric-Medium-NoBatt"..",models/engines/emotor-standalone-mid.mdl")
table.insert(EnginesOriginalTable, "Electric-Large-NoBatt"..",models/engines/emotor-standalone-big.mdl")
table.insert(EnginesOriginalTable, "Electric-Tiny-NoBatt"..",models/engines/emotor-standalone-tiny.mdl")
--i3
table.insert(EnginesOriginalTable, "1.1-I3"..",models/engines/inline3s.mdl")
table.insert(EnginesOriginalTable, "1.2-I3"..",models/engines/inline3s.mdl")
table.insert(EnginesOriginalTable, "2.8-I3"..",models/engines/inline3m.mdl")
table.insert(EnginesOriginalTable, "3.4-I3"..",models/engines/inline3m.mdl")
table.insert(EnginesOriginalTable, "11.0-I3"..",models/engines/inline3b.mdl")
table.insert(EnginesOriginalTable, "13.5-I3"..",models/engines/inline3b.mdl")
--i4
table.insert(EnginesOriginalTable, "1.5-I4"..",models/engines/inline4s.mdl")
table.insert(EnginesOriginalTable, "1.6-I4"..",models/engines/inline4s.mdl")
table.insert(EnginesOriginalTable, "3.1-I4"..",models/engines/inline4m.mdl")
table.insert(EnginesOriginalTable, "3.7-I4"..",models/engines/inline4m.mdl")
table.insert(EnginesOriginalTable, "15.0-I4"..",models/engines/inline4b.mdl")
table.insert(EnginesOriginalTable, "16.0-I4"..",models/engines/inline4b.mdl")
--i5
table.insert(EnginesOriginalTable, "2.3-I5"..",models/engines/inline5s.mdl")
table.insert(EnginesOriginalTable, "2.9-I5"..",models/engines/inline5s.mdl")
table.insert(EnginesOriginalTable, "3.9-I5"..",models/engines/inline5m.mdl")
table.insert(EnginesOriginalTable, "4.1-I5"..",models/engines/inline5m.mdl")
--i6
table.insert(EnginesOriginalTable, "2.2-I6"..",models/engines/inline6s.mdl")
table.insert(EnginesOriginalTable, "3.0-I6"..",models/engines/inline6s.mdl")
table.insert(EnginesOriginalTable, "4.8-I6"..",models/engines/inline6m.mdl")
table.insert(EnginesOriginalTable, "6.5-I6"..",models/engines/inline6m.mdl")
table.insert(EnginesOriginalTable, "17.2-I6"..",models/engines/inline6b.mdl")
table.insert(EnginesOriginalTable, "20.0-I6"..",models/engines/inline6b.mdl")
--radial
table.insert(EnginesOriginalTable, "3.8-R7"..",models/engines/radial7s.mdl")
table.insert(EnginesOriginalTable, "11.0-R7"..",models/engines/radial7m.mdl")
table.insert(EnginesOriginalTable, "24.0-R7"..",models/engines/radial7l.mdl")
--rotary
table.insert(EnginesOriginalTable, "900cc-R"..",models/engines/wankel_2_small.mdl")
table.insert(EnginesOriginalTable, "1.3L-R"..",models/engines/wankel_2_med.mdl")
table.insert(EnginesOriginalTable, "2.0L-R"..",models/engines/wankel_3_med.mdl")
--single
table.insert(EnginesOriginalTable, "0.25-I1"..",models/engines/1cylsml.mdl")
table.insert(EnginesOriginalTable, "0.5-I1"..",models/engines/1cylmed.mdl")
table.insert(EnginesOriginalTable, "1.3-I1"..",models/engines/1cylbig.mdl")
--special (2nd 'string' equal the engine type)
table.insert(EnginesOriginalTable, "0.9L-I2"..",models/engines/inline2s.mdl")
table.insert(EnginesOriginalTable, "1.0L-I4"..",models/engines/inline4s.mdl")
table.insert(EnginesOriginalTable, "1.8L-V4"..",models/engines/v4s.mdl")
table.insert(EnginesOriginalTable, "2.4L-V6"..",models/engines/v6s.mdl")
table.insert(EnginesOriginalTable, "1.9L-I4"..",models/engines/inline4s.mdl")
table.insert(EnginesOriginalTable, "2.6L-Wankel"..",models/engines/wankel_4_med.mdl")
table.insert(EnginesOriginalTable, "2.9-V8"..",models/engines/v8s.mdl")
table.insert(EnginesOriginalTable, "3.8-I6"..",models/engines/inline6m.mdl")
table.insert(EnginesOriginalTable, "5.3-V10"..",models/engines/v10sml.mdl")
table.insert(EnginesOriginalTable, "7.2-V8"..",models/engines/v8m.mdl")
table.insert(EnginesOriginalTable, "3.0-V12"..",models/engines/v12s.mdl")
--turbine
table.insert(EnginesOriginalTable, "Turbine-Small"..",models/engines/turbine_s.mdl")
table.insert(EnginesOriginalTable, "Turbine-Small-Trans"..",models/engines/turbine_m.mdl")
table.insert(EnginesOriginalTable, "Turbine-Medium"..",models/engines/turbine_l.mdl")
table.insert(EnginesOriginalTable, "Turbine-Medium-Trans"..",models/engines/gasturbine_s.mdl")
table.insert(EnginesOriginalTable, "Turbine-Large-Trans"..",models/engines/gasturbine_m.mdl")
table.insert(EnginesOriginalTable, "Turbine-Large"..",models/engines/gasturbine_l.mdl")
--v2
table.insert(EnginesOriginalTable, "0.6-V2"..",models/engines/v-twins2.mdl")
table.insert(EnginesOriginalTable, "1.2-V2"..",models/engines/v-twinm2.mdl")
table.insert(EnginesOriginalTable, "2.4-V2"..",models/engines/v-twinl2.mdl")
--v6
table.insert(EnginesOriginalTable, "3.6-V6"..",models/engines/v6small.mdl")
table.insert(EnginesOriginalTable, "5.2-V6"..",models/engines/v6med.mdl")
table.insert(EnginesOriginalTable, "6.2-V6"..",models/engines/v6med.mdl")
table.insert(EnginesOriginalTable, "12.0-V6"..",models/engines/v6large.mdl")
--v8
table.insert(EnginesOriginalTable, "4.5-V8"..",models/engines/v8s.mdl")
table.insert(EnginesOriginalTable, "5.7-V8"..",models/engines/v8s.mdl")
table.insert(EnginesOriginalTable, "7.8-V8"..",models/engines/v8m.mdl")
table.insert(EnginesOriginalTable, "9.0-V8"..",models/engines/v8m.mdl")
table.insert(EnginesOriginalTable, "18.0-V8"..",models/engines/v8l.mdl")
table.insert(EnginesOriginalTable, "19.0-V8"..",models/engines/v8l.mdl")
--v10
table.insert(EnginesOriginalTable, "4.3-V10"..",models/engines/v10sml.mdl")
table.insert(EnginesOriginalTable, "8.0-V10"..",models/engines/v10med.mdl")
table.insert(EnginesOriginalTable, "22.0-V10"..",models/engines/v10big.mdl")
--v12
table.insert(EnginesOriginalTable, "4.0-V12"..",models/engines/v12s.mdl")
table.insert(EnginesOriginalTable, "4.6-V12"..",models/engines/v12s.mdl")
table.insert(EnginesOriginalTable, "7.0-V12"..",models/engines/v12m.mdl")
table.insert(EnginesOriginalTable, "9.2-V12"..",models/engines/v12m.mdl")
table.insert(EnginesOriginalTable, "13.0-V12"..",models/engines/v12m.mdl")
table.insert(EnginesOriginalTable, "23.0-V12"..",models/engines/v12l.mdl")
table.insert(EnginesOriginalTable, "21.0-V12"..",models/engines/v12l.mdl")


--Add to Allowed table
for k, v in pairs(EnginesOriginalTable) do
	local TemporaryTable = {}
	for w in string.gmatch(v, "([^,]+)") do
		table.insert(TemporaryTable, w)
	end
	table.insert(EnginesAllowedTable, TemporaryTable[1])
end
