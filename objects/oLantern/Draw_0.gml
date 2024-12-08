/*/shader_set(shdrColorSwap)
shader_set_uniform_f(color_old1, 182/255, 216/255, 236/255, 10/255)
shader_set_uniform_f(color_new1,255 / 255, 199 / 255, 43 / 255)
shader_set_uniform_f(color_old2, 155/255, 185/255, 203/255, 10/255)
shader_set_uniform_f(color_new2, 255 / 255, 214 / 255, 102 / 255)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
shader_reset()/*/

dualColorSwapTime(182, 216, 236, darkPaletteR, darkPaletteG, darkPaletteB, 155, 185, 203, brightPaletteR, brightPaletteG, brightPaletteB)