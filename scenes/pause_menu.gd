extends CanvasLayer

func _ready() -> void:
	%continue_button.pressed.connect(continue_game)
	%exit_game_button.pressed.connect(get_tree().quit)
	
func continue_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		continue_game()
