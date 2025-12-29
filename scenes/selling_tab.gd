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
	var missing_items = [] # эти твари для продажи не годны
	
	for oi in order.products:
		var item = null
		
		# молись, чтоб ты искал именно то, че надо
		for w_item in Warehouse.loaded_products:
			if w_item.item_name == oi.item_name:
				item = w_item
				break

		# проверка кол-ва
		if item == null:
			missing_items.append({
				"name": oi.item_name,
				"diff": oi.item_quantity
			})
		elif item.item_quantity < oi.item_quantity:
			var diff = oi.item_quantity - item.item_quantity
			missing_items.append({
				"name": oi.item_name,
				"diff": diff
			})
			
	if missing_items.size() > 0:
		%AnimationPlayer.play("nei")
		
		for c in %nei_vbox.get_children():
			c.queue_free()
		
		for e in missing_items:
			var l = Label.new()
			%nei_vbox.add_child(l)
			l.text = "- " + tr(e.name) + tr("TEXT_INTHEAMOUNT") + str(e.diff) + tr("TEXT_ITEMS")
	else:
		for oi in order.products:
			for w_item in Warehouse.loaded_products:
				if w_item in Warehouse.loaded_products:
					if w_item.item_name == oi.item_name:
						w_item.item_quantity -= oi.item_quantity
						break
	
		for c in $ScrollContainer/VBoxContainer.get_children():
			c.queue_free()
		
		$panel.hide()
		%sell_button.hide()
		%nothin_to_sell_label.show()
		Warehouse.update_item.emit()
		VisitorManager.order_complete.emit()
		Moneyyy.Money.money += order.final_price
		Moneyyy.Money.update_money.emit()
		ResourceSaver.save(Moneyyy.Money)
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
