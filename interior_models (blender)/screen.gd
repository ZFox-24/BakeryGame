extends StaticBody3D

func _ready() -> void:
	VisitorManager.create_order.connect(update_screen_price)

func interact():
	var monitor_screen = load("res://scenes/monitor_screen.tscn").instantiate()
	add_child(monitor_screen)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# отображение цен
func update_screen_price():
	$"../../Cube_014/price".text = str(OrderManager.order.final_price)
