function setOnGround(_val = true) {
	if _val == true {
		onGround = true
		coyoteHangTimer = coyoteHangFrames
	} else {
		onGround = false
		coyoteHangTimer = 0
	}
}

// Controls setup
controlsSetup()

// Moving
face = 1
moveDir = 0
runType = 0
moveSpeed[0] = 2.5
moveSpeed[1] = 4
xSpeed = 0
ySpeed = 0

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

// Sprites
maskSpr = sPlayerIdleBlink
idleBobSprRight = sPlayerIdleBobRight
idleBobSprLeft = sPlayerIdleBobLeft
walkRunSprRight = sPlayerWalkRunRight
walkRunSprLeft = sPlayerWalkRunLeft
jumpSprRight = sPlayerJumpRight
jumpSprLeft = sPlayerJumpLeft
turnSpr = sPlayerTurn

// Other
roofBonkingFix = true
wallAreYouDoing = [oWall, oInvisWall]

// Shader Color Swap
color_old1 = shader_get_uniform(shdrSlimeColor, "color_old1")
color_new1 = shader_get_uniform(shdrSlimeColor, "color_new1")
color_old2 = shader_get_uniform(shdrSlimeColor, "color_old2")
color_new2 = shader_get_uniform(shdrSlimeColor, "color_new2")