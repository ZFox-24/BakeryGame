extends Area3D

@onready var list = SaveSystem.save_game.products_data

func _ready() -> void:
	area_entered.connect(create_order)
	area_exited.connect(delete_order)

func create_order(_area: Area3D):
	OrderManager.order_in_process = true
	make_order_res()
	await make_order_res()
	VisitorManager.create_order.emit()

func delete_order(_area: Area3D):
	OrderManager.order_in_process = false
	VisitorManager.order_complete.emit()

func make_order_res(): # создает ресурс заказа для использования в OrderManager
	#var item_dict = Warehouse.item
	var slots_array: Array[ProdSlot] = []
	for i in list.slots:
		slots_array.append(i)
	var order = Order.new()
	var rannum = randf()
	
	var available_slots = slots_array #item_dict.keys()
	available_slots.shuffle()
	var slots_added = 0
	for key in available_slots:
		if slots_added >= VisitorManager.max_items:
			break
		var slot = key.duplicate()
		order.products.append(slot)
		slots_added += 1
		match(slot.item.item_name):
			"TEXT_CAKE":
				slot.amount = randi_range(1, 2)
			"TEXT_MACARON":
				slot.amount = randi_range(6, 24)
			_:
				slot.amount = randi_range(1, 8)
		if rannum > 0.4:
			break
	OrderManager.order = order
	#for i in order.products:
		#print("product: " + str(i) + "\n" +
				#"product_name: " + i.item_name)
