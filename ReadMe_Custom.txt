############################################################################################################################
############################################################################################################################
############################################################################################################################
#######													#######
#######													#######
#######                  #####################	        #################		     ############################	#######
#######	             ######################	   ######################		#############################	#######
#######	            #######################	#########################	               #############################	#######
#######	           #######	         #######	########		########	              #######				#######
#######	          #######	          #######	#######			              #######				#######
#######	         #######	           #######	#######			             #######				#######
#######	        ###########################	#######			             ################			#######
#######	       ############################	#######			            ###############			#######
#######	      #############################	#######			            ##############			#######
#######	     #######	              #######	#######			           #######				#######
#######	    #######	               #######	#######			           #######				#######   
#######	   #######		                #######	########		#########          #######				#######
#######	  #######		                 #######	##########################	          #######				#######
#######	 #######			#######	  ######################	         #######				#######
#######	#######			 #######	       #################	         #######				#######
#######													#######
#######													#######
############################################################################################################################
############################################################################################################################
############################################################################################################################



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

On Automatic Gearbox :
	-Wire Reverse to a button or something, and when you active the button you will be on reverse gear.
	-Choose the shift rpm and the decrease rpm

###################################
###################################
	VERSION 
###################################
###################################

--V6.5
--Engine Maker Menu 4.0
--Engine menu can now save settings and load's it

--V6.2
--Updated to Rev.274
--Added Custom Updated Checker
--Improved Engine Maker maker
--Engine Maker Menu 3.5
--Added some icons to the Menu Tree
--Fixed power bar in Engine Menu

--V6.1
--Updated to Rev.268 / 269
--Fixed issue with Engine Maker Menu

--V6.0
--Updated to Rev.263 / 264
	--Quick Updated to Rev.266 / 267
--All menu text Color are new blue ( More visible and more butiful )
--Almost all Menu Fonts are changed
--Fixed Throttle issue when Max Rpm are Higher than Limit Rpm
--Engine Maker Menu V3.3
--Easy To know Fail in Engine Maker
--Added Power Band into the menu of Engine Maker
--Engine Maker Menu Auto Update
--Engine Maker Should make less Error's
--Cutoff Sound now CUT and Restart
--Added wire output "DisableCut" to disable CutOff of the Engine

--V5.2 (Not Releashed)
--Added Cutoff Limiter
--Added Progressive Stopping Engine
--Fixed Duping Engine's from Engine Maker
--Put back Custom Engine's

--V5.1
--Fixed Engine Maker Weight Errors
--Added Supercharger to the E2 list

--V5.0
--Big Update
--Added Engine Maker support
--Added Engine Menu for the engine maker
--Increased some Limit value of slider ( engine and gearbox's )
--Fixed Engine maker Spawn and sound.
--Added Model menu for Engine Maker ( Can Choose Model Of Engine )
--Added Sound menu for Engine Maker ( Can Choose Sound Of Engine )
--Added Name menu for Engine Maker ( Can Choose Name Of Engine )
--Added Settings menu for Engine Maker ( Can Choose settings Of Engine "weight, torque, rpm's, etc..." )
--Added Demonstration's Picture's of the Model
--Engine Menu V3.2 

--V4.2
--Updated to Rev.260
--Fixed Automatic Gearbox HUD

--V4.1
--Added 1 new v12 Custom Engine

--V4.0
--Updated to rev.237
--Including Wankel engines
--Wankel can be customizable

--V3.8
--Added Automatic Gearbox (4speed and 6speed)

--V3.7
-fixed normal engines sound

--V3.6
-fixed torque adding on no-vtec engines
-removed vtec sound system ( i'm working on a better )
-fixed sound pitch
-Added my E2 Turbo and BOV to the download link
-releashed to public again


--V3.5 "BIG Update"
-Change All my mods into a new files/menu tabs due to 200 limits entities by Lua. (Now I get over 100 free space, so I can add a lots of more stuff)
-Created a "mobility2" list for my mods
-Created a customizable menu for littles engines
-Created a customizable menu for big engines
-Created Nos Bottle (can choose between 20-200 Torque, and More Torque take more time to reload the Bottle)
-Fixed Sound on Nos Bottle
-Fixed GUI on Nos Bottle
-Fixed All sliders menu band
-Better lua scripts
-A bit better VTEC sound
-Engines get news folders (ACF_Engines2,ACF_Engines3,ACF_Engines4)  for each types ( Custom, Customizable little, Customizable fat )
-Custom Engines menu are back and better than the old removed. This mean :
	--> All original engines stay with a normal Menu to fix the old dupes engines errors, now we can play with old dupes
	--> All customizable engines will appear in the "Customizable" folder and get the Custom menu. You can change theses mods by sliders :
		--> Torque
		--> Idle
		--> FlywheelMass
		--> Peak Minimum RPM
		--> Peak Maximum RPM
		--> Limit RPM

--V3.4
-Added Torque adding to VTEC system
-Fixed sound on engines that don't own a VTEC system
-Fixed GUI menu torque changing on VTEC
-Better Sound volume for VTEC
-Fixed Torque adding on NON-VTEC engines

--V3.3
-Better lua scripts
-Fixed 1200cc Harley Engine Spawn
-Added VTEC system (When VTEC reach, sound are louder) ---> (B16,H22,V8-LS,Single 500cc, I4 1.6L and 2.0L Racing, Cheap engine)

--V3.2
-Fixed CVT to work when all unfroozen
-Added 15 Custom's Engines

--V3.1
-Fixed Custom Engine to be in "Custom" menu
-Removed Engine Customizable Menu due to Old Dupe engine fail (working on better system)

--V3.0
-Updated for GM13 Acf Version (GitHub rev.199)
-Working CVT Without "RPM" wire inputs
         -Removed to Public (Testing)

--V2.2
-New Engines Menu , customizable with sliders
-New Chips Menu with sliders, now its only 1chip
-New Vtec Menu with sliders, now its only 1vtec chip
-Fixed Vtec chip Spawn error
-Added 1 custom engines (Inline4 2.2L similar as H22A sound)
-New CVT Menu , customizable with sliders
-Better CVT Lua, now can work without E2 (need to wire "rpm" to engine)
        -Releashed to Public

--V2.1
-Added Dual clutch CVT
-New Engines Textures
-New Gearboxs Textures
-Added 3 custom engines (Inline6 cummins diesel + V8 corvette + V8 cobra)

-V2.0
-Mod Updated for Revison 324 (last Gmod12 version)

-V1.4(old acf)
-Added 4 custom engines (Inline4 --> 2xRacing 1.6L and 2xRacing 2.0L)
-CVT Created, need a E2 to make it work (to change the finaldrive with rpm)
-Added 6 vtec chips

-V1.3
-Vtec chip Created ( 3 chips )
-Added 6 engines chips

-V1.2
-Fixed minors bugs on Engines chips

-V1.1
-Engines Chips Created ( 3 chips )
-Added wire "Inputs" on acf Engines ---> FlywheelMass, Idle

-V1.0 (start)
-Created new wire "Inputs" on acf Engines ---> TqAdd , MaxRpmAdd, LimitRpmAdd
