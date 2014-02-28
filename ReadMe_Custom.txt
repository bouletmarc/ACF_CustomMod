
#######################
HOW TO USE :
#######################

On Engines :
	
	-All engines get new wires "Inputs" on it like :
		-TqAdd		--> Adding Torque with value "X"
		-MaxRpmAdd	--> Adding Peak Maximum Rpm with value "X"
		-LimitRpmAdd	--> Adding Limit Rpm with value "X"
		-FlywheelMass	--> Set flywheel mass with value "X"  ---> Exemple: 0.02 = 20Kg
		-Idle		--> Set engine Idle RPM with value "X"
		-DisableCut	--> Set to 1 to Disable the Engine CutOff

		(Here the X mean the value you wire to it, exemple if you wire a value of 20 to TqAdd , he will add 20 Torque ...)

	-Somes engines can be customizable in the menu directly with a slider bar.



On Chips :
	-This chip get a customizable menu where you can modify 3 adding value :
		-Torque
		-Peak maximum rpm
		-Limit rpm
	-Wire "TqAdd","MaxRpmAdd" and "LimitRpmAdd" from the engine to this Chips
	-and this chips "ActiveChips" to a button or anything to active it.




On Vtec Chips :
	-This Vtec chip get a customizable menu where you can choose the Vtec Kick rpm ...
	-To use it you need to spawn the other "normal chips"
	-wire "RPM" to the engine then the normal chips "ActiveChips" to this vtec chip.
	-How its work :
		-When the engine will be more than the chosen rpm, the vtec chips will active the engine chips, 
		  and the engines chips will give more torque/rpm to engine.


On CVT :
	-All CVT Gearboxs work like a "automatic 1 speed" system, so the most common was a snowmobile forwarding system...
	-This give you High rpm and Torque at low speed and high speed.
	-in the menu you get some customizable things:
		-Gear1 		--> the ratio of the 1st gear
		-Gear2		--> the ratio of the 2nd gear (used for reverse, so negative)
		-Rpm Maximum	--> that mean, when the engine will reach this rpm, the gearbox will accelerate
		-Rpm Minimum	--> when the engine will be bellow this rpm, the gearbox will decelerate
		-Ratio Minimum	--> The Final drive minimum (when declutch, run slowly)
		-Ratio Maximum	--> The Final drive maximum(Gearbox stop accelerating when reach this final drive, to make realism top end)

On Nos Bottle :
	-Wire ActiveNos to a button to active the Nos
	-Wire "TqAdd, MaxRpmAdd, LimitRpmAdd" from the engine to the Nos Bottle
		        ** Special Wire Outputs on Nos Bottle **
		- "Active" its to know if the Nos are currently Activate
		- "Usable" its to know if the Nos are ready to use again
	-Take note : Nos Bottle get a Reloading time, and the time varie with the amount of torque, if you put more Torque, it will take more time.
