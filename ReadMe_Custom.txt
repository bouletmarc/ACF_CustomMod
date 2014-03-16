
#######################
HOW TO USE :
#######################

On Engines:
	
	-All engines get new wire Inputs on it like:
		-TqAdd		--> Adds Torque with value "X"
		-MaxRpmAdd	--> Adds Peak Maximum RPM with value "X"
		-LimitRpmAdd	--> Adds Limit Rpm with value "X"
		-FlywheelMass	--> Set flywheel mass with value "X"  ---> Example: 0.02 = 20Kg
		-Idle		--> Set engine Idle RPM with value "X"
		-DisableCut	--> Set to 1 to disable the Engine CutOff

		(The X means the value you wire it to, for example if you wire a value of 20 to TqAdd, it will add 20 Torque...)



On Chips :
	-This chip has a customizable menu where you can modify these 3 values:
		-Torque
		-Peak maximum rpm
		-Limit rpm
	-Link the Engine to the chips
	-The Chips also offer a Vtec system, where it will add the power like a Vtec.

On CVT :
	-All CVT Gearboxes work like a automatic 1 speed system, same as a Snowmobile gearbox...
	-This gives you high RPM and Torque at low speeds and high speeds.
	-In the menu you get some customizable settings:
		-Gear1 		--> The ratio of the 1st gear.
		-Gear2		--> The ratio of the 2nd gear (used for reverse, so negative).
		-Rpm Maximum	--> When the engine reaches this RPM, the gearbox will accelerate.
		-Rpm Minimum	--> When the engine is below this RPM, the gearbox will de-accelerate.
		-Ratio Minimum	--> The Final drive minimum (The Gearbox's lowest possible final drive).
		-Ratio Maximum	--> The Final drive maximum (The Gearbox will stop accelerating when it reaches this final drive).

On Nos Bottle :
	-Wire ActiveNos to a button to activate the Nos
	-Link the Engine to the Nos Bottle
	-Take note : Nos Bottle has a reloading time, and the time varies with the amount of torque set, if you add more Torque, it will take more time.
