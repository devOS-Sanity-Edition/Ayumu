// Script assets have changed for v2.3.0 see
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dualColorSwapSetup() {
	// Shader Color Swap
	dualColorOld1 = shader_get_uniform(shdrColorSwap2Color, "color_old1")
	dualColorNew1 = shader_get_uniform(shdrColorSwap2Color, "color_new1")
	dualColorOld2 = shader_get_uniform(shdrColorSwap2Color, "color_old2")
	dualColorNew2 = shader_get_uniform(shdrColorSwap2Color, "color_new2")
}

function triColorSwapSetup() {
	// Shader Color Swap
	triColorOld1 = shader_get_uniform(shdrColorSwap3Color, "color_old1")
	triColorNew1 = shader_get_uniform(shdrColorSwap3Color, "color_new1")
	triColorOld2 = shader_get_uniform(shdrColorSwap3Color, "color_old2")
	triColorNew2 = shader_get_uniform(shdrColorSwap3Color, "color_new2")
	triColorOld3 = shader_get_uniform(shdrColorSwap3Color, "color_old3")
	triColorNew3 = shader_get_uniform(shdrColorSwap3Color, "color_new3")
}

function quadColorSwapSetup() {
	// Shader Color Swap
	quadColorOld1 = shader_get_uniform(shdrColorSwap4Color, "color_old1")
	quadColorNew1 = shader_get_uniform(shdrColorSwap4Color, "color_new1")
	quadColorOld2 = shader_get_uniform(shdrColorSwap4Color, "color_old2")
	quadColorNew2 = shader_get_uniform(shdrColorSwap4Color, "color_new2")
	quadColorOld3 = shader_get_uniform(shdrColorSwap4Color, "color_old3")
	quadColorNew3 = shader_get_uniform(shdrColorSwap4Color, "color_new3")
	quadColorOld4 = shader_get_uniform(shdrColorSwap4Color, "color_old4")
	quadColorNew4 = shader_get_uniform(shdrColorSwap4Color, "color_new4")
}

function hexaColorSwapSetup() {
	// Shader Color Swap
	hexaColorOld1 = shader_get_uniform(shdrColorSwap6Color, "color_old1")
	hexaColorNew1 = shader_get_uniform(shdrColorSwap6Color, "color_new1")
	hexaColorOld2 = shader_get_uniform(shdrColorSwap6Color, "color_old2")
	hexaColorNew2 = shader_get_uniform(shdrColorSwap6Color, "color_new2")
	hexaColorOld3 = shader_get_uniform(shdrColorSwap6Color, "color_old3")
	hexaColorNew3 = shader_get_uniform(shdrColorSwap6Color, "color_new3")
	hexaColorOld4 = shader_get_uniform(shdrColorSwap6Color, "color_old4")
	hexaColorNew4 = shader_get_uniform(shdrColorSwap6Color, "color_new4")
	hexaColorOld5 = shader_get_uniform(shdrColorSwap6Color, "color_old5")
	hexaColorNew5 = shader_get_uniform(shdrColorSwap6Color, "color_new5")
	hexaColorOld6 = shader_get_uniform(shdrColorSwap6Color, "color_old6")
	hexaColorNew6 = shader_get_uniform(shdrColorSwap6Color, "color_new6")
}

