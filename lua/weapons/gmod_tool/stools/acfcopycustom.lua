
TOOL.Category		= "Construction";
TOOL.Name			= "#Tool.acfcopycustom.listname";
TOOL.Author 		= "looter and bouletmarc";
TOOL.Command		= nil;
TOOL.ConfigName		= "";

TOOL.GearboxCopyData = {};
TOOL.EngineMakerCopyData = {};
TOOL.ChipsData = {};

if CLIENT then

	language.Add( "Tool.acfcopycustom.listname", "ACF Custom Copy Tool" );
	language.Add( "Tool.acfcopycustom.name", "ACF Custom Copy Tool Custom" );
	language.Add( "Tool.acfcopycustom.desc", "Copy gearbox/custom data from one object to another" );
	language.Add( "Tool.acfcopycustom.0", "Left click to paste data, Right click to copy data" );

	function TOOL.BuildCPanel( CPanel )
	
	end

end

-- Update
function TOOL:LeftClick( trace )

	if CLIENT then return end

	local ent = trace.Entity;

	if !IsValid( ent ) then 
		return false;
	end

	local pl = self:GetOwner();

	if( ent:GetClass() == "acf_gearbox" or ent:GetClass() == "acf_gearboxcvt" or ent:GetClass() == "acf_gearboxauto" and #self.GearboxCopyData > 1 and ent.CanUpdate ) then
		local success, msg = ent:Update( self.GearboxCopyData );
		ACFCUSTOM_SendNotify( pl, success, msg );
	end
	
	if( ent:GetClass() == "acf_enginemaker" and #self.EngineMakerCopyData > 1 and ent.CanUpdate ) then
		local success, msg = ent:Update( self.EngineMakerCopyData );
		ACFCUSTOM_SendNotify( pl, success, msg );
	end
	
	if( ent:GetClass() == "acf_chips" and #self.ChipsData > 1 and ent.CanUpdate ) then
		local success, msg = ent:Update( self.ChipsData );
		ACFCUSTOM_SendNotify( pl, success, msg );
	end

	return true;
end

-- Copy
function TOOL:RightClick( trace )

	if CLIENT then return end

	local ent = trace.Entity;

	if !IsValid( ent ) then 
		return false;
	end

	local pl = self:GetOwner();

	if( ent:GetClass() == "acf_gearbox" or ent:GetClass() == "acf_gearboxcvt" or ent:GetClass() == "acf_gearboxauto" ) then
		local ArgsTable = {};
		-- zero out the un-needed tool trace information
		ArgsTable[1] = pl;
		ArgsTable[2] = 0;
		ArgsTable[3] = 0;
		ArgsTable[4] = ent.Id;
		-- build gear data
		ArgsTable[5] = ent.GearTable[1];
		ArgsTable[6] = ent.GearTable[2];
		ArgsTable[7] = ent.GearTable[3];
		ArgsTable[8] = ent.GearTable[4];
		ArgsTable[9] = ent.GearTable[5];
		ArgsTable[10] = ent.GearTable[6];
		ArgsTable[11] = ent.GearTable[7];
		ArgsTable[12] = ent.GearTable[8];
		ArgsTable[13] = ent.GearTable[9];
		ArgsTable[14] = ent.GearTable.Final;

		self.GearboxCopyData = ArgsTable;

		ACFCUSTOM_SendNotify( pl, true, "Gearbox copied successfully!" );
	end
	
	if( ent:GetClass() == "acf_chips" ) then
		local ArgsTable = {};
		-- zero out the un-needed tool trace information
		ArgsTable[1] = pl;
		ArgsTable[2] = 0;
		ArgsTable[3] = 0;
		ArgsTable[4] = ent.Id;
		-- build gear data
		ArgsTable[5] = ent.ModTable[1];
		ArgsTable[6] = ent.ModTable[2];
		ArgsTable[7] = ent.ModTable[3];

		self.ChipsData = ArgsTable;

		ACFCUSTOM_SendNotify( pl, true, "Chips copied successfully!" );
	end
	
	if( ent:GetClass() == "acf_enginemaker" ) then
		local ArgsTable = {};
		-- zero out the un-needed tool trace information
		ArgsTable[1] = pl;
		ArgsTable[2] = 0;
		ArgsTable[3] = 0;
		ArgsTable[4] = ent.Id;
		-- build gear data
		ArgsTable[5] = ent.ModTable[1];
		ArgsTable[6] = ent.ModTable[2];
		ArgsTable[7] = ent.ModTable[3];
		ArgsTable[8] = ent.ModTable[4];
		ArgsTable[9] = ent.ModTable[5];
		ArgsTable[10] = ent.ModTable[6];
		ArgsTable[11] = ent.ModTable[7];
		ArgsTable[12] = ent.ModTable[8];
		ArgsTable[13] = ent.ModTable[9];
		ArgsTable[14] = ent.ModTable[10];
		ArgsTable[15] = ent.ModTable[11];
		ArgsTable[16] = ent.ModTable[12];
		ArgsTable[17] = ent.ModTable[13];
		ArgsTable[18] = ent.ModTable[14];
		ArgsTable[19] = ent.ModTable[15];

		self.EngineMakerCopyData = ArgsTable;

		ACFCUSTOM_SendNotify( pl, true, "Engine Maker copied successfully!" );
	end

	return true;
end
