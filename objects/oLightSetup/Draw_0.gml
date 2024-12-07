var _u_pos = u_pos
var _u_pos2 = u_pos2
var _u_zz = u_zz
var _u_str = u_str
var _vb = vb

if (!surface_exists(shadowSurface)) {
	shadowSurface = surface_create(view_wport[view_current], view_hport[view_current])
}

// this matrix seems redundant since my lights and shadows were already working w/ a moving camera, but im just following the tutorial so
matrix_set(matrix_world, matrix_build(view_xport[view_current], view_yport[view_current], 0, 0, 0, 0, 1, 1, 1))
surface_set_target(shadowSurface)
draw_clear_alpha(c_black, 0)

var objects = [oLight] // replace this with just a normal `with (oLight) {shadercodehere}` later
for (var i = 0; i < array_length(objects); i++) {
	with (objects[i]) {
		// Draw the shadows [light blockers]
		gpu_set_blendmode_ext_sepalpha(bm_zero, bm_one, bm_one, bm_one)
		shader_set(shdrShadow)
		shader_set_uniform_f(_u_pos2, x, y)
		vertex_submit(_vb, pr_trianglelist, -1)
		
		// Draw the light
		gpu_set_blendmode_ext_sepalpha(bm_inv_dest_alpha, bm_one, bm_zero, bm_zero)
		shader_set(shdrLight)
		shader_set_uniform_f(_u_pos, x, y)
		shader_set_uniform_f(_u_zz, size)
		shader_set_uniform_f(_u_str, str);
		// setting the x and y for this also redundant for reason on line 10 above
		draw_rectangle_color(view_xport[view_current], view_yport[view_current], room_width, room_height, color, color, color, color, 0)
		//draw_surface_ext(application_surface, view_xport[view_current], view_yport[view_current], 1, 1, 0, color, 1)
	}
}

// Draw and blend the shadow surface to the application surface
gpu_set_blendmode_ext(bm_dest_color, bm_src_alpha)
shader_reset()
//draw_surface(application_surface, view_xport[view_current], view_yport[view_current])


surface_reset_target()

// refer to line 10
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1))

gpu_set_blendmode_ext(bm_zero, bm_src_color)
shader_set(shdrShadowSurface)
draw_surface_ext(shadowSurface, 0, 0, 1, 1, 0, c_white, 0.8)
shader_reset()
gpu_set_blendmode(bm_normal)