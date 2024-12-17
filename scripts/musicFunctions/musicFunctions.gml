function setSongIngame(_song, _fadeOutCurrentSong = 0, _fadeIn = 0) {
	// _song = Set to any song [including `noone` to stop or fade the track out]
	// _fadeOutCurrentSong = time [in frames] the current song [if playing] will take to fade out
	// _fadeIn = [in frames] the target song [if not `noone`] will take to fade out
	
	with (oMusicManager) {
		targetSongAsset = _song
		endFadeOutTime = _fadeOutCurrentSong
		startFadeInTime = _fadeIn
	}
}