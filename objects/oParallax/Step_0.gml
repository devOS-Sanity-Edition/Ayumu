var layerBackgroundId = layer_get_id("PBackground")
var backgroundId = layer_background_get_id(layerBackgroundId)
layer_background_speed(backgroundId, 60)

layer_vspeed(layerBackgroundId, 8)
layer_hspeed(layerBackgroundId, 8)