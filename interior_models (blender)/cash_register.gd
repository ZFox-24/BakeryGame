extends Node3D

func _ready() -> void:
	VisitorManager.create_order.connect(update_screen_price)
	VisitorManager.order_complete.connect(reset_screen_price)

# отображение цен
func update_screen_price():
	await OrderManager.order.calc_finprice()
	%price.text = str(OrderManager.order.final_price)

func reset_screen_price():
	%price.text = str(0)
