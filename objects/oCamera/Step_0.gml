if !instance_exists(oPlayer) {
	exit
}

// Get camera size
var _camWidth = camera_get_view_width(view_camera[0])
var _camHeight = camera_get_view_height(view_camera[0])

// Define and Set view x, y, min and max
var viewXMin = 0
var viewYMin = 0
var viewXMax = room_width - _camWidth
var viewYMax = room_height - _camHeight

// Get camera target co-ords
var _camX = oPlayer.x - _camWidth / 2
var _camY = oPlayer.y - _camHeight / 2

// Lock into camera boundry
with instance_position(x, y, oScreenBoundry) {
	viewXMin = bbox_left
	viewXMax = bbox_right - _camWidth
	viewYMin = bbox_top
	viewYMax = bbox_bottom - _camHeight
}

_camX = clamp(_camX, viewXMin, viewXMax)
_camY = clamp(_camY, viewYMin, viewYMax)

// Set cam co-ord variables
finalCamX += (_camX - finalCamX) * camTrailSpeed
finalCamY += (_camY - finalCamY) * camTrailSpeed

// Set camera co-ords
//camera_set_view_pos(view_camera[0], finalCamX, finalCamY)
camera_set_view_pos(view_camera[0], finalCamX, finalCamY)

