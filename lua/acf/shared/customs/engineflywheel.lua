ACF_DefineFly( "Fly-Small", {
	name = "Prop Engine Reader",
	desc = "Prop Engine Reader is used to Read Props Engines values, and send it to an acf gearbox. This can be also related to a Engine 'flywheel/sandwhich plate'.\n\nSet your IdleRPM, And the most possible Flywheelmass.\n\nIf you have too many 'Back Force' increase the flywheelmass, otherwise decrease it\n\nBackForce is the amount of Force/RPM you should remove/add in the next frame in your E2",
	model = "models/sprops/rectangles/size_1_5/rect_6x6x3.mdl",
	category = "Props Engines",
	weight = 1,
	modtable = {
		[ 1 ] = 800,
		[ 2 ] = 0.05
	}
} )