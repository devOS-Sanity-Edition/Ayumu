getControls()

if (place_meeting(x, y, oPlayer) && interactKey) {
	if (image_index == 0) {
		image_index = 1
	} else if (image_index  == 1) {
		image_index = 0
	}

	if instance_exists(oDoor) {
		with (oDoor) {
			if (self.doorId == other.doorId) {
				switchTriggered = !switchTriggered
				leverSwitched = !switchTriggered
			}
		}
	}
}