// Get inputs

getControls()

#region
// Get out of solid movePlatforms that have positioned themselves into the player in the begin step
var _rightWall = noone
var _leftWall = noone
var _bottomWall = noone
var _topWall = noone
var _list = ds_list_create()
var _listSize  = instance_place_list(x, y, oMovePlatform, _list, false)

// Loop through all colliding move platforms
for (var i = 0; i < _listSize; i++) {
	var _listInst = _list[| i]
	
	// If there are walls to the right of me, get the closest one
	// Right walls
	if _listInst.bbox_left - _listInst.xSpeed >= bbox_right - 1 {
		if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left {
			_rightWall = _listInst
		}
	}
	// Left walls
	if _listInst.bbox_right - _listInst.xSpeed <= bbox_left - 1 {
		if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right{
			_leftWall = _listInst
		}
	}
	
	// Bottom walls
	if _listInst.bbox_top - _listInst.ySpeed >= bbox_bottom - 1 {
		if !_bottomWall || _listInst.bbox_top < _bottomWall.bbox_top {
			_bottomWall = _listInst
		}
	}
	
	// Top walls
	if _listInst.bbox_bottom - _listInst.ySpeed <= bbox_top + 1 {
		if !_topWall || _listInst.bbox_bottom > _topWall.bbox_bottom {
			_topWall = _listInst
		}
	}
}

// Destroy DS List, memory leak not happening
ds_list_destroy(_list)

// Get out of the walls
// Right wall
if instance_exists(_rightWall) {
	var _rightDistance = bbox_right - x
	x = _rightWall.bbox_left - _rightDistance
}
// Left wall
if instance_exists(_leftWall) {
	var _leftDistance = x - bbox_left
	x = _leftWall.bbox_right + _leftDistance
}
// Bottom wall
if instance_exists(_bottomWall) {
	var _bottomDistance = bbox_bottom - y
	y = _bottomWall.bbox_top - _bottomDistance
}
// Top wall [includes collision for polish and crouching features]
if instance_exists(_topWall) {
	var _upDistance = y - bbox_top
	var _targetY = _topWall.bbox_bottom + _upDistance
	
	// Check if there isn't a wall in the way
	if !place_meeting(x, _targetY, oWall) {
		y = _targetY
	}
}
#endregion

// Don't get left behind by movePlatform
earlyMovePlatformXSpeed = false
if instance_exists(floorPlatform) && floorPlatform.xSpeed != 0 && !place_meeting(x, y + movePlatformYSpeed + 1, floorPlatform) {
	var _xCheck = floorPlatform.xSpeed
	// Go ahead and move player back onto that platform if there is no wall in the way
	if !place_meeting(x + _xCheck, y, oWall) {
		x += _xCheck
		earlyMovePlatformXSpeed = true
	}
}

// Crouching
// Transition to crouch
// Manual
if onGround && (downKey || place_meeting(x, y, oWall)) {
	crouching = true
	crouchTimer++
}

// Change collision mask
if crouching {
	mask_index = crouchMaskSpr
}

// Transition out of crouching
// Manual = !downKey | Automatic = !onGround
if crouching && (!downKey || !onGround) {
	// Check if i can uncrouch
	mask_index = maskSpr
	// Uncrouch if no solid wall in the way
	if !place_meeting(x, y, oWall) {
		crouching = false
	} else { // Go back to crouching mask index if we can't uncrouch
		mask_index = crouchMaskSpr
	}
}

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

// Little movement while crouching
if crouching {
	xSpeed = moveDir * crouchSpeed
}

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
	jumpHoldTimer = jumpHoldFrames[jumpCount = 2] // this is going to haunt me later with trying to fix coyote jump, if it is even fixed already
	// Tell outself we're no longer on the ground
	setOnGround(false)
}

// Cut off the jump by releasing the jump button
if !jumpKey {
	jumpHoldTimer = 0
}

