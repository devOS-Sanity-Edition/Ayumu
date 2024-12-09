/// @description Insert description here
// You can write your code in this editor

if (switchTriggered == true) {
	if (initialY - sprite_height) {
		if (place_meeting(x, y - moveAmount, oWall)) {
			moveAmount = 0
		}
		
		self.y -= moveAmount
	}
}

