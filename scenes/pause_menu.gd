extends CanvasLayer

func _ready() -> void:
	%build_num.text = "Build " + ProjectSettings.get_setting("global/Build_number")
	%version.text = "v. " + ProjectSettings.get_setting("application/config/version")
	
	%settings_button.pressed.connect(%settings_win.show)
	%continue_button.pressed.connect(continue_game)

	%new_game_button.pressed.connect(%ConfirmationDialog.show)
	%exit_game_button.pressed.connect(func():
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit())
	%credits_exit_button.pressed.connect(%credits_win.hide)
	%credits_button.pressed.connect(%credits_win.show)
	%ConfirmationDialog.confirmed.connect(delete_game)
	
func continue_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		continue_game()

func delete_game():
	SaveSystem.create_new_save()
