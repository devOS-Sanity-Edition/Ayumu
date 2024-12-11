// we dont use the color swap helper funcs here bc of the flipped image scale thing and i kinda dont want to pass that onto the helper func itself ngl, esp with how long it already is
shader_set(shdrColorSwap2Color)
shader_set_uniform_f(dualColorOld1, 197/255, 196/255, 195/255, 10/255)
shader_set_uniform_f(dualColorNew1, 0/255, 230/255, 0/255)
shader_set_uniform_f(dualColorOld2, 210/255, 210/255, 210/255, 10/255)
shader_set_uniform_f(dualColorNew2, 0/255, 255/255, 0/255)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * face, image_yscale, image_angle, image_blend, image_alpha)
shader_reset()
