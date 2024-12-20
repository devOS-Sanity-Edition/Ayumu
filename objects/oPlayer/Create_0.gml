function setOnGround(_val = true) {
	onGround = _val
	if _val == true {
		coyoteHangTimer = coyoteHangFrames
	} else {
		floorPlatform = noone
		coyoteHangTimer = 0
	}
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

// Sounds
hurtSound = sndHurt
jumpSound = sndJump
sfxVolume = global.sfxVolume * global.masterVolume

// Health
hp = 100
hpMax = hp
flash = 0
healthbarWidth = 100
healthbarHeight = 12
healthbarX = (320 / 2) - (healthbarWidth / 2)
healthbarY = ystart - 100

// Other
roofBonkingFix = true
wallAreYouDoing = [oWall, oInvisWall]
type = collisionType.box

// Setup player collision
collider = new PlayerCollider(self)

// Shader Color Swap
dualColorSwapSetup()

instance_create_layer(x, y, "Light", oPlayerLight)

