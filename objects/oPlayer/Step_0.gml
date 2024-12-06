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
		
		// Set xSpeed to zero to `collide`
		xSpeed = 0
	}
}
// Go down slopes
downSlopeSemiSolid = noone // [duct tape solution]
if ySpeed >= 0 && !place_meeting(x + xSpeed, y + 1, oWall) && place_meeting(x + xSpeed, y + abs(xSpeed) + 1, oWall) {
	// Check for a semisolid in the way [duct tape solution]
	downSlopeSemiSolid = checkForSemiSolidPlatform(x + xSpeed, y + abs(xSpeed) + 1)
	
	// Precisely move down the slipe if there isn't a semi-solid in the way
	if !instance_exists(downSlopeSemiSolid) {
		while !place_meeting(x + xSpeed, y + _subPixel, oWall) {
			y += _subPixel
		}
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
		jumpCount = 0
	}
}

// Initiate Jump
var _floorIsSolid = false
if instance_exists(floorPlatform) && (floorPlatform.object_index == oWall || object_is_ancestor(floorPlatform.object_index, oWall)) {
	_floorIsSolid = true
}
if jumpKeyBuffered && jumpCount < jumpMax && (!downKey || _floorIsSolid) {
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
//if ySpeed > 0 { // do not make this an `ySpeed >= 0` because you'll end up floating weirdly, thank you Acer for helping me fix this
//	if place_meeting(x, y + ySpeed, oWall) {
//		// Scoot up to the wall precisely
//		var _pixelCheck = _subPixel * sign(ySpeed)
//
//		while !place_meeting(x, y + _pixelCheck, oWall) {
//			y += _pixelCheck
//		}
//	
//		// Roof Bonking [ might remove bc it is kinda funny ]
//		// hello aubrey 5 minutes after that was made, lets make this a bool instead lmao
//		if (roofBonkingFix == true) {
//			if ySpeed < 0 {
//				jumpHoldTimer = 0
//			}
//		}
//		
//		// Set ySpeed to 0 to collide
//		ySpeed = 0
//	}
//	
//	// Set if on ground
//	if ySpeed == 0 {
//		setOnGround(true)
//	}	
//}

// Floor Y Collision
// Check for solid and semisolid platforms under player
var _clampYSpeed = max(0, ySpeed)
var _list = ds_list_create() // Create a DS list to store all of the objects the player is running into
var _array = array_create(0)
array_push(_array, oWall, oSemiSolidWall)

// Do the actual check and add objects to list
var _listSize = instance_place_list(x, y + 1 + _clampYSpeed + movePlatformYSpeed, _array, _list, false)

// For higher-res art / high speed project fixes - Check for a semi-solid platform below player
var _yCheck = y + 1 + _clampYSpeed
if instance_exists(floorPlatform) {
	_yCheck += max(0, floorPlatform.ySpeed)
}
var _semiSolid = checkForSemiSolidPlatform(x, _yCheck)

// Loop through the colliding instances and only return one if it's top is below the player
for (var i = 0; i < _listSize; i++) {
	// Get an instance of oWall or oSemiSolidWall from the list
	var _listInst = _list[| i]
	
	// Avoid magnetism
	if (_listInst != forgetSemiSolid
	&& (_listInst.ySpeed <= ySpeed || instance_exists(floorPlatform)) 
	&& (_listInst.ySpeed > 0 || place_meeting(x, y + 1 + _clampYSpeed, _listInst)))
	|| (_listInst == _semiSolid) {
		// Return a solid wall of any semisolid walls that are below the player
		if _listInst .object_index == oWall 
		|| object_is_ancestor(_listInst.object_index, oWall) 
		|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed) {
			// Return the `highest` wall object
			if !instance_exists(floorPlatform) 
			|| _listInst.bbox_top + _listInst.ySpeed <= floorPlatform.bbox_top + floorPlatform.ySpeed 
			|| _listInst.bbox_top + _listInst.ySpeed <= bbox_bottom {
				floorPlatform = _listInst
			}
		}
	}
}

// Destroy the DS List to avoid a memory leak
ds_list_destroy(_list)

// Downslope semi-solid for making sure we don't miss semi-solids while going down slipes
if instance_exists(downSlopeSemiSolid) {
	floorPlatform = downSlopeSemiSolid
}

// One last check to make sure the floor platform is actually below us
if instance_exists(floorPlatform) && !place_meeting(x, y + movePlatformYSpeed, floorPlatform) {
	floorPlatform = noone
}

// Land on the ground platform if there is one
if instance_exists(floorPlatform) {
	// Scoot up to wall precisely
	var _subPixel = .5
	while !place_meeting(x, y + _subPixel, floorPlatform) && !place_meeting(x, y, oWall) {
		y += _subPixel
	}
	
	// Make sure we don't end up below the top of a semisolid
	if floorPlatform.object_index == oSemiSolidWall || object_is_ancestor(floorPlatform.object_index, oSemiSolidWall) {
		while place_meeting(x, y, floorPlatform) {
			y -= _subPixel
		}
	}
	
	// [do not] Floor the Y variable [because you will get a tiny jump when crossing slopes past the original block]
	y = y
	
	// Collide with the ground
	ySpeed = 0
	setOnGround(true)
}

