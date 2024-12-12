if verletSystemExists(lightsVerletSystem) {
	lightsVerletSystem.cleanup()
	delete lightsVerletSystem
}