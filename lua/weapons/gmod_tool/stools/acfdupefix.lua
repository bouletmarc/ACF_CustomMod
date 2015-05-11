
local cat = ((ACFCUSTOM.CustomToolCategory and ACFCUSTOM.CustomToolCategory:GetBool()) and "ACF" or "Construction");

TOOL.Category		= cat
TOOL.Name			= "#Tool.acfdupefix.name"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
	language.Add( "Tool.acfdupefix.name", "ACF Custom Dupe Fixer" )
	language.Add( "Tool.acfdupefix.desc", "Load a dupe with a Custom Engine and replace it for a Original Engine." )
	language.Add( "Tool.acfdupefix.0", "1.Load a dupe file - 2.Replace not used values with ACF Original - 3.Save the new converted file - 4.Play on a server without ACF Custom Mod" )

	function TOOL.BuildCPanel( CPanel )
		local DupeFixer_Panel = vgui.RegisterFile( "acf/client/custommenu/dupefixer/acf_dupefixer_menu.lua" )
		local DPanel = vgui.CreateFromTable( DupeFixer_Panel )
		CPanel:AddPanel( DPanel )
	end
end
