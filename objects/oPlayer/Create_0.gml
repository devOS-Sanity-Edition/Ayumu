function setOnGround(_val = true) {
	if _val == true {
		onGround = true
		coyoteHangTimer = coyoteHangFrames
	} else {
		onGround = false
		floorPlatform = noone
		coyoteHangTimer = 0
	}
}

function checkForSemiSolidPlatform(_x, _y) {
	// Create a return variable
	var _rtrn = noone
	
	// Must not be moving upwards, and then check for normal collision
	if ySpeed >= 0 && place_meeting(_x, _y, oSemiSolidWall) {
		// Create a DS List [Data Structure List] to store all colliding instances of oSemiSolidWall
		var _list = ds_list_create()
		var _listSize = instance_place_list(_x, _y, oSemiSolidWall, _list, false)
		
		// Loop through the colliding instances and only return one of its top is below the player
		for (var i = 0; i < _listSize; i++) {
			var _listInst = _list[| i]
			if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed) {
				// Return the ID of a semi-solid platform
				_rtrn = _listInst
				
				// Exit the loop early
				i = _listSize
			}
		}
		
		// Destroy DS List so you don't end up with a fucking memory leak
		ds_list_destroy(_list)
	}
	
	// Return out var
	return _rtrn
}

depth = layer_get_depth("Player")

// Controls setup
controlsSetup()

// Moving
face = 1
moveDir = 0
crouchSpeed = 0.75
runType = 0
moveSpeed[0] = 2.5 // walking
moveSpeed[1] = 4 // sprinting
xSpeed = 0
ySpeed = 0
crouchTimer = 15

// State variables
crouching = false

// Jumping
grav = 0.275
termVel = 4
jumpMax = 2
jumpCount = 0
jumpHoldTimer = 0
jumpSpeed[0] = -3
jumpSpeed[1] = -2.5
jumpHoldFrames[0] = 16
jumpHoldFrames[1] = 8
onGround = true

// Coyote time
// Hang time
coyoteHangFrames = 4
coyoteHangTimer = 0

// Jump buffer
coyoteJumpTimer = 8
coyoteJumpFrames = 0

// Moving platforms
floorPlatform = noone
earlyMovePlatformXSpeed = false
downSlopeSemiSolid = noone
forgetSemiSolid = noone
movePlatformXSpeed = 0
movePlatformYSpeed = termVel // this can be a different value for a player falling w/ a downwards moving platform, but lets keep it to terminal velocity


// Sprites
maskSpr = sPlayerIdleBlink
crouchMaskSpr = sPlayerDuckDownRight
idleBobSprRight = sPlayerIdleBobRight
idleBobSprLeft = sPlayerIdleBobLeft
walkRunSprRight = sPlayerWalkRunRight
walkRunSprLeft = sPlayerWalkRunLeft
jumpSprRight = sPlayerJumpRight
jumpSprLeft = sPlayerJumpLeft
turnSpr = sPlayerTurn
crouchSprUpLeft = sPlayerDuckUpLeft
crouchSprUpRight = sPlayerDuckUpRight
crouchSprDownLeft = sPlayerDuckDownLeft
crouchSprDownRight = sPlayerDuckDownRight
currentSpriteName = sprite_get_name(oPlayer.sprite_index[0])
currentSpriteSpeed = sprite_get_speed(oPlayer.sprite_index[0])
currentMaskIndex = sprite_get_name(oPlayer.mask_index[0])

// Other
roofBonkingFix = true
wallAreYouDoing = [oWall, oInvisWall]

// Shader Color Swap
dualColorSwapSetup()

instance_create_layer(x, y, "Light", oPlayerLight)