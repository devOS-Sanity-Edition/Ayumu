// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmColorToRGBArray(colorVar) {
	var _color = int64(ptr(string_replace(colorVar, "$", "")))
	// _color = ((_color & 0xFF0000) >> 16) | (_color & 0x00FF00) | ((_color & 0x0000FF) << 16); // RGB
	_color = ((_color & 0x0000FF) << 16 | (_color & 0x00FF00) | ((_color & 0xFF0000) >> 16)) // BGR
	
	color = color_get_value(_color)
	colorArray[0] = color_get_red(color)
	colorArray[1] = color_get_green(color)
	colorArray[2] = color_get_blue(color)
	
	
	return colorArray
}