var _playerWidth = oPlayer.sprite_width // 16
var _playerHeight = oPlayer.sprite_height // 16

var _lightX = oPlayer.x
var _lightY = oPlayer.y - 4.875

finalLightX += (_lightX - finalLightX) * lightTrailSpeed
finalLightY += (_lightY - finalLightY) * lightTrailSpeed

x = finalLightX
y = finalLightY