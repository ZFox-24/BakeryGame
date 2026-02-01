extends TabBar

@export var order = OrderManager.order
@export var list: ProdInv

func _ready() -> void:
	list = SaveSystem.save_game.products_data
	if OrderManager.order_in_process and OrderManager.order != null:
		receive_order()
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
		for w_item in list.slots:
			if w_item.item.item_name == oi.item.item_name:
				item = w_item
				break

		# проверка кол-ва
		if item == null:
			missing_items.append({
				"name": oi.item.item_name,
				"diff": oi.item_quantity
			})
		elif item.amount < oi.amount:
			var diff = oi.amount - item.amount
			missing_items.append({
				"name": oi.item.item_name,
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
			for w_item in list.slots:
				if w_item in list.slots:
					if w_item.item.item_name == oi.item.item_name:
						w_item.amount -= oi.amount
						break
	
		for c in $ScrollContainer/VBoxContainer.get_children():
			c.queue_free()
		
		$panel.hide()
		%sell_button.hide()
		%nothin_to_sell_label.show()
		Warehouse.update_item.emit()
		VisitorManager.order_complete.emit()
		Money.calculate_money(order.final_price)
		Money.money_changed.emit()
		SaveSystem.save()
		OrderManager.order_in_process = false
		$income_sound.play()

#для очистки nrts
func clear_nrts():
	for c in %nei_vbox.get_children():
		c.queue_free()

func receive_order():
	for p in order.products:
		var sell_item_panel = load("res://scenes/sell_item_panel.tscn").instantiate()
		sell_item_panel.slot = p
		$ScrollContainer/VBoxContainer.add_child(sell_item_panel)
	# для каждого предмета в заказе добавлять sell_item_panel.tscn
	$panel.show()
	%nothin_to_sell_label.hide()
	await OrderManager.order_opened
	%final_price.text = str(OrderManager.order.final_price)
