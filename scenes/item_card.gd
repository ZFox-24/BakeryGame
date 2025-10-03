extends Control

@export var item : SaleItem

func _ready() -> void:
	%item_name_card.text = item.item_name
	%add_button.pressed.connect(%add_menu.show)
  