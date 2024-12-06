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
	
	if (ImGui.MenuItem("Player Statistics", undefined, enablePlayerStats)) {
		enablePlayerStats = !enablePlayerStats
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

ImGui.EndMainMenuBar();

if (enablePlayerStats) {
	ImGui.SetNextWindowSize(550, 620, ImGuiCond.None)
	ImGui.Begin("Debug panel")

	ImGui.Text("Camera")
	ImGui.InputFloat2("X/Y Position", [oCamera.finalCamX, oCamera.finalCamY])
	ImGui.InputFloat("Set Camera Trail Speed", oCamera.camTrailSpeed)
	ImGui.Text("Movement")
	ImGui.InputFloat2("X/Y Position", [oPlayer.x, oPlayer.y])
	ImGui.InputInt("Facing", oPlayer.face)
	ImGui.InputInt("Movement Direction", oPlayer.moveDir)
	ImGui.InputFloat2("Set Walk/Sprint Speed", [oPlayer.moveSpeed[0], oPlayer.moveSpeed[1]])
	ImGui.InputFloat("X Speed", oPlayer.xSpeed)
	ImGui.InputFloat("Y Speed", oPlayer.ySpeed)
	ImGui.InputFloat("Gravity", oPlayer.grav)
	ImGui.InputInt("Terminal Velocity", oPlayer.termVel)
	ImGui.Separator()
	ImGui.Text("Jumping")
	ImGui.InputInt("Max", oPlayer.jumpMax)
	ImGui.InputInt("Count", oPlayer.jumpCount)
	ImGui.InputInt("Hold Timer", oPlayer.jumpHoldTimer)
	ImGui.InputFloat2("Set Speed", [oPlayer.jumpSpeed[0], oPlayer.jumpSpeed[1]])
	ImGui.InputInt2("Set Hold Frames", [oPlayer.jumpHoldFrames[0], oPlayer.jumpHoldFrames[1]])
	ImGui.InputInt("On Ground", oPlayer.onGround)
	ImGui.Separator()
	ImGui.Text("Coyote Time")
	ImGui.InputInt("Set Hang Frames", oPlayer.coyoteHangFrames)
	ImGui.InputInt("Hang Timer", oPlayer.coyoteHangTimer)
	ImGui.InputInt("Jump Timer", oPlayer.coyoteJumpTimer)
	ImGui.InputInt("Hang Jump Frames", oPlayer.coyoteJumpFrames)
	ImGui.Separator()
	ImGui.Text("Sprite")
	ImGui.InputText("Current Spr", sprite_get_name(oPlayer.sprite_index[0]))

	ImGui.End()
}