// it would be very funny if i turned the defective butter stick into an easter egg with low friction too :)

xSpeed = dir * platformSpeed
if place_meeting(x + xSpeed, y, [oWall, oSemiSolidWall]) {
	dir *= -1
	xSpeed = 0
}

x += xSpeed