function octaColorSwapSetup() {
	// Shader Color Swap
	octaColorOld1 = shader_get_uniform(shdrColorSwap8Color, "color_old1")
	octaColorNew1 = shader_get_uniform(shdrColorSwap8Color, "color_new1")
	octaColorOld2 = shader_get_uniform(shdrColorSwap8Color, "color_old2")
	octaColorNew2 = shader_get_uniform(shdrColorSwap8Color, "color_new2")
	octaColorOld3 = shader_get_uniform(shdrColorSwap8Color, "color_old3")
	octaColorNew3 = shader_get_uniform(shdrColorSwap8Color, "color_new3")
	octaColorOld4 = shader_get_uniform(shdrColorSwap8Color, "color_old4")
	octaColorNew4 = shader_get_uniform(shdrColorSwap8Color, "color_new4")
	octaColorOld5 = shader_get_uniform(shdrColorSwap8Color, "color_old5")
	octaColorNew5 = shader_get_uniform(shdrColorSwap8Color, "color_new5")
	octaColorOld6 = shader_get_uniform(shdrColorSwap8Color, "color_old6")
	octaColorNew6 = shader_get_uniform(shdrColorSwap8Color, "color_new6")
	octaColorOld7 = shader_get_uniform(shdrColorSwap8Color, "color_old7")
	octaColorNew7 = shader_get_uniform(shdrColorSwap8Color, "color_new7")
	octaColorOld8 = shader_get_uniform(shdrColorSwap8Color, "color_old8")
	octaColorNew8 = shader_get_uniform(shdrColorSwap8Color, "color_new8")
}

function dualColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2) {
	shader_set(shdrColorSwap2Color)
	shader_set_uniform_f(dualColorOld1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(dualColorNew1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(dualColorOld2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(dualColorNew2, newR2 / 255, newG2 / 255, newB2 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function triColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3) {
	shader_set(shdrColorSwap3Color)
	shader_set_uniform_f(triColorOld1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(triColorNew1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(triColorOld2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(triColorNew2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(triColorOld3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(triColorNew3, newR3 / 255, newG3 / 255, newB3 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function quadColorSwapTime(oldR1, oldG1, oldB1, newR1, newG1, newB1, oldR2, oldG2, oldB2, newR2, newG2, newB2, oldR3, oldG3, oldB3, newR3, newG3, newB3, oldR4, oldG4, oldB4, newR4, newG4, newB4) {
	shader_set(shdrColorSwap4Color)
	shader_set_uniform_f(quadColorOld1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(quadColorNew1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(quadColorOld2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(quadColorNew2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(quadColorOld3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(quadColorNew3, newR3 / 255, newG3 / 255, newB3 / 255)
	shader_set_uniform_f(quadColorOld4, oldR4 / 255, oldG4 / 255, oldB4 / 255, 10 / 255)
	shader_set_uniform_f(quadColorNew4, newR4 / 255, newG4 / 255, newB4 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

function hexaColorSwapTimeRGB(oldRGB0 = array_create(3), newRGB0 = array_create(3), oldRGB1 = array_create(3), newRGB1 = array_create(3), oldRGB2 = array_create(3), newRGB2 = array_create(3), oldRGB3 = array_create(3), newRGB3 = array_create(3), oldRGB4 = array_create(3), newRGB4 = array_create(3), oldRGB5 = array_create(3), newRGB5 = array_create(3)) {
	shader_set(shdrColorSwap6Color)
	shader_set_uniform_f(hexaColorOld1, oldRGB0[0] / 255, oldRGB0[1] / 255, oldRGB0[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew1, newRGB0[0] / 255, newRGB0[1] / 255, newRGB0[2] / 255)
	shader_set_uniform_f(hexaColorOld2, oldRGB1[0] / 255, oldRGB1[1] / 255, oldRGB1[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew2, newRGB1[0] / 255, newRGB1[1] / 255, newRGB1[2] / 255)
	shader_set_uniform_f(hexaColorOld3, oldRGB2[0] / 255, oldRGB2[1] / 255, oldRGB2[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew3, newRGB2[0] / 255, newRGB2[1] / 255, newRGB2[2] / 255)
	shader_set_uniform_f(hexaColorOld4, oldRGB3[0] / 255, oldRGB3[1] / 255, oldRGB3[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew4, newRGB3[0] / 255, newRGB3[1] / 255, newRGB3[2] / 255)
	shader_set_uniform_f(hexaColorOld5, oldRGB4[0] / 255, oldRGB4[1] / 255, oldRGB4[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew5, newRGB4[0] / 255, newRGB4[1] / 255, newRGB4[2] / 255)
	shader_set_uniform_f(hexaColorOld6, oldRGB5[0] / 255, oldRGB5[1] / 255, oldRGB5[2] / 255, 10 / 255)
	shader_set_uniform_f(hexaColorNew6, newRGB5[0] / 255, newRGB5[1] / 255, newRGB5[2] / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

/*/function hexaColorSwapTimeGMColor(oldColor0 = gmColorToRGBArray(oldColor0), newColor0 = gmColorToRGBArray(newColor0), oldColor1 = gmColorToRGBArray(oldColor1), newColor1 = gmColorToRGBArray(newColor1), oldColor2 = gmColorToRGBArray(oldColor2), newColor2 = gmColorToRGBArray(newColor2), oldColor3 = gmColorToRGBArray(oldColor3), newColor3 = gmColorToRGBArray(newColor3), oldColor4 = gmColorToRGBArray(oldColor4), newColor4 = gmColorToRGBArray(newColor4), oldColor5 = gmColorToRGBArray(oldColor5), newColor5 = gmColorToRGBArray(newColor5)) {
	shader_set(shdrColorSwap6Color)
	shader_set_uniform_f(hexaColorOld1, oldColor0[0] / 255, oldColor0[1] / 255, oldColor0[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew1, newColor0[0] / 255, newColor0[1] / 255, newColor0[2] / 255)
	shader_set_uniform_f(hexaColorOld2, oldColor1[0] / 255, oldColor1[1] / 255, oldColor1[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew2, newColor1[0] / 255, newColor1[1] / 255, newColor1[2] / 255)
	shader_set_uniform_f(hexaColorOld3, oldColor2[0] / 255, oldColor2[1] / 255, oldColor2[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew3, newColor2[0] / 255, newColor2[1] / 255, newColor2[2] / 255)
	shader_set_uniform_f(hexaColorOld4, oldColor3[0] / 255, oldColor3[1] / 255, oldColor3[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew4, newColor3[0] / 255, newColor3[1] / 255, newColor3[2] / 255)
	shader_set_uniform_f(hexaColorOld5, oldColor4[0] / 255, oldColor4[1] / 255, oldColor4[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew5, newColor4[0] / 255, newColor4[1] / 255, newColor4[2] / 255)
	shader_set_uniform_f(hexaColorOld6, oldColor5[0] / 255, oldColor5[1] / 255, oldColor5[2] /255, 10 / 255)
	shader_set_uniform_f(hexaColorNew6, newColor5[0] / 255, newColor5[1] / 255, newColor5[2] / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}/*/

function octaColorSwapTimeRGB(oldRGB0 = array_create(3), newRGB0 = array_create(3), oldRGB1 = array_create(3), newRGB1 = array_create(3), oldRGB2 = array_create(3), newRGB2 = array_create(3), oldRGB3 = array_create(3), newRGB3 = array_create(3), oldRGB4 = array_create(3), newRGB4 = array_create(3), oldRGB5 = array_create(3), newRGB5 = array_create(3), oldRGB6 = array_create(3), newRGB6 = array_create(3), oldRGB7 = array_create(3), newRGB7 = array_create(3)) {
	shader_set(shdrColorSwap8Color)
	shader_set_uniform_f(octaColorOld1, oldRGB0[0] / 255, oldRGB0[1] / 255, oldRGB0[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew1, newRGB0[0] / 255, newRGB0[1] / 255, newRGB0[2] / 255)
	shader_set_uniform_f(octaColorOld2, oldRGB1[0] / 255, oldRGB1[1] / 255, oldRGB1[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew2, newRGB1[0] / 255, newRGB1[1] / 255, newRGB1[2] / 255)
	shader_set_uniform_f(octaColorOld3, oldRGB2[0] / 255, oldRGB2[1] / 255, oldRGB2[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew3, newRGB2[0] / 255, newRGB2[1] / 255, newRGB2[2] / 255)
	shader_set_uniform_f(octaColorOld4, oldRGB3[0] / 255, oldRGB3[1] / 255, oldRGB3[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew4, newRGB3[0] / 255, newRGB3[1] / 255, newRGB3[2] / 255)
	shader_set_uniform_f(octaColorOld5, oldRGB4[0] / 255, oldRGB4[1] / 255, oldRGB4[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew5, newRGB4[0] / 255, newRGB4[1] / 255, newRGB4[2] / 255)
	shader_set_uniform_f(octaColorOld6, oldRGB5[0] / 255, oldRGB5[1] / 255, oldRGB5[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew6, newRGB5[0] / 255, newRGB5[1] / 255, newRGB5[2] / 255)
	shader_set_uniform_f(octaColorOld7, oldRGB6[0] / 255, oldRGB6[1] / 255, oldRGB6[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew7, newRGB6[0] / 255, newRGB6[1] / 255, newRGB6[2] / 255)
	shader_set_uniform_f(octaColorOld8, oldRGB7[0] / 255, oldRGB7[1] / 255, oldRGB7[2] / 255, 10 / 255)
	shader_set_uniform_f(octaColorNew8, newRGB7[0] / 255, newRGB7[1] / 255, newRGB7[2] / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}

/*/function octaColorSwapTimeGMColor(oldColor0 = gmColorToRGBArray(oldColor0), newColor0 = gmColorToRGBArray(newColor0), oldColor1 = gmColorToRGBArray(oldColor1), newColor1 = gmColorToRGBArray(newColor1), oldColor2 = gmColorToRGBArray(oldColor2), newColor2 = gmColorToRGBArray(newColor2), oldColor3 = gmColorToRGBArray(oldColor3), newColor3 = gmColorToRGBArray(newColor3), oldColor4 = gmColorToRGBArray(oldColor4), newColor4 = gmColorToRGBArray(newColor4), oldColor5 = gmColorToRGBArray(oldColor5), newColor5 = gmColorToRGBArray(newColor5), oldColor6 = gmColorToRGBArray(oldColor6), newColor6 = gmColorToRGBArray(newColor6), oldColor7 = gmColorToRGBArray(oldColor7), newColor7 = gmColorToRGBArray(newColor7)) {
	shader_set(shdrColorSwap8Color)
	shader_set_uniform_f(octaColorOld1, oldColor0[0] / 255, oldColor0[1] / 255, oldColor0[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew1, newColor0[0] / 255, newColor0[1] / 255, newColor0[2] / 255)
	shader_set_uniform_f(octaColorOld2, oldColor1[0] / 255, oldColor1[1] / 255, oldColor1[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew2, newColor1[0] / 255, newColor1[1] / 255, newColor1[2] / 255)
	shader_set_uniform_f(octaColorOld3, oldColor2[0] / 255, oldColor2[1] / 255, oldColor2[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew3, newColor2[0] / 255, newColor2[1] / 255, newColor2[2] / 255)
	shader_set_uniform_f(octaColorOld4, oldColor3[0] / 255, oldColor3[1] / 255, oldColor3[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew4, newColor3[0] / 255, newColor3[1] / 255, newColor3[2] / 255)
	shader_set_uniform_f(octaColorOld5, oldColor4[0] / 255, oldColor4[1] / 255, oldColor4[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew5, newColor4[0] / 255, newColor4[1] / 255, newColor4[2] / 255)
	shader_set_uniform_f(octaColorOld6, oldColor5[0] / 255, oldColor5[1] / 255, oldColor5[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew6, newColor5[0] / 255, newColor5[1] / 255, newColor5[2] / 255)
	shader_set_uniform_f(octaColorOld7, oldColor6[0] / 255, oldColor6[1] / 255, oldColor6[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew7, newColor6[0] / 255, newColor6[1] / 255, newColor6[2] / 255)
	shader_set_uniform_f(octaColorOld8, oldColor7[0] / 255, oldColor7[1] / 255, oldColor7[2] /255, 10 / 255)
	shader_set_uniform_f(octaColorNew8, newColor7[0] / 255, newColor7[1] / 255, newColor7[2] / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	shader_reset()
}/*/