ImGui.__Initialize();
ImGui.ConfigFlagToggle(ImGuiConfigFlags.DockingEnable);	

randomize();

main_open = true;
demo_open = true;
header_visible = true;
enable_docking = false;
init = false;

_static = undefined;
try {
	_static = static_get(ImGui);
} catch (e) {
	_static = undefined;
}

font_default = ImGui.AddFontDefault();
font_roboto = ImGui.AddFontFromFile("fonts/Roboto-Regular.ttf", 24);