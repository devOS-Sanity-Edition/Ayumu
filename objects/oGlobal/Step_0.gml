if (keyboard_check_pressed(vk_tab)) {
	show_debug_overlay(true, false, 1, 0.75)
	show_debug_log(true)
}

if (keyboard_check_pressed(vk_f4)) {
	window_set_fullscreen(!window_get_fullscreen())
}