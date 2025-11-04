extends CanvasLayer

func _ready() -> void:
	%build_num.text = "Build " + ProjectSettings.get_setting("global/Build_number")
	%version.text = "v. " + ProjectSettings.get_setting("application/config/version")
	
	%continue_button.pressed.connect(continue_game)
	%saves_button.pressed.connect(save_game)
	%load_button.pressed.connect(load_game)
	%exit_game_button.pressed.connect(get_tree().quit)
	
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
	SaveManagerLite.load_game()
	SaveLoad.save_file_data.data = SaveManagerLite.load_game()
	SaveLoad.load_data.emit()
	print(SaveLoad.save_file_data.data)
