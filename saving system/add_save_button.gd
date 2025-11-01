extends Button

func _ready() -> void:
	pressed.connect(emit_menu_signal)

func emit_menu_signal():
	SavesManagement.create_save_menu_open.emit()
