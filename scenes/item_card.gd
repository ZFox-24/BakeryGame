extends Control

@export var item : SaleItem

func _ready() -> void:
	%item_name_card.text = item.item_name
	%quantity_lbl.text = str(item.item_quantity)
	%add_button.pressed.connect(show_menu)
	Warehouse.update_item.connect(update_item)

func show_menu():
	Warehouse.item = item
	var menu = load("res://scenes/add_menu.tscn").instantiate()
	add_child(menu)

func update_item():
	#item = Warehouse.item
	%quantity_lbl.text = str(item.item_quantity)
	#Warehouse.item = null
