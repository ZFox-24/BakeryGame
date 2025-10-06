extends Panel

@export var item : SaleItem

func _ready() -> void:
	item.item_quantity = randi_range(1, 8)
	%item_name.text = item.item_name
	%item_icon.texture = item.item_icon
	%item_quantity.text = str(item.item_quantity)
	%item_price.text = str(item.item_price)
	%final_price.text = str(roundi((item.item_price * item.item_quantity) * 1.05))
	%exit_button.pressed.connect(exit_menu)
	%sell_button.pressed.connect(sell_item)

func sell_item():
	Money.money += int(%final_price.text)
	Money.update_money.emit()
	exit_menu()

func exit_menu():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()
