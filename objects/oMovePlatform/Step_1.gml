// Move in a circle
platformDirection += rotationSpeed

// Get out target positions
var _targetX = xstart + lengthdir_x(radius, platformDirection)
var _targetY = ystart + lengthdir_y(radius, platformDirection)

// Get our xSpeed and ySpeed
xSpeed = _targetX - x
// xSpeed = 0
ySpeed = _targetY - y
//ySpeed = 0

x += xSpeed
y += ySpeed