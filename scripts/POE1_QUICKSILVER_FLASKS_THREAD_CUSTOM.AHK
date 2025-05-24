#Include dependencies\includes\_INCLUDES_THREAD

global KeyDelayTimes := {}
global LastPressTime := {}
THREAD_WAIT(_TICK_UPDATE_WAIT*8)
LoadSettings()

; alternate between key 4 and 5 for quicksilver flask
DualFlask		:= true
FlaskCounter	:= 1
FlaskCooldown1	:= 6000
FlaskCooldown2	:= 6000

; _____MAIN LOOP
Loop {
	if ( (_POEMEMORY.ERROR == "NONE") AND (InTown() == false) AND (_POEMEMORY.CURHP > 0) ) {
		if ( CheckPoeWindow() == true ) {

			if ( GetKeyState("LButton", "P") ) {
				; wait for Left Click to be held down for 500ms
				KeyWait, LButton, T 0.5
				; if held down for 500ms -> trigger kreypress
				if ( ErrorLevel = 1 ) {
					;___ SINGLE FLASK
						if (DualFlask == false){
							PressKey("vk35", FlaskCooldown1)
						}
					;________________
					;___ DOUBLE FLASK
						if (DualFlask == true){
							if ( mod(FlaskCounter, 2) == 0 ) {
								PressKey("vk34", FlaskCooldown1)
							}
							else {
								PressKey("vk35", FlaskCooldown2)
							}
							FlaskCounter++
						}
					;________________
				}
			}

		}
	}
	THREAD_WAIT(_TICK_UPDATE_CRITICAL)
}