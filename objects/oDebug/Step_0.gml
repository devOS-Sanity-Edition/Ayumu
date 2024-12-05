/// Docking
if (enable_docking) ImGui.DockSpaceOverViewport();

// Setup
if (!surface_exists(surf)) {
	surf = surface_create(128, 128);
	surface_set_target(surf);
	draw_clear_alpha(c_lime, 0.25);
	surface_reset_target();
}

// Menu
var exit_modal = false;
ImGui.BeginMainMenuBar();
if (ImGui.BeginMenu("File")) {
	if (ImGui.MenuItem("Enable Viewport", undefined, enable_docking)) {
		enable_docking = !enable_docking;
	}
	
	ImGui.Separator();
	
	if (ImGui.MenuItem("Exit")) {
		exit_modal = true;
	}
	ImGui.EndMenu();
}

if (exit_modal) ImGui.OpenPopup("Exit?");

ImGui.SetNextWindowPos(window_get_width() / 2, window_get_height () / 2, ImGuiCond.Appearing, 0.5, 0.5);
if (ImGui.BeginPopupModal("Exit?", undefined, ImGuiWindowFlags.NoResize)) {
	ImGui.Text("Are you sure you want to exit?");
	ImGui.Separator();
	if (ImGui.Button("Yes")) game_end();
	ImGui.SameLine();
	if (ImGui.Button("Nevermind")) ImGui.CloseCurrentPopup();
	ImGui.EndPopup();	
}

if (ImGui.BeginMenu("Windows")) {
	if (ImGui.MenuItem("Show Example Window", undefined, undefined, !main_open)) main_open = true;	
	if (ImGui.MenuItem("Show Demo Window", undefined, undefined, !demo_open)) demo_open = true;	
	ImGui.EndMenu();
}
ImGui.EndMainMenuBar();