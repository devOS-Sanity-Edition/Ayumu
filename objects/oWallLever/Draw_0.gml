/// @description Insert description here
// You can write your code in this editor
// i guess i cant dynamically swap out the shader while the games running, idk, it wont turn green on activation
/*/switch (leverSwitched) {
	case true: 
		hexaColorSwapTime(182, 216, 236, 124, 252, 0, 197, 227, 245, 114, 232, 0, 155, 185, 203, 114, 232, 0, 48, 63, 72, 255, 59, 59, 55, 77, 90, 255, 79, 79, 37, 48, 55, 255, 39, 39)
		break
	case false:
		triColorSwapTime(48, 63, 72, 255, 59, 59, 55, 77, 90, 255, 79, 79, 37, 48, 55, 255, 39, 39)
		break
}/*/

/*/
var oldR1 = 182
var oldG1 = 216
var oldB1 = 236
var newR1 = 124
var newG1 = 252
var newB1 = 0
var oldR2 = 197
var oldG2 = 227
var oldB2 = 245
var newR2 = 114
var newG2 = 232
var newB2 = 0
var oldR3 = 155
var oldG3 = 185
var oldB3 = 203
var newR3 = 114
var newG3 = 232
var newB3 = 0

var _oldR1 = 48
var _oldG1 = 63
var _oldB1 = 72
var _newR1 = 255
var _newG1 = 59
var _newB1 = 59
var _oldR2 = 55
var _oldG2 = 77
var _oldB2 = 90
var _newR2 = 255
var _newG2 = 79
var _newB2 = 79
var _oldR3 = 37
var _oldG3 = 48
var _oldB3 = 55
var _newR3 = 255
var _newG3 = 39
var _newB3 = 39


shader_set(shdrColorSwap4Color)
if leverSwitched {
	shader_set_uniform_f(tricolor_old1, oldR1 / 255, oldG1 / 255, oldB1/255, 10 / 255)
	shader_set_uniform_f(tricolor_new1, newR1 / 255, newG1 / 255, newB1 / 255)
	shader_set_uniform_f(tricolor_old2, oldR2 / 255, oldG2 / 255, oldB2 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new2, newR2 / 255, newG2 / 255, newB2 / 255)
	shader_set_uniform_f(tricolor_old3, oldR3 / 255, oldG3 / 255, oldB3 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new3, newR3 / 255, newG3 / 255, newB3 / 255)
	shader_set_uniform_f(tricolor_old1, _oldR1 / 255, _oldG1 / 255, _oldB1/255, 10 / 255)
	shader_set_uniform_f(tricolor_new1, _newR1 / 255, _newG1 / 255, _newB1 / 255)
	shader_set_uniform_f(tricolor_old2, _oldR2 / 255, _oldG2 / 255, _oldB2 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new2, _newR2 / 255, _newG2 / 255, _newB2 / 255)
	shader_set_uniform_f(tricolor_old3, _oldR3 / 255, _oldG3 / 255, _oldB3 / 255, 10 / 255)
	shader_set_uniform_f(tricolor_new3, _newR3 / 255, _newG3 / 255, _newB3 / 255)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
} else {
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}
shader_reset()/*/

hexaColorSwapTime(182, 216, 236, 124, 252, 0, 197, 227, 245, 114, 232, 0, 155, 185, 203, 114, 232, 0, 48, 63, 72, 255, 59, 59, 55, 77, 90, 255, 79, 79, 37, 48, 55, 255, 39, 39)