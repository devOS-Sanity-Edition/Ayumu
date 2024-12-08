draw_clear_alpha(c_black, 1) // i like having my scrolling background thank you very much, i get it doesnt make much sense considering what im learning but.. like.. cmon. maybe i'll reconsider in the future
gpu_set_blendmode_ext(bm_one, bm_zero)
//draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1)
gpu_set_blendmode(bm_normal)

// this all feels wrong
//surface_resize(application_surface, 320*((display_get_width()*2)/1920), 180*((display_get_height()*2)/1080))
//surface_resize(shadowSurface, 320*((display_get_width()*2)/1920), 180*((display_get_height()*2)/1080))
//surface_resize(application_surface,  320*((display_get_width()*2)/1920), 180*((display_get_height()*2)/1080))
//surface_resize(shadowSurface, room_width, room_height)