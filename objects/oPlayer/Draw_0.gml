shader_set(shdrSlimeColor)
shader_set_uniform_f(color_old1, 197/255, 196/255, 195/255, 10/255)
shader_set_uniform_f(color_new1, 0/255, 230/255, 0/255)
shader_set_uniform_f(color_old2, 210/255, 210/255, 210/255, 10/255)
shader_set_uniform_f(color_new2, 0/255, 255/255, 0/255)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * face, image_yscale, image_angle, image_blend, image_alpha)
shader_reset()