// Manually fall through a semi-solid platform
if downKey && jumpKey {
	// Make sure we have a floor platform that's a semi-solid
	if instance_exists(floorPlatform) && (floorPlatform.object_index == oSemiSolidWall || object_is_ancestor(floorPlatform.object_index, oSemiSolidWall)) {
		// Check if we can go below the semi-solid
		var _yCheck = max(1, floorPlatform.ySpeed + 1)
		if !place_meeting(x, y + _yCheck, oWall) {
			// Move below the platform
			y += 1
			
			// Inherit any downward speed from floor platform so it doesn't catch the player
			ySpeed = _yCheck - 1
			
			// Forget this platform for a brief time so we don't get caught again
			forgetSemiSolid = floorPlatform
			
			// Jumping minifix
			jumpKeyBuffered = false
			
			// No more floor platform
			setOnGround(false)
		}
	}
}

// Move
y += ySpeed

// Reset forgetSemiSolid var
if instance_exists(forgetSemiSolid) && !place_meeting(x, y, forgetSemiSolid) {
	forgetSemiSolid = noone
}

// Final moving platform collisions and movement
// X - movePlatformXSpeed and collision
// Get the movePlatformXSpeed
movePlatformXSpeed = 0
if instance_exists(floorPlatform) {
	movePlatformXSpeed = floorPlatform.xSpeed
}

// Move with movePlatformXSpeed
if place_meeting(x + movePlatformXSpeed, y, oWall) {
	// Scoot up to wall precisely
	var _subPixel = .5
	var _pixelCheck = _subPixel * sign(movePlatformXSpeed)
	while !place_meeting(x + _pixelCheck, y, oWall) {
		x += _pixelCheck
	}
	
	// Set movePlatforXSpeed to 0 to finish collision
	movePlatformXSpeed = 0
}

// Move
x += movePlatformXSpeed

// Y - Snap player to the floorPlatform
if instance_exists(floorPlatform) && (floorPlatform.ySpeed != 0
	|| floorPlatform.object_index == oMovePlatform
	|| object_is_ancestor(floorPlatform.object_index, oMovePlatform)
	|| floorPlatform.object_index == oSemiSolidMovePlatform
	|| object_is_ancestor(floorPlatform.object_index, oSemiSolidMovePlatform)) {
	// Snap to the top of the floor platform (unfloor our Y variable so it's not choppy)
	if !place_meeting(x, floorPlatform.bbox_top, oWall) && floorPlatform.bbox_top >= bbox_bottom - movePlatformYSpeed {
		y = floorPlatform.bbox_top
	}
	
	// Going up into a solid wall while on a semi-solid platform
	if floorPlatform.ySpeed < 0 && place_meeting(x, y + floorPlatform.ySpeed, oWall) {
		// Get pushed down through the semi-solid floor platform
		if floorPlatform.object_index == oSemiSolidWall || object_is_ancestor(floorPlatform.object_index, oSemiSolidWall) {
			// Get pushed down through the semi-solid
			var _subPixel = .25
			while place_meeting(x, y + floorPlatform.ySpeed, oWall) {
				y += _subPixel
			}
			
			// If we get pushed into a solid wall while going downwards, push player back out
			while place_meeting(x, y, oWall) {
				y -= _subPixel
			}
			
			y = round(y)
			
			// Cancel the floor platform variable
			setOnGround(false)
		}
	}
}


/// Sprite Control
// Walking
if abs(xSpeed) > 0 {
	switch (face) {
		case 1:
			sprite_index = walkRunSprRight
			sprite_set_speed(sprite_index, 10, spritespeed_framespersecond)
			break
		case -1:
			sprite_index = walkRunSprLeft
			sprite_set_speed(sprite_index, 10, spritespeed_framespersecond)
			break
		default:
			break
			
	}
}
// Running
if abs(xSpeed) >= moveSpeed[1] {
	switch (face) {
		case 1:
			sprite_index = walkRunSprRight
			sprite_set_speed(sprite_index, 45, spritespeed_framespersecond)
			break
		case -1:
			sprite_index = walkRunSprLeft
			sprite_set_speed(sprite_index, 45, spritespeed_framespersecond)
			break
		default:
			break
			
	}
}
// Not moving
if xSpeed == 0 {
	switch (face) {
		case 1:
			sprite_index = idleBobSprRight
			sprite_set_speed(sprite_index, 15, spritespeed_framespersecond)
			break
		case -1:
			sprite_index = idleBobSprLeft
			sprite_set_speed(sprite_index, 15, spritespeed_framespersecond)
			break
		default:
			break;
	}
}
// Jumping/in the air
if !onGround {
	switch (face) {
		case 1:
			sprite_index = jumpSprRight
			sprite_set_speed(sprite_index, 15, spritespeed_framespersecond)
			break
		case -1:
			sprite_index = jumpSprLeft
			sprite_set_speed(sprite_index, 15, spritespeed_framespersecond)
			break
		default:
			break		
	}
}

// set collision mask
mask_index = maskSpr
image_xscale = sign(face)