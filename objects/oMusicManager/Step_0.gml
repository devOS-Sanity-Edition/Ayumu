var _finalVolume = global.musicVolume * global.masterVolume

// Play the target song
if songAsset != targetSongAsset {
	// Tell the old song to fade the fuck out
	if audio_is_playing(songInstance) {
		// Add out song instance to our array of songs to fade out
		array_push(fadeOutInstances, songInstance)
		
		// Add the song instance's starting volume [so there's no abrupt change in volume]
		array_push(fadeOutInstanceVolume, fadeInInstanceVolume)
		
		// Add the fade out instances' fade out frames
		array_push(fadeOutInstanceTime, endFadeOutTime)
		
		// Reset the song instance and song asset variables
		songInstance = noone
		songAsset = noone
	}
	
	// Play the song, if the old song has faded out
	if array_length(fadeOutInstances) == 0 {
		if audio_exists(targetSongAsset) {
			// Play the song and store its instance in a variable
			songInstance = audio_play_sound(targetSongAsset, 4, true)
	
			// Start the song's volume at 0
			audio_sound_gain(songInstance, 0, 0)
			fadeInInstanceVolume = 0
		}
	
		// Set the song asset to match the target song asset
		songAsset = targetSongAsset	
	}
}

// Volume control
// Main song volume
if audio_is_playing(songInstance) {
	if startFadeInTime > 0 {
		if fadeInInstanceVolume < 1 {
			fadeInInstanceVolume += 1 / startFadeInTime
		} else {
			fadeInInstanceVolume = 1
		}
	// Immediately start the song if the fade in time is 0 frames
	} else {
		fadeInInstanceVolume = 1
	}
	
	// Actually set the gain
	audio_sound_gain(songInstance, fadeInInstanceVolume * _finalVolume, 0)
}

// Fading songs out
for (var i = 0; i < array_length(fadeOutInstances); i++) {
	// Fade the volume
	if fadeOutInstanceTime[i] > 0 {
		if fadeOutInstanceVolume[i] > 0 {
			fadeOutInstanceVolume[i] -= 1 / fadeOutInstanceTime[i]
		}
		
		// Immediate cut volume to 0 otherwise
		else {
			fadeOutInstanceVolume[i] = 0
		}
		
		audio_sound_gain(fadeOutInstances[i], fadeOutInstanceVolume[i] * _finalVolume, 0)
		
		// Stop the song when its volume is at 0, and remove it from ALL arrays
		if fadeOutInstanceVolume[i] <= 0 {
			// Stop the song
			if audio_is_playing(fadeOutInstances[i]) {
				audio_stop_sound(fadeOutInstances[i])
			}
			
			// Remove it from the arrays
			array_delete(fadeOutInstances, i, 1)
			array_delete(fadeOutInstanceVolume, i, 1)
			array_delete(fadeOutTime, i, 1)
			
			// Set the loop back 1 since we just deleted an entry
			i--
		}
	}
}