extends Panel

func _ready() -> void:
	%exit_button.pressed.connect(queue_free)
