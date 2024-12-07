// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function WAIT_WHAT_IF_THIS_HURTS_WHAT_IF_IT_REALLY_HURTS_OH_I_DIDNT_THINK_ABOUT_THAT(_cheater = false) {
	switch (_cheater) {
		case true:
			show_debug_message("oh no")
			oGlobal.cheats = true
			break
		case false:
			if (oGlobal.cheats) {
				show_debug_message("Shutting off cheats")
				oGlobal.cheats = false
			} else {
				show_debug_message("...what?")
			}
	}
}

function setBackgroundSpeed(speed) {
	var previousSpeed = oParallax.backgroundSpeed
	switch (oGlobal.cheats) {
		case true:
			oParallax.backgroundSpeed = speed
			show_debug_message($"Parallax background speed has been set from {previousSpeed} to {speed}")
			break
		case false:
			show_debug_message("Cheats aren't enabled! You can't do that!")
			break
	}
}