extends Panel

func _ready() -> void:
	#Warehouse.load_items()
	GameSettings.hide_mobile_buttons.emit()
	OrderManager.order_opened.emit()
	%exit_button.pressed.connect(exit_menu)
	check_bakery_state()
	%open_close_bakery_button.pressed.connect(bakery_state)

func exit_menu():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameSettings.show_mobile_buttons.emit()
	queue_free()

### УПРАВЛЕНИЕ ПЕКАРНЕЙ
func bakery_state():
	if !VisitorManager.is_bakery_open:
		VisitorManager.open_bakery.emit()
		VisitorManager.is_bakery_open = true
		%open_close_bakery_button.text = tr("TEXT_BAKERYCLOSE")
	else:
		VisitorManager.close_bakery.emit()
		VisitorManager.is_bakery_open = false
		%open_close_bakery_button.text = tr("TEXT_BAKERYOPEN")

func check_bakery_state():
	if !VisitorManager.is_bakery_open:
		%open_close_bakery_button.text = tr("TEXT_BAKERYOPEN")
	else:
		%open_close_bakery_button.text = tr("TEXT_BAKERYCLOSE")
