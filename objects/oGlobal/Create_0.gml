global.cheats = false

randomize()
global.particleSystem = part_system_create()

global.oneSecond = game_get_speed(gamespeed_fps)

part_system_depth(global.particleSystem, -350) // Create on layer -350, maybe decrease that further later on if more stuffs added to levels
