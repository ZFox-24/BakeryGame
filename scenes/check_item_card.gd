extends GridContainer

func _ready() -> void:
	fill_list()
	#Warehouse.update_item.connect(check_item)

#func check_item():
	#for i in get_children():
		#if i.has_method("item"):
			#var item = i.item.item_name
			#if item == Warehouse.item.item_name:
				#Warehouse.update_item_card.emit()
					#

func fill_list():
	await Warehouse.products_loaded
	#for i in Warehouse.item.values(): # если со словаря поменяется на массив - переделать
	for i in Warehouse.loaded_products:
		var item_card = load("uid://76pi48laytsu").instantiate()
		add_child(item_card)
		item_card.item = i
		OrderManager.load_items.emit()
	for f in 2:
		var fill = Panel.new()
		fill.custom_minimum_size = Vector2(0, 363)
		add_child(fill)
