function controlsSetup() {
	bufferTime = 5
	
	jumpKeyBuffered = false
	jumpKeyBufferTimer = 0
}

function getControls() {
	// Direction inputs
	rightKey = keyboard_check(ord("D")) + keyboard_check(vk_right) + gamepad_button_check(0, gp_padr) + (gamepad_axis_value(0, gp_axislh) > 0.5) // Gamepad right / Left analog stick right
	rightKey = clamp(rightKey, 0, 1)
	
	leftKey = keyboard_check(ord("A")) + keyboard_check(vk_left) + gamepad_button_check(0, gp_padl) + (gamepad_axis_value(0, gp_axislh) < -0.5)
	leftKey = clamp(leftKey, 0, 1)
	
	// Action inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0, gp_face1) // A Button on Xbox, Cross on PS
	jumpKeyPressed = clamp(jumpKeyPressed, 0, 1)
	
	jumpKey = keyboard_check(vk_space) + gamepad_button_check(0, gp_face1)
	jumpKey = clamp(jumpKey, 0, 1)
	
	downKey = keyboard_check(ord("S")) + keyboard_check(vk_down) + gamepad_button_check(0, gp_padd) + (gamepad_axis_value(0, gp_axislv) > 0.5) // Down on D-PAD
	downKey = clamp(downKey, 0, 1)
	
	upKey = keyboard_check(ord("W")) + keyboard_check(vk_up) + gamepad_button_check(0, gp_padu) + (gamepad_axis_value(0, gp_axislv) < -0.5) // Up on D-Pad
	upKey = clamp(upKey, 0, 1)
	
	runKey = keyboard_check(vk_shift) + gamepad_button_check(0, gp_face3) + gamepad_button_check(0, gp_shoulderrb) // X Button on Xbox, Square on PS and Right Trigger
	runKey = clamp(runKey, 0, 1)
	
	interactKey = keyboard_check_pressed(ord("E")) + gamepad_button_check_pressed(0, gp_face2) // 
	interactKey = clamp(interactKey, 0, 1)
	
	// Jump key buffering
	if jumpKeyPressed {
		jumpKeyBufferTimer = bufferTime
	}
	
	if jumpKeyBufferTimer > 0 {
		jumpKeyBuffered = true
		jumpKeyBufferTimer--
	} else {
		jumpKeyBuffered = false
	}
}