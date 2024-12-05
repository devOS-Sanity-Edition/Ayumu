// Get inputs

getControls()

/// X movement
// Direction
moveDir = rightKey - leftKey

// Get face
if moveDir != 0 {
	face = moveDir
}

// Get X speed
runType = runKey
// if runOnlyLevel { runType = 1 }
xSpeed = moveDir * moveSpeed[runType]

// X collision
var _subPixel = .5
if place_meeting(x + xSpeed, y, oWall) {
	// First check if there is a slope to go up
	if !place_meeting(x + xSpeed, y - abs(xSpeed) - 1, oWall) {
		while place_meeting(x + xSpeed, y, oWall) {
			y -= _subPixel
		}
	} else { // Check for ceiling slope next, and if there isn't a slope, use normal collision
		// Ceiling slopes
		if !place_meeting(x + xSpeed, y + abs(xSpeed * 1.5) + 1, oWall) {
			while place_meeting(x + xSpeed, y, oWall) {
				y += _subPixel
			}
		} else { // Normal collision
			// Scoot up to wall precisely
			var _pixelCheck = _subPixel * sign(xSpeed)
			while !place_meeting(x + _pixelCheck, y, oWall) {
				x += _pixelCheck
			}
		}
		
		
	}
	
	// Set xSpeed to zero to `collide`
	xSpeed = 0
}
// Go down slopes
if ySpeed >= 0 && !place_meeting(x + xSpeed, y + 1, oWall) && place_meeting(x + xSpeed, y + abs(xSpeed) + 1, oWall) {
	while !place_meeting(x + xSpeed, y + _subPixel, oWall) {
		y += _subPixel
	}
}

// Move
x += xSpeed

/// Y Movement
// Gravity
if coyoteHangTimer > 0 {
	// Count down the timer
	coyoteHangTimer-- 
} else {
	// Apply gravity to player
	ySpeed += grav
	// No longer on ground
	setOnGround(false)
}

// Reset/Prep jumping variables
if onGround {
	jumpCount = 0
	jumpHoldTimer = 0
	coyoteJumpTimer = coyoteJumpFrames
} else {
	// if player is in the air, make sure they can't do an extra jump
	coyoteJumpTimer--
	if jumpCount == 0 && coyoteJumpTimer <= 0 {
		jumpCount = 1
	}
}

// Initiate Jump
if jumpKeyBuffered && jumpCount < jumpMax {
	// Reset the buffer
	jumpKeyBuffered = false
	jumpKeyBufferTimer = 0
	
	// Increate the number of performed jumps
	jumpCount++
	
	// Set the jump hold timer
	jumpHoldTimer = jumpHoldFrames[jumpCount = 1] // turns out it has to be equals 1 or else double jump doesnt work proper
	// Tell outself we're no longer on the ground
	setOnGround(false)
}

// Cut off the jump by releasing the jump button
if !jumpKey {
	jumpHoldTimer = 0
}

// Jump based on the timer/holding the button
if jumpHoldTimer > 0 {
	// Constantly set the ySpeed to be jumping pseed
	ySpeed = jumpSpeed[jumpCount - 1]
	
	// Count down the timer
	jumpHoldTimer--
}

// Hello terminal velocity [capping fall speed]
if ySpeed > termVel {
	ySpeed = termVel
}

// Upwards Y collision w/ ceiling slopes
if ySpeed < 0 && place_meeting(x, y + ySpeed, oWall) {
	// Jump into sloped ceilings
	var _slopeSlide = false
	
	// Slide up left
	if moveDir == 0 && !place_meeting(x - abs(ySpeed) - 1, y + ySpeed, oWall) {
		while place_meeting(x, y + ySpeed, oWall) {
			x -= 1
		}
		_slopeSlide = true
	}
	
	// Slide up right
	if moveDir == 0 && !place_meeting(x - abs(ySpeed) + 1, y + ySpeed, oWall) {
		while place_meeting(x, y + ySpeed, oWall) {
			x += 1
		}
		_slopeSlide = true
	}
	
	if !_slopeSlide {
		// Scoot up to the wall precisely
		var _pixelCheck = _subPixel * sign(ySpeed)
		while !place_meeting(x, y + _pixelCheck, oWall) {
			y += _pixelCheck
		}
	
		// Roof Bonking [ might remove bc it is kinda funny ]
		// hello aubrey 5 minutes after that was made, lets make this a bool instead lmao
		if (roofBonkingFix == true) {
			if ySpeed < 0 {
				jumpHoldTimer = 0
			}
		}
		
		// Set ySpeed to 0 to collide
		ySpeed = 0
	}
}

// Downwards Y collision
var _subPixel = .5
if ySpeed > 0 { // do not make this an `ySpeed >= 0` because you'll end up floating weirdly, thank you Acer for helping me fix this
	if place_meeting(x, y + ySpeed, oWall) {
		// Scoot up to the wall precisely
		var _pixelCheck = _subPixel * sign(ySpeed)

		while !place_meeting(x, y + _pixelCheck, oWall) {
			y += _pixelCheck
		}
	
		// Roof Bonking [ might remove bc it is kinda funny ]
		// hello aubrey 5 minutes after that was made, lets make this a bool instead lmao
		if (roofBonkingFix == true) {
			if ySpeed < 0 {
				jumpHoldTimer = 0
			}
		}
		
		// Set ySpeed to 0 to collide
		ySpeed = 0
	}
	
	// Set if on ground
	if ySpeed == 0 {
		setOnGround(true)
	}	
}

// Move
y += ySpeed


/// Sprite Control
// Walking
if abs(xSpeed) > 0 {
	if (sprite_index == walkRunSpr) {
		sprite_index = turnSpr
		if (image_index >= 6) {
			sprite_index = walkRunSpr
			image_index = 0
			sprite_set_speed(sprite_index, 10, spritespeed_framespersecond)
		}
	}
}
// Running
if abs(xSpeed) >= moveSpeed[1] {
	if (sprite_index == walkRunSpr) {
		sprite_index = turnSpr
		if (image_index >= 6) {
			sprite_index = walkRunSpr
			image_index = 0
			sprite_set_speed(sprite_index, 15, spritespeed_framespersecond)
		}
	}	
}
// Not moving
if xSpeed == 0 {
	sprite_index = idleSpr
	sprite_set_speed(sprite_index, 5, spritespeed_framespersecond)
}
// Jumping/in the air
if !onGround {
	sprite_index = jumpSpr
	sprite_set_speed(sprite_index, 10, spritespeed_framespersecond)
}

// set collision mask
mask_index = maskSpr