// Jump based on the timer/holding the button
if jumpHoldTimer > 0 {
	// Constantly set the ySpeed to be jumping speed
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

// Move [and added anti-stuck for the very very rare occasion]
if !place_meeting(x, y + ySpeed, oWall) {
	y += ySpeed
}

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

if !earlyMovePlatformXSpeed {
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
}

// Y - Snap player to the floorPlatform if it's moving vertically
if instance_exists(floorPlatform) && (floorPlatform.ySpeed != 0
	|| floorPlatform.object_index == oMovePlatform
	|| object_is_ancestor(floorPlatform.object_index, oMovePlatform)
	|| floorPlatform.object_index == oSemiSolidMovePlatform
	|| object_is_ancestor(floorPlatform.object_index, oSemiSolidMovePlatform)) {
	// Snap to the top of the floor platform (unfloor our Y variable so it's not choppy)
	if !place_meeting(x, floorPlatform.bbox_top, oWall) && floorPlatform.bbox_top >= bbox_bottom - movePlatformYSpeed {
		y = floorPlatform.bbox_top
	}
	
	// Made redundant by code below this chunk
	/*/ Going up into a solid wall while on a semi-solid platform
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
	}/*/
}

// Get pushed down through a semi-solid by a moving solid platform
if instance_exists(floorPlatform)
&& (floorPlatform.object_index == oSemiSolidWall || object_is_ancestor(floorPlatform.object_index, oSemiSolidWall))
&& place_meeting(x, y, oWall) {
	// If player is already stuck in a wall at this point, try to move player down to get below a semi-solid
	// If player is still stuck afterwards, player has been properly crushed
	
	// Also don't check too far, don't want to warp below walls
	var _maxPushDistance = 10
	var _pushedDistance = 0
	var _startY = y
	
	while place_meeting(x, y, oWall) && _pushedDistance <= _maxPushDistance {
		y++
		_pushedDistance++
	}
	
	// Forget floorPlatform
	setOnGround(false)
	
	// If still in a wall at this point, player has been crushed regardless, take back to start Y
	if _pushedDistance > _maxPushDistance {
		y = _startY
	}
}

// Brute force Anti-stuck, use as death in the future maybe?
// Ideally if you're shoved into a wall, I'd rather you get teleported back to spawn instead of just teleported a bit, idk, that's just me tho
// https://www.youtube.com/watch?v=WPdMw8jt0aU
if place_meeting(x, y, [oWall, oMovePlatform]) {
	for (var i = 0; i < 1000; ++i) {
			// Right
			if !place_meeting(x + i, y, oWall) {
				// x += i
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Left
			if !place_meeting(x - i, y, oWall) {
				// x -= i
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Up
			if !place_meeting(x, y - 1, oWall) {
				// y -= 1
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Down
			if !place_meeting(x, y + i, oWall) {
				// y += 1
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Top Right
			if !place_meeting(x + i, y - i, oWall) {
				//x += i
				//y -= i
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Top Left
			if !place_meeting(x - i, y - i, oWall) {
				//x -= 1
				//y -= 1
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Bottom Right
			if !place_meeting(x + i, y + i, oWall) {
				//x += i
				//y += i
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		
			// Bottom Left
			if !place_meeting(x - i, y + i, oWall) {
				//x -= 1
				//y += 1
				x += oSpawnPoint.x
				y += oSpawnPoint.y
				break
			}
		}
	
}

/// Sprite and Particle Control
// Walking
if abs(xSpeed) > 0 {
	switch (face) {
		case 1:
			sprite_index = walkRunSprRight
			sprite_set_speed(sprite_index, 20, spritespeed_framespersecond)
//			part_particles_create(testDustParticle, x, y, )
			break
		case -1:
			sprite_index = walkRunSprLeft
			sprite_set_speed(sprite_index, 20, spritespeed_framespersecond)
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
			sprite_set_speed(sprite_index, 30, spritespeed_framespersecond)
			break
		case -1:
			sprite_index = jumpSprLeft
			sprite_set_speed(sprite_index, 30, spritespeed_framespersecond)
			break
		default:
			break		
	}
}


if crouching {
	switch (face) {
		case 1:
			sprite_index = crouchSprDownRight
			sprite_set_speed(sprite_index, 1, spritespeed_framespersecond)
			sprite_set_speed(sprite_index, 0, spritespeed_framespersecond)
			crouchTimer--
			if crouchTimer >= 0 {
				image_index = image_number - 1
				sprite_set_speed(sprite_index, 0, spritespeed_framespersecond)
			}
			break
		case -1:
			sprite_index = crouchSprDownLeft
			sprite_set_speed(sprite_index, 1, spritespeed_framespersecond)
			crouchTimer--
			if crouchTimer >= 0 {
				image_index = image_number - 1
				sprite_set_speed(sprite_index, 0, spritespeed_framespersecond)
			}
			break
		default:
			break;
	}
}

// set collision mask
mask_index = maskSpr
if crouching {
	mask_index = crouchMaskSpr
}
image_xscale = sign(face)
currentSpriteName = sprite_get_name(self.sprite_index[0])
currentSpriteSpeed = sprite_get_speed(self.sprite_index[0])