function quad(_vb, _x1, _y1, _x2, _y2) {
	// Upper triangle
	vertex_position_3d(_vb, _x1, _y1, 0)
	vertex_position_3d(_vb, _x1, _y1, 2)
	vertex_position_3d(_vb, _x2, _y2, 1)
	
	// Lower triangle
	vertex_position_3d(_vb, _x1, _y1, 2)
	vertex_position_3d(_vb, _x2, _y2, 1)
	vertex_position_3d(_vb, _x2, _y2, 3)
}

vertex_begin(vb, vf)
var _vb = vb
//with(oWall) {
//	quad(_vb, x, y, x + sprite_width, y + sprite_height)
//	quad(_vb, x + sprite_width, y, x, y + sprite_height)
//}

with (oWall) {
	quad(_vb, x, y, x + sprite_width, y + sprite_height)
	quad(_vb, x + sprite_width, y, x, y + sprite_height)
}

/*/with (oSemiSolidWall) {
	quad(_vb, x, y, x + sprite_width, y + sprite_height)
	quad(_vb, x + sprite_width, y, x, y + sprite_height)
}/*/



with (oSlope0) { // i give up on slopes
//	quad(_vb, x, y, oSlope0.midX, oSlope0.midY)
//	quad(_vb, x, y + sprite_height, oSlope0.midX, oSlope0.midY)
//	quad(_vb, x + sprite_width, y + sprite_height, oSlope0.midX, oSlope0.midY)
}

vertex_end(vb)