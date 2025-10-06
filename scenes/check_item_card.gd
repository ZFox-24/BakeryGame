extends GridContainer

func _ready() -> void:
	Warehouse.update_item.connect(check_item)

func check_item():
	for i in get_children():
		if i.has_method("item"):
			var item = i.item.item_name
			if item == Warehouse.item.item_name:
				Warehouse.update_item_card.emit()
					
