extends TabBar

@export var order = OrderManager.order
var product : SaleItem

func _ready() -> void:
	if OrderManager.order_in_process and OrderManager.order != null:
		recieve_order()
		#VisitorManager.create_order.connect(recieve_order)
		%sell_button.pressed.connect(sell_item)
	else:
		$panel.hide()
		%nothin_to_sell_label.show()

func sell_item():
	check_products_intersection(Warehouse.loaded_products, order.products)
	VisitorManager.order_complete.emit()
	#var index = 0
	#for i in order.products:
		#for l in Warehouse.loaded_products:
			#if l.has(i):
				#print("ЗНАЧЕНИЯ МАССИВОВ ОДИНАКОВЫВЫЫЫ")
				#if i.item_quantity <= l.item_quantity:
					#print("L: " + l.item_name + " | " + str(l.item_quantity))
					#print("I: " + i.item_name + " | " + str(i.item_quantity))
					#VisitorManager.order_complete.emit()
		#index += 1
	#var temp_item = Warehouse.item.values()
	#for i in order.products:
		#var u = temp_item
		#u = i # приводит к тому, что кол-ва товаров равны. Изменить
		## может, создать дубликаты данных из словаря, чтобы оно не меняло значения оригинала?
		#if i.item_quantity <= u.item_quantity: # я че, сравниваю массив со словарем?
			#print("U: " + u.item_name + " | " + str(u.item_quantity))
			#VisitorManager.order_complete.emit()
			
			#else:
				#%AnimationPlayer.play("nei")

	for c in $ScrollContainer/VBoxContainer.get_children():
		c.queue_free()
		
	$panel.hide()
	%sell_button.hide()
	%nothin_to_sell_label.show()

	Money.money += order.final_price
	Money.update_money.emit()
	OrderManager.order_in_process = false
	$income_sound.play()

#func sell_item(): # второй вариант
	#var temp_item = Warehouse.array_item
	#for i in order.products:
		#for a in temp_item:
			#if a == i:
				##a = i # приводит к тому, что кол-ва товаров равны. Изменить
				## может, создать дубликаты данных из словаря, чтобы оно не меняло значения оригинала?
				#if i.item_quantity <= a.item_quantity: # я че, сравниваю массив со словарем?
					#print("U: " + a.item_name + " | " + str(a.item_quantity))
					#VisitorManager.order_complete.emit()
				#else:
					#%AnimationPlayer.play("nei")

func check_products_intersection(array1 : Array, array2 : Array):
	var arr2_dict = {}
	for v in array2:
		arr2_dict[v] = true
	var in_both_arrays = []
	for v in array1:
		if arr2_dict.get(v, false):
			in_both_arrays.append(v)
	return in_both_arrays

func recieve_order():
	for p in order.products:
		var sell_item_panel = load("res://scenes/sell_item_panel.tscn").instantiate()
		sell_item_panel.resource = p
		$ScrollContainer/VBoxContainer.add_child(sell_item_panel)
	# для каждого предмета в заказе добавлять sell_item_panel.tscn
	$panel.show()
	%nothin_to_sell_label.hide()
	await OrderManager.order_opened
	%final_price.text = str(OrderManager.order.final_price)
