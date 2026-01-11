extends Control

@export var slot: ProdSlot

func _ready() -> void:
	%add_button.pressed.connect(edit_amount)
	update_slot()

func edit_amount():
	var edit_win = load("res://scenes/add_menu.tscn").instantiate()
	edit_win.slot = slot
	add_child(edit_win)
	if !edit_win.slot.changed.has_connections():
		edit_win.slot.changed.connect(func(): %quantity_lbl.text = str(slot.amount))

func update_slot():
	%item_name_card.text = slot.item.item_name
	%quantity_lbl.text = str(slot.amount)
	%item_texture.texture = slot.item.item_icon
