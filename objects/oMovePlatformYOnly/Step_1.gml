// it would be very funny if i turned the defective butter stick into an easter egg with low friction too :)

ySpeed = dir * platformSpeed
if place_meeting(x, y  + ySpeed, [oWall, oSemiSolidWall]) {
	dir *= -1
	ySpeed = 0
}

y += ySpeed