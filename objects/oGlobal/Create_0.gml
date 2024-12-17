global.cheats = false

randomize()
global.particleSystem = part_system_create()

global.masterVolume = 0.75
global.musicVolume = 0.1
global.sfxVolume = 0.5

global.checkpointX = 0
global.checkpointY = 0

global.oneSecond = game_get_speed(gamespeed_fps)

part_system_depth(global.particleSystem, -350) // Create on layer -350, maybe decrease that further later on if more stuffs added to levels
