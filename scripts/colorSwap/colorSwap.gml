// Script assets have changed for v2.3.0 see
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dualColorSwapSetup() {
	// Shader Color Swap
	dualcolor_old1 = shader_get_uniform(shdrColorSwap2Color, "color_old1")
	dualcolor_new1 = shader_get_uniform(shdrColorSwap2Color, "color_new1")
	dualcolor_old2 = shader_get_uniform(shdrColorSwap2Color, "color_old2")
	dualcolor_new2 = shader_get_uniform(shdrColorSwap2Color, "color_new2")
}

function triColorSwapSetup() {
	// Shader Color Swap
	tricolor_old1 = shader_get_uniform(shdrColorSwap3Color, "color_old1")
	tricolor_new1 = shader_get_uniform(shdrColorSwap3Color, "color_new1")
	tricolor_old2 = shader_get_uniform(shdrColorSwap3Color, "color_old2")
	tricolor_new2 = shader_get_uniform(shdrColorSwap3Color, "color_new2")
	tricolor_old3 = shader_get_uniform(shdrColorSwap3Color, "color_old3")
	tricolor_new3 = shader_get_uniform(shdrColorSwap3Color, "color_new3")
}

function quadColorSwapSetup() {
	// Shader Color Swap
	quadcolor_old1 = shader_get_uniform(shdrColorSwap4Color, "color_old1")
	quadcolor_new1 = shader_get_uniform(shdrColorSwap4Color, "color_new1")
	quadcolor_old2 = shader_get_uniform(shdrColorSwap4Color, "color_old2")
	quadcolor_new2 = shader_get_uniform(shdrColorSwap4Color, "color_new2")
	quadcolor_old3 = shader_get_uniform(shdrColorSwap4Color, "color_old3")
	quadcolor_new3 = shader_get_uniform(shdrColorSwap4Color, "color_new3")
	quadcolor_old4 = shader_get_uniform(shdrColorSwap4Color, "color_old4")
	quadcolor_new4 = shader_get_uniform(shdrColorSwap4Color, "color_new4")
}

function hexaColorSwapSetup() {
	// Shader Color Swap
	hexacolor_old1 = shader_get_uniform(shdrColorSwap6Color, "color_old1")
	hexacolor_new1 = shader_get_uniform(shdrColorSwap6Color, "color_new1")
	hexacolor_old2 = shader_get_uniform(shdrColorSwap6Color, "color_old2")
	hexacolor_new2 = shader_get_uniform(shdrColorSwap6Color, "color_new2")
	hexacolor_old3 = shader_get_uniform(shdrColorSwap6Color, "color_old3")
	hexacolor_new3 = shader_get_uniform(shdrColorSwap6Color, "color_new3")
	hexacolor_old4 = shader_get_uniform(shdrColorSwap6Color, "color_old4")
	hexacolor_new4 = shader_get_uniform(shdrColorSwap6Color, "color_new4")
	hexacolor_old5 = shader_get_uniform(shdrColorSwap6Color, "color_old5")
	hexacolor_new5 = shader_get_uniform(shdrColorSwap6Color, "color_new5")
	hexacolor_old6 = shader_get_uniform(shdrColorSwap6Color, "color_old6")
	hexacolor_new6 = shader_get_uniform(shdrColorSwap6Color, "color_new6")
}

function octaColorSwapSetup() {
	// Shader Color Swap
	octacolor_old1 = shader_get_uniform(shdrColorSwap8Color, "color_old1")
	octacolor_new1 = shader_get_uniform(shdrColorSwap8Color, "color_new1")
	octacolor_old2 = shader_get_uniform(shdrColorSwap8Color, "color_old2")
	octacolor_new2 = shader_get_uniform(shdrColorSwap8Color, "color_new2")
	octacolor_old3 = shader_get_uniform(shdrColorSwap8Color, "color_old3")
	octacolor_new3 = shader_get_uniform(shdrColorSwap8Color, "color_new3")
	octacolor_old4 = shader_get_uniform(shdrColorSwap8Color, "color_old4")
	octacolor_new4 = shader_get_uniform(shdrColorSwap8Color, "color_new4")
	octacolor_old5 = shader_get_uniform(shdrColorSwap8Color, "color_old5")
	octacolor_new5 = shader_get_uniform(shdrColorSwap8Color, "color_new5")
	octacolor_old6 = shader_get_uniform(shdrColorSwap8Color, "color_old6")
	octacolor_new6 = shader_get_uniform(shdrColorSwap8Color, "color_new6")
	octacolor_old7 = shader_get_uniform(shdrColorSwap8Color, "color_old7")
	octacolor_new7 = shader_get_uniform(shdrColorSwap8Color, "color_new7")
	octacolor_old8 = shader_get_uniform(shdrColorSwap8Color, "color_old8")
	octacolor_new8 = shader_get_uniform(shdrColorSwap8Color, "color_new8")
}

function dualColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2) {
	shader_set(shdrColorSwap2Color)
	shader_set_uniform_f(dualcolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(dualcolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(dualcolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(dualcolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function triColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3) {
	shader_set(shdrColorSwap3Color)
	shader_set_uniform_f(tricolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(tricolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(tricolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(tricolor_old3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new3, newR3 / 255, newG3 / 255, newB3 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function quadColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3, oldR4, oldG4, oldB4, newR4, newG4, newB4) {
	shader_set(shdrColorSwap4Color)
	shader_set_uniform_f(quadcolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(quadcolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(quadcolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(quadcolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(quadcolor_old3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(quadcolor_new3, newR3 / 255, newG3 / 255, newB3 / 255)
	shader_set_uniform_f(quadcolor_old4, oldR4 / 255, oldG4 / 255, oldB4 / 255, 10 / 255)
	shader_set_uniform_f(quadcolor_new4, newR4 / 255, newG4 / 255, newB4 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function hexaColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3, oldR4, oldG4, oldB4, newR4, newG4, newB4, oldR5, oldG5, oldB5, newR5, newG5, newB5, oldR6, oldG6, oldB6, newR6, newG6, newB6) {
	shader_set(shdrColorSwap6Color)
	shader_set_uniform_f(hexacolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(hexacolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(hexacolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(hexacolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(hexacolor_old3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(hexacolor_new3, newR3 / 255, newG3 / 255, newB3 / 255)
	shader_set_uniform_f(hexacolor_old4, oldR4 / 255, oldG4 / 255, oldB4 / 255, 10 / 255)
	shader_set_uniform_f(hexacolor_new4, newR4 / 255, newG4 / 255, newB4 / 255)
	shader_set_uniform_f(hexacolor_old5, oldR5 / 255, oldG5 / 255, oldB5 / 255, 10 / 255)
	shader_set_uniform_f(hexacolor_new5, newR5 / 255, newG5 / 255, newB5 / 255)
	shader_set_uniform_f(hexacolor_old6, oldR6 / 255, oldG6 / 255, oldB6 / 255, 10 / 255)
	shader_set_uniform_f(hexacolor_new6, newR6 / 255, newG6 / 255, newB6 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function octaColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3, oldR4, oldG4, oldB4, newR4, newG4, newB4, oldR5, oldG5, oldB5, newR5, newG5, newB5, oldR6, oldG6, oldB6, newR6, newG6, newB6, oldR7, oldG7, oldB7, newR7, newG7, newB7, oldR8, oldG8, oldB8, newR8, newG8, newB8) {
	shader_set(shdrColorSwap8Color)
	shader_set_uniform_f(octacolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(octacolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(octacolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(octacolor_old3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new3, newR3 / 255, newG3 / 255, newB3 / 255)
	shader_set_uniform_f(octacolor_old4, oldR4 / 255, oldG4 / 255, oldB4 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new4, newR4 / 255, newG4 / 255, newB4 / 255)
	shader_set_uniform_f(octacolor_old5, oldR5 / 255, oldG5 / 255, oldB5 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new5, newR5 / 255, newG5 / 255, newB5 / 255)
	shader_set_uniform_f(octacolor_old6, oldR6 / 255, oldG6 / 255, oldB6 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new6, newR6 / 255, newG6 / 255, newB6 / 255)
	shader_set_uniform_f(octacolor_old7, oldR7 / 255, oldG7 / 255, oldB7 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new7, newR7 / 255, newG7 / 255, newB7 / 255)
	shader_set_uniform_f(octacolor_old8, oldR8 / 255, oldG8 / 255, oldB8 / 255, 10 / 255)
	shader_set_uniform_f(octacolor_new8, newR8 / 255, newG8 / 255, newB8 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}