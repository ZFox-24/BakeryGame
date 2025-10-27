extends Control

@export var item : SaleItem

func _ready() -> void:
	await OrderManager.load_items
	%item_name_card.text = item.item_name
	%quantity_lbl.text = str(item.item_quantity)
	%add_button.pressed.connect(show_menu)
	%item_texture.texture = item.item_icon
	Warehouse.update_item.connect(update_item)

func show_menu():
	#Warehouse.item = item
	var menu = load("res://scenes/add_menu.tscn").instantiate()
	add_child(menu)
	Warehouse.transfer_item.emit(item)

func update_item():
	#item = Warehouse.item
	%quantity_lbl.text = str(item.item_quantity)
	#Warehouse.item = null
