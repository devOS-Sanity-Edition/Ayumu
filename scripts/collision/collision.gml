#region Player Collision

/**
 * Create a player collider. This struct handles collision detection on the player object
 * @param {Id.Instance} _player
 */
function PlayerCollider(_player) constructor {
	player = _player;
	subPixel = .5
	
	/**
	 * @param {Real} _x
	 * @param {Real} _y
	 */
	checkForSemiSolidPlatform = function(_x, _y) {
		with (player) {
			// Create a return variable
			var _rtrn = noone
	
			// Must not be moving upwards, and then check for normal collision
			if ySpeed >= 0 && place_meeting(_x, _y, oSemiSolidWall) {
				// Create a DS List [Data Structure List] to store all colliding instances of oSemiSolidWall
				var _list = ds_list_create()
				var _listSize = instance_place_list(_x, _y, oSemiSolidWall, _list, false)
		
				// Loop through the colliding instances and only return one of its top is below the player
				for (var i = 0; i < _listSize; i++) {
					var _listInst = _list[| i]
					if _listInst != forgetSemiSolid && floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed) {
						// Return the ID of a semi-solid platform
						_rtrn = _listInst
				
						// Exit the loop early
						i = _listSize
					}
				}
		
				// Destroy DS List so you don't end up with a fucking memory leak
				ds_list_destroy(_list)
			}
	
			// Return out var
			return _rtrn
		}
	}
	
	// Get out of solid movePlatforms that have positioned themselves into the player in the begin step
	avoidMovePlatforms = function() {
		with (player) {
			var _rightWall = noone
		    var _leftWall = noone
		    var _bottomWall = noone
		    var _topWall = noone
		    var _list = ds_list_create()
		    var _listSize  = instance_place_list(x, y, oMovePlatform, _list, false)
    
		    // Loop through all colliding move platforms
		    for (var i = 0; i < _listSize; i++) {
		        var _listInst = _list[| i]
        
		        // If there are walls to the right of me, get the closest one
		        // Right walls
		        if _listInst.bbox_left - _listInst.xSpeed >= bbox_right - 1 {
		            if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left {
		                _rightWall = _listInst
		            }
		        }
		        // Left walls
		        if _listInst.bbox_right - _listInst.xSpeed <= bbox_left - 1 {
		            if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right{
		                _leftWall = _listInst
		            }
		        }
        
		        // Bottom walls
		        if _listInst.bbox_top - _listInst.ySpeed >= bbox_bottom - 1 {
		            if !_bottomWall || _listInst.bbox_top < _bottomWall.bbox_top {
		                _bottomWall = _listInst
		            }
		        }
        
		        // Top walls
		        if _listInst.bbox_bottom - _listInst.ySpeed <= bbox_top + 1 {
		            if !_topWall || _listInst.bbox_bottom > _topWall.bbox_bottom {
		                _topWall = _listInst
		            }
		        }
		    }
    
		    // Destroy DS List, memory leak not happening
		    ds_list_destroy(_list)
    
		    // Get out of the walls
		    // Right wall
		    if instance_exists(_rightWall) {
		        var _rightDistance = bbox_right - x
		        x = _rightWall.bbox_left - _rightDistance
		    }
		    // Left wall
		    if instance_exists(_leftWall) {
		        var _leftDistance = x - bbox_left
		        x = _leftWall.bbox_right + _leftDistance
		    }
		    // Bottom wall
		    if instance_exists(_bottomWall) {
		        var _bottomDistance = bbox_bottom - y
		        y = _bottomWall.bbox_top - _bottomDistance
		    }
		    // Top wall [includes collision for polish and crouching features]
		    if instance_exists(_topWall) {
		        var _upDistance = y - bbox_top
		        var _targetY = _topWall.bbox_bottom + _upDistance
        
		        // Check if there isn't a wall in the way
		        if !place_meeting(x, _targetY, oWall) {
		            y = _targetY
		        }
		    }
		}
	}
	
	collideX = function() {
		var _subPixel = subPixel // prevent scoping issues
		
		with (player) {
			// X collision
		    if place_meeting(x + xSpeed, y, oWall) {
		        // First check if there is a slope to go up
		        if !place_meeting(x + xSpeed, y - abs(xSpeed) - 1, oWall) {
		            while place_meeting(x + xSpeed, y, oWall) {
		                y -= _subPixel
		            }
		        } else { // Check for ceiling slope next, and if there isn't a slope, use normal collision
		            // Ceiling slopes
		            if !place_meeting(x + xSpeed, y + abs(xSpeed * 1.5) + 1, oWall) {
		                while place_meeting(x + xSpeed, y, oWall) {
		                    y += _subPixel
		                }
		            } else { // Normal collision
		                // Scoot up to wall precisely
		                var _pixelCheck = _subPixel * sign(xSpeed)
		                while !place_meeting(x + _pixelCheck, y, oWall) {
		                    x += _pixelCheck
		                }
		            }
            
		            // Set xSpeed to zero to `collide`
		            xSpeed = 0
		        }
		    }
		}
	}
	
	collideUp = function() {
		var _subPixel = subPixel // prevent scoping issues
		
		with (player) {
			if ySpeed < 0 && place_meeting(x, y + ySpeed, oWall) {
				// Jump into sloped ceilings
				var _slopeSlide = false
	
				// Slide up left
				if moveDir == 0 && !place_meeting(x - abs(ySpeed) - 1, y + ySpeed, oWall) {
					while place_meeting(x, y + ySpeed, oWall) {
						x -= 1
					}
					_slopeSlide = true
				}
	
				// Slide up right
				if moveDir == 0 && !place_meeting(x - abs(ySpeed) + 1, y + ySpeed, oWall) {
					while place_meeting(x, y + ySpeed, oWall) {
						x += 1
					}
					_slopeSlide = true
				}
	
				if !_slopeSlide {
					// Scoot up to the wall precisely
					var _pixelCheck = _subPixel * sign(ySpeed)
					while !place_meeting(x, y + _pixelCheck, oWall) {
						y += _pixelCheck
					}
	
					if (ySpeed < 0) {
						jumpHoldTimer = 0
					}
		
					// Set ySpeed to 0 to collide
					ySpeed = 0
				}
			}
		}
	}
	
	collideDown = function() {
		// prevent scoping issues
		var _checkForSemiSolidPlatform = checkForSemiSolidPlatform
		var _subPixel = subPixel
		// Downwards Y collision
		with (player) {
			// Floor Y Collision
			// Check for solid and semisolid platforms under player
			var _clampYSpeed = max(0, ySpeed)
			var _list = ds_list_create() // Create a DS list to store all of the objects the player is running into
			var _array = array_create(0)
			array_push(_array, oWall, oSemiSolidWall)

			// Do the actual check and add objects to list
			var _listSize = instance_place_list(x, y + 1 + _clampYSpeed + movePlatformYSpeed, _array, _list, false)

			// For higher-res art / high speed project fixes - Check for a semi-solid platform below player
			var _yCheck = y + 1 + _clampYSpeed
			if instance_exists(floorPlatform) {
				_yCheck += max(0, floorPlatform.ySpeed)
			}
			var _semiSolid = _checkForSemiSolidPlatform(x, _yCheck)

			// Loop through the colliding instances and only return one if it's top is below the player
			for (var i = 0; i < _listSize; i++) {
				// Get an instance of oWall or oSemiSolidWall from the list
				var _listInst = _list[| i]
	
				// Avoid magnetism
				if (_listInst != forgetSemiSolid
					&& (_listInst.ySpeed <= ySpeed || instance_exists(floorPlatform)) 
					&& (_listInst.ySpeed > 0 || place_meeting(x, y + 1 + _clampYSpeed, _listInst))
				) || (_listInst == _semiSolid) {
					// Return a solid wall of any semisolid walls that are below the player
					if _listInst.object_index == oWall 
						|| object_is_ancestor(_listInst.object_index, oWall) 
						|| floor(bbox_bottom) <= ceil(_listInst.bbox_top - _listInst.ySpeed)
					{
						// Return the `highest` wall object
						if !instance_exists(floorPlatform) 
							|| _listInst.bbox_top + _listInst.ySpeed <= floorPlatform.bbox_top + floorPlatform.ySpeed 
							|| _listInst.bbox_top + _listInst.ySpeed <= bbox_bottom 
						{
							floorPlatform = _listInst
						}
					}
				}
			}

			// Destroy the DS List to avoid a memory leak
			ds_list_destroy(_list)

			// Downslope semi-solid for making sure we don't miss semi-solids while going down slipes
			if instance_exists(downSlopeSemiSolid) {
				floorPlatform = downSlopeSemiSolid
			}

			// One last check to make sure the floor platform is actually below us
			if instance_exists(floorPlatform) && !place_meeting(x, y + movePlatformYSpeed, floorPlatform) {
				floorPlatform = noone
			}

			// Land on the ground platform if there is one
			if instance_exists(floorPlatform) {
				// Scoot up to wall precisely
				while !place_meeting(x, y + _subPixel, floorPlatform) && !place_meeting(x, y, oWall) {
					y += _subPixel
				}
	
				// Make sure we don't end up below the top of a semisolid
				if floorPlatform.object_index == oSemiSolidWall || object_is_ancestor(floorPlatform.object_index, oSemiSolidWall) {
					while place_meeting(x, y, floorPlatform) {
						y -= _subPixel
					}
				}
	
				// [do not] Floor the Y variable [because you will get a tiny jump when crossing slopes past the original block]
				// y = y
	
				// Collide with the ground
				ySpeed = 0
				setOnGround()
			}
		}
	}
	
	goDownSlopes = function() {
		// prevent scoping issues
		var _checkForSemiSolidPlatform = checkForSemiSolidPlatform 
		var _subPixel = subPixel
		
		// Go down slopes
	    with (player) {
			downSlopeSemiSolid = noone // [duct tape solution]
		    if ySpeed >= 0 
				&& !place_meeting(x + xSpeed, y + 1, oWall) 
				&& place_meeting(x + xSpeed, y + abs(xSpeed) + 1, oWall) 
			{
		        // Check for a semisolid in the way [duct tape solution]
		        downSlopeSemiSolid = _checkForSemiSolidPlatform(x + xSpeed, y + abs(xSpeed) + 1)
        
		        // Precisely move down the slipe if there isn't a semi-solid in the way
		        if !instance_exists(downSlopeSemiSolid) {
		            while !place_meeting(x + xSpeed, y + _subPixel, oWall) {
		                y += _subPixel
		            }
		        }
		    }
		}
	}
}

#endregion
