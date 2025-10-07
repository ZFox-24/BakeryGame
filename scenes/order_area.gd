extends Area3D

func _ready() -> void:
	area_entered.connect(create_order)
	area_exited.connect(delete_order)

func create_order(area: Area3D):
	OrderManager.order_in_process = true
	VisitorManager.create_order.emit()

func delete_order(area: Area3D): # в принципе, а зачем этот метод?
	OrderManager.order_in_process = false
	VisitorManager.order_complete.emit()
