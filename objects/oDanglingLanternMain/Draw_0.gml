if verletSystemExists(lightsVerletSystem) {
	lightsVerletSystem.draw()
	
	if is_debug_overlay_open() {
		lightsVerletSystem.drawDebug()
	}
}