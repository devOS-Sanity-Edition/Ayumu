/// @description Insert description here
// You can write your code in this editor

if (switchTriggered == true) {
	if (initialY - sprite_height) {
		if (place_meeting(x, y - moveAmount, oWall)) {
			moveAmount = 0
		}
		
		self.y -= moveAmount
	}
}/*/ else if switchTriggered == false {
	if (initialY + sprite_height) {
		if (place_meeting(x, y + moveAmount, oWall)) {
			moveAmount = 0
		}
		
		self.y += moveAmount
	}
}/*/ // this wont work and it was dumb for me to think it would, but i would like for it to go back from a toggleable door