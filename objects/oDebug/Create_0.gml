ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);	

randomize();

header_visible = true;
enable_docking = false;
enablePlayerStats = true
init = false;

col = c_blue;                     // for TextColored
col2 = c_white;                   // for Image & ColorPicker
col3 = c_lime;                    // for ColorPicker3
col4 = new ImColor(c_aqua, 0.5);  // for ColorPicker4
col5 = c_fuchsia;
col6 = new ImColor(irandom(255), irandom(255), irandom(255), random(1));
dir = ImGuiDir.Right;             // for ArrowButton

surf = -1;                        // for Surface

_static = undefined;
try {
	_static = static_get(ImGui);
} catch (e) {
	_static = undefined;
}

font_default = ImGui.AddFontDefault();
font_roboto = ImGui.AddFontFromFile("fonts/Roboto-Regular.ttf", 24);