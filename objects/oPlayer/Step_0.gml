// Get inputs

getControls()

// Have camera object follow player
oCamera.x = x
oCamera.y = y 

collider.avoidMovePlatforms()

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

collider.collideX()


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
	audio_play_sound(jumpSound, 5, false, sfxVolume)
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

// Y Collision
collider.collideUp()
collider.collideDown()

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
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Left
			if !place_meeting(x - i, y, oWall) {
				// x -= i
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Up
			if !place_meeting(x, y - 1, oWall) {
				// y -= 1
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Down
			if !place_meeting(x, y + i, oWall) {
				// y += 1
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Top Right
			if !place_meeting(x + i, y - i, oWall) {
				//x += i
				//y -= i
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Top Left
			if !place_meeting(x - i, y - i, oWall) {
				//x -= 1
				//y -= 1
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Bottom Right
			if !place_meeting(x + i, y + i, oWall) {
				//x += i
				//y += i
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		
			// Bottom Left
			if !place_meeting(x - i, y + i, oWall) {
				//x -= 1
				//y += 1
				audio_play_sound(hurtSound, 5, false, sfxVolume)
				x += global.checkpointX
				y += global.checkpointY
				break
			}
		}
}

if (place_meeting(x, y, oSpikes)) {
	x += global.checkpointX
	y += global.checkpointY
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