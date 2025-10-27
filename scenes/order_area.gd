extends Area3D

func _ready() -> void:
	area_entered.connect(create_order)
	area_exited.connect(delete_order)

func create_order(area: Area3D):
	OrderManager.order_in_process = true
	make_order_res()
	VisitorManager.create_order.emit()

func delete_order(area: Area3D):
	OrderManager.order_in_process = false
	VisitorManager.order_complete.emit()

func make_order_res(): # создает ресурс заказа для использования в OrderManager
	var item_dict = Warehouse.item
	var order = Order.new()
	var rannum = randf()
	
	var available_items = item_dict.keys()
	available_items.shuffle()
	var items_added = 0
	for key in available_items:
		if items_added >= VisitorManager.max_items:
			break
		var item = item_dict[key].duplicate()
		order.products.append(item)
		items_added += 1
		match(item.item_name):
			"Торт":
				item.item_quantity = randi_range(1, 2)
			"Макарун":
				item.item_quantity = randi_range(6, 24)
			_:
				item.item_quantity = randi_range(1, 8)
		if rannum > 0.4:
			break
	OrderManager.order = order
