extends CanvasLayer

@onready var total_items := 0
@export var item = Warehouse.item # решить проблему

func _ready() -> void:
	%item_name.text = "Пополнить запасы: " + item.item_name#+ %item_name_card.text
	%num_field.text = str(total_items)
	%num_field.caret_column = %num_field.text.length()
	%exit_button.pressed.connect(queue_free)
	%more_button.pressed.connect(add_values)
	%less_button.pressed.connect(subtract_values)
	%buy_button.pressed.connect(buy_item)
	
func _process(delta: float) -> void:
	total_items = int(%num_field.text)
	%total_price_lbl.text = str(item.item_price * total_items)

func add_values():
	total_items += 1

func subtract_values():
	total_items -= 1

func buy_item():
	if Money.money < item.item_price * total_items:
		%AnimationPlayer.play("not_enough")
	else:
		Money.money -= item.item_price * total_items
		item.item_quantity += total_items
		Warehouse.item = item
		Warehouse.update_item.emit()
		Money.update_money.emit()
		queue_free()
