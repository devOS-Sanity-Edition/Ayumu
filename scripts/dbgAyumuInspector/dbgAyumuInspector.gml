// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dbgAyumuInspector() {
	dbg_view("Ayumu Inspector", true)
	dbg_section("Build information")
	dbg_text($"Build Date: {getBuildDate()}")
	dbg_text($"Build Date: {GM_build_type}")
	dbg_text($"GM Runtime Version: {GM_runtime_version}")
	dbg_text($"Game Version: {GM_version}-{getBuildDate()}")
	
	dbg_section("World")
	dbg_text_input(ref_create(global, "checkpointX"))
	dbg_text_input(ref_create(global, "checkpointY"))
	
	dbg_section("Volume", true)
	dbg_slider(ref_create(global, "masterVolume"), 0.0, 1.0, "Master")
	dbg_slider(ref_create(global, "musicVolume"), 0.0, 1.0, "Music")
	dbg_slider(ref_create(global, "sfxVolume"), 0.0, 1.0, "SFX")

	dbg_section("Camera", true)
	dbg_text_separator("Read only values [please do not edit / can't edit]")
	dbg_text_input(ref_create(oCamera.id, "finalCamX"), "X: ", "f")
	dbg_text_input(ref_create(oCamera.id, "finalCamY"), "Y: ", "f")
	dbg_text_separator("Editable values")
	dbg_text_input(ref_create(oCamera.id, "camTrailSpeed"), "Cam Trail Speed", "f")

	dbg_section("Movement")
	dbg_text_separator("Read only values [please do not edit / can't edit]")
	dbg_text_input(ref_create(oPlayer.id, "x"), "X: ", "f")
	dbg_text_input(ref_create(oPlayer.id, "y"), "Y: ", "f")
	dbg_text_input(ref_create(oPlayer.id, "face"), "Facing: ", "i")
	dbg_text_input(ref_create(oPlayer.id, "moveDir"), "Move Direction: ", "i")
	dbg_text_input(ref_create(oPlayer.id, "crouching"), "Crouching?", "i")
	dbg_text_input(ref_create(oPlayer.id, "crouchTimer"), "Crouch Timer", "i")
	dbg_text_input(ref_create(oPlayer.id, ""))
	
	dbg_text_separator("Editable values")
	dbg_text_input(ref_create(oPlayer.id, "moveSpeed", 0), "Walking speed", "f")
	dbg_text_input(ref_create(oPlayer.id, "moveSpeed", 1), "Sprinting speed", "f")
	dbg_text_input(ref_create(oPlayer.id, "grav"), "Gravity", "f")
	dbg_text_input(ref_create(oPlayer.id, "termVel"), "Terminal Velocity", "f")
	dbg_text_input(ref_create(oPlayer.id, "crouchSpeed"), "Crouch Speed", "f")
	dbg_text_input(ref_create(oPlayer.id, "currentMaskIndex"), "Mask Index")

	dbg_section("Jumping")
	dbg_text_separator("Read only values [please do not edit / can't edit]")
	dbg_text("ACTUALLY GENUINELY DO NOT TOUCH THE JUMP MAX, THE GAME WILL CRASH")
	dbg_text("AND I DONT FUCKING KNOW WHY, IM STUPID AT MATHS")
	dbg_text_input(ref_create(oPlayer.id, "jumpMax"), "Max", "i")
	dbg_text_input(ref_create(oPlayer.id, "jumpCount"), "Count", "i")
	dbg_text_input(ref_create(oPlayer.id, "onGround"), "Grounded?", "i")
	dbg_text_input(ref_create(oPlayer.id, "jumpHoldTimer"), "Hold Timer", "i")
	dbg_text_separator("Editable values")
	dbg_text_input(ref_create(oPlayer.id, "jumpSpeed", 0), "Jump Height 0", "f")
	dbg_text_input(ref_create(oPlayer.id, "jumpSpeed", 1), "Jump Height 1", "f")
	dbg_text_input(ref_create(oPlayer.id, "jumpHoldFrames", 0), "Hold Frames 0", "i")
	dbg_text_input(ref_create(oPlayer.id, "jumpHoldFrames", 1), "Hold Frames 1", "i")

	dbg_section("Coyote Time")
	dbg_text_separator("Read only values [please do not edit / can't edit]")
	dbg_text_input(ref_create(oPlayer.id, "coyoteHangTimer"), "Hang Timer", "i")
	dbg_text_input(ref_create(oPlayer.id, "coyoteJumpFrames"), "Jump Frames", "i")
	dbg_text_input(ref_create(oPlayer.id, "coyoteJumpTimer"), "Jump Timer", "i")
	dbg_text_separator("Editable values")
	dbg_text_input(ref_create(oPlayer.id, "coyoteHangFrames"), "Hang Frames", "i")

	dbg_section("Sprite")
	dbg_text_separator("Read only values [please do not edit / can't edit]")
	dbg_text_input(ref_create(oPlayer.id, "currentSpriteName"), "Current")
	dbg_text_input(ref_create(oPlayer.id, "currentSpriteSpeed"), "Current Speed", "r")
	dbg_sprite(ref_create(oPlayer.id, "sprite_index"), ref_create(oPlayer.id, "image_index"), "Sprite View", 64, 64)
	dbg_text_separator("Editable values")
}