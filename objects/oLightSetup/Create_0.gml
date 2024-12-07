surface_resize(application_surface, view_wport[view_current], view_hport[view_current])
display_set_gui_maximize()
application_surface_draw_enable(false)

u_pos = shader_get_uniform(shdrLight, "u_pos")
u_zz = shader_get_uniform(shdrLight, "zz")
u_pos2 = shader_get_uniform(shdrShadow, "u_pos")
u_str = shader_get_uniform(shdrShadow, "u_str")

vertex_format_begin()
vertex_format_add_position_3d()
vf = vertex_format_end()
vb = vertex_create_buffer()

shadowSurface = noone

function bgBegin() {
	gpu_set_colorwriteenable(1, 1, 1, 0)
}

function bgEnd() {
	gpu_set_colorwriteenable(1, 1, 1, 1)
}

var _bgLayer = layer_get_id("PBackground")
layer_script_begin(_bgLayer, bgBegin)
layer_script_end(_bgLayer, bgEnd)