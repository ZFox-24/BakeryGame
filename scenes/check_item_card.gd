extends GridContainer

@export var list: ProdInv

func _ready() -> void:
	list = SaveSystem.save_game.products_data
	fill_list()

func fill_list():
	if list != null:
		for i in list.slots:
			var item_card = load("uid://76pi48laytsu").instantiate()
			item_card.slot = i
			add_child(item_card)
		for f in 2:
			var fill = Panel.new()
			fill.custom_minimum_size = Vector2(0, 363)
			add_child(fill)
		#OrderManager.load_items.emit()
