extends Panel

func _ready() -> void:
	%cancel_button.pressed.connect(hide)
	#%save_button.pressed.connect(SaveLoad.save_data.emit)
