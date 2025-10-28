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
	var rts_item := []
	var nrts_items := []
	for i in order.products:
		var index = order.products.find(i,0)
		var item = Warehouse.loaded_products.get(index)
		if i.item_quantity <= item.item_quantity:
			rts_item.append(i)
			print("кол-во соответствует")
			#Money.money -= roundi((i.item_price * i.item_quantity) * 1.1) # переделать на order.final_price
			# после добавления дополнительной проверки, указанной снизу
			index += 1
		else:
			if !nrts_items.has(i):
				nrts_items.append(i)
		#else: 
			#%AnimationPlayer.play("nei")
			#print("кол-во НЕ соответствует")
			### Тут снимают деньги и проигрывают анимацию дважды, так быть не должно
			## Добавить дополнительную проверку
			## Добавить каждый элемент в массив для продажи. Если предметов в массиве столько же,
			## сколько в заказе - только тогда выполнять продажу товаров
	if rts_item.size() < order.products.size():
		%AnimationPlayer.play("nei")
		for i in nrts_items:
			var l = Label.new()
			%nei_vbox.add_child(l)
			var index = order.products.find(i,0)
			var item = Warehouse.loaded_products.get(index)
			l.text = "- " + i.item_name + " в количестве " + str(i.item_quantity - item.item_quantity) + " шт."
		print("кол-во НЕ соответствует")
	else:
		for i in order.products:
			var index = order.products.find(i,0)
			var item = Warehouse.loaded_products.get(index)
			item.item_quantity -= i.item_quantity
		Warehouse.update_item.emit()
		nrts_items.clear()
		for c in $ScrollContainer/VBoxContainer.get_children():
			c.queue_free()
		
		$panel.hide()
		%sell_button.hide()
		%nothin_to_sell_label.show()
		VisitorManager.order_complete.emit()
		Money.money += order.final_price
		Money.update_money.emit()
		OrderManager.order_in_process = false
		$income_sound.play()

#для очистки nrts
func clear_nrts():
	for c in %nei_vbox.get_children():
		c.queue_free()

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
