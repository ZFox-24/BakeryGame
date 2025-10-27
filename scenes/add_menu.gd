extends CanvasLayer

@onready var total_items := 0
@export var item : SaleItem # решить проблему

func _ready() -> void:
	%exit_button.pressed.connect(queue_free)
	%buy_button.pressed.connect(buy_item)
	Warehouse.transfer_item.connect(set_item)
	await Warehouse.transfer_item
	%num_field.text_changed.connect(_on_num_field_changed)
	%item_name.text = "Пополнить запасы: " + item.item_name#+ %item_name_card.text
	%num_field.text = str(total_items)
	%num_field.caret_column = %num_field.text.length()
	%more_button.pressed.connect(add_values)
	%less_button.pressed.connect(subtract_values)

func set_item(tr_item):
	item = tr_item

#func _process(delta: float) -> void:
	#total_items = int(%num_field.text)
	#%total_price_lbl.text = str(item.item_price * total_items)

func _on_num_field_changed(new_text : String):
	total_items = int(new_text)
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
		#Warehouse.item = item
		Warehouse.update_item.emit()
		Money.update_money.emit()
		queue_free()
