// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dbgAyumuIntro(){
	dbg_view("Intro", true, (window_get_x) * (4 / 2), 65, 475, 250)
	dbg_text("Howdy! Welcome to Ayumu, an MVP by asojidev")
	dbg_text_separator("Basic movement")
	dbg_text("WASD / Arrow Keys - Move")
	dbg_text("SHIFT - Sprint")
	dbg_text("SPACE - Jump")
	dbg_text("S/Down + SPACE - Move down from Semi-solids")
	dbg_text_separator("Extended Movement")
	dbg_text("SPACE x 2 - Double Jump")
	dbg_text("You can hold or release jump early for variable jump")
	dbg_text("Coyote jump exists for a few frames moving off the platforms")
}