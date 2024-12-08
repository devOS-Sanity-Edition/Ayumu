global.cheats = false

randomize()
global.particleSystem = part_system_create()

global.oneSecond = game_get_speed(gamespeed_fps)

part_system_depth(global.particleSystem, -1000) // Create on layer -1000, maybe decrease that further later on if more stuffs added to levels
