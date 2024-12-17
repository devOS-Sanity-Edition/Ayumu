// Info for the song we are currently playing / trying to play
songInstance = noone
songAsset = noone
targetSongAsset = mDeepBlue

// How many frames to fade out the new song playing
endFadeOutTime = 0

// How many frames to fade in the new song
startFadeInTime = 0

// The volume of the song instance
fadeInInstanceVolume = 1

// For fading music out and stopping sons that are no longer playing
// The audio instances to fade out
fadeOutInstances = array_create(0)

// The volumes of each individual audio instance
fadeOutInstanceVolume = array_create(0)

// How fast the fadeout should happen
fadeOutInstanceTime = array_create(0)