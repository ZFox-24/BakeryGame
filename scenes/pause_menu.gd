extends CanvasLayer

func _ready() -> void:
	%build_num.text = "Build " + ProjectSettings.get_setting("global/Build_number")
	%version.text = "v. " + ProjectSettings.get_setting("application/config/version")
	
	%continue_button.pressed.connect(continue_game)
	%saves_button.pressed.connect(save_game)
	%load_button.pressed.connect(load_game)
	%new_game_button.pressed.connect(%ConfirmationDialog.show)
	%exit_game_button.pressed.connect(get_tree().quit)
	
	%ConfirmationDialog.confirmed.connect(delete_game)
	
func continue_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		continue_game()

func save_game():
	SaveLoad.save_data.emit()
	await SaveLoad.save_game
	SaveManagerLite.save_game(SaveLoad.save_file_data.data)
	print(SaveLoad.save_file_data.data)

func load_game():
	if FileAccess.file_exists(SaveManagerLite.save_path):
		SaveLoad.save_file_data.data = SaveManagerLite.load_game()
		get_tree().change_scene_to_file(SaveLoad.save_file_data.data["scene_loaded"])
		SaveLoad.load_data.emit()
		print(SaveLoad.save_file_data.data)
	#get_tree().paused = false

func delete_game():
	SaveManagerLite.delete_save()
	SceneManager.reload_game.emit()
