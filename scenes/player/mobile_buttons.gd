extends Control

func _ready() -> void:
	GameSettings.show_mobile_buttons.connect(show)
	GameSettings.hide_mobile_buttons.connect(hide)
	
	var cancel_event = InputEventAction.new()
	cancel_event.action = "ui_cancel"
	cancel_event.pressed = true
	
	var interact_event = InputEventAction.new()
	interact_event.action = "interact"
	interact_event.pressed = true
	
	%pause_button.pressed.connect(func():
		Input.parse_input_event(cancel_event)
		Input.action_release("ui_cancel"))
	%interact_button.pressed.connect(func():
		Input.parse_input_event(interact_event)
		Input.action_release("interact"))
