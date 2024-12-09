getControls()

if (place_meeting(x, y, oPlayer) && interactKey) {
	if (image_index == 0) {
		image_index = 1
	}

	if instance_exists(oDoor) {
		with (oDoor) {
			if (self.doorId == other.doorId) {
				switchTriggered = true
			}
		}
	}
}