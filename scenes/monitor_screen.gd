extends Panel

func _ready() -> void:
	Warehouse.load_products()
	OrderManager.order_opened.emit()
	#item.item_quantity = randi_range(1, 8)
	#%item_name.text = item.item_name
	#%item_icon.texture = item.item_icon
	#%item_quantity.text = str(item.item_quantity)
	#%item_price.text = str(item.item_price)
	#%final_price.text = str(roundi((item.item_price * item.item_quantity) * 1.05))
	%exit_button.pressed.connect(exit_menu)
	#%sell_button.pressed.connect(sell_item)

	check_bakery_state()
	%open_close_bakery_button.pressed.connect(bakery_state)

func exit_menu():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()

### УПРАВЛЕНИЕ ПЕКАРНЕЙ
func bakery_state():
	if !VisitorManager.is_bakery_open:
		VisitorManager.open_bakery.emit()
		VisitorManager.is_bakery_open = true
		%open_close_bakery_button.text = "Закрыть пекарню"
	else:
		VisitorManager.close_bakery.emit()
		VisitorManager.is_bakery_open = false
		%open_close_bakery_button.text = "Открыть пекарню"

func check_bakery_state():
	if !VisitorManager.is_bakery_open:
		%open_close_bakery_button.text = "Открыть пекарню"
	else:
		%open_close_bakery_button.text = "Закрыть пекарню"
