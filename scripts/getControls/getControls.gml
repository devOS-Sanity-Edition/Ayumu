function controlsSetup() {
	bufferTime = 5
	
	jumpKeyBuffered = false
	jumpKeyBufferTimer = 0
}

function getControls() {
	// Direction inputs
	rightKey = keyboard_check(ord("D")) + keyboard_check(vk_right)
	rightKey = clamp(rightKey, 0, 1)
	
	leftKey = keyboard_check(ord("A")) + keyboard_check(vk_left)
	leftKey = clamp(leftKey, 0, 1)
	
	// Action inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) + keyboard_check_pressed(vk_up)
	jumpKeyPressed = clamp(jumpKeyPressed, 0, 1)
	
	jumpKey = keyboard_check(vk_space) + keyboard_check(vk_up)
	jumpKey = clamp(jumpKey, 0, 1)
	
	runKey = keyboard_check(vk_control)
	runKey = clamp(runKey, 0, 1)
	
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