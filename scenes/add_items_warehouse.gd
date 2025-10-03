extends TabBar

@export var items : Array[SaleItem]

func _ready() -> void:
	items = $warehouse_management.items as Array
	print(items)
	#add_items()

func add_items():
	for i in items:
		var item_card = load("uid://76pi48laytsu").instantiate()
		get_node("TabContainer/Пополнение запасов/ScrollContainer/GridContainer/GridContainer").add_child(item_card)
		item_card.item = i
