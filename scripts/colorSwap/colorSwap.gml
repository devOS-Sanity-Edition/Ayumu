// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function colorSwapSetup() {
	// Shader Color Swap
	color_old1 = shader_get_uniform(shdrColorSwap, "color_old1")
	color_new1 = shader_get_uniform(shdrColorSwap, "color_new1")
	color_old2 = shader_get_uniform(shdrColorSwap, "color_old2")
	color_new2 = shader_get_uniform(shdrColorSwap, "color_new2")
}

function dualColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2) {
	shader_set(shdrColorSwap)
	shader_set_uniform_f(color_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(color_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(color_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(color_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}