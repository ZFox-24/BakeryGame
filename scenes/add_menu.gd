extends CanvasLayer

@onready var total_items := 0
@export var slot: ProdSlot

@onready var regex = RegEx.new()
func _ready() -> void:
	%item_name.text = tr("TITLE_REFILL") + tr(slot.item.item_name)
	%num_field.text = str(total_items)
	
	regex.compile("[^0-9]")
	%num_field.caret_column = %num_field.text.length()
	%num_field.text_changed.connect(_on_num_field_changed)
	
	%buy_button.pressed.connect(buy_item)
	%exit_button.pressed.connect(queue_free)

func _on_num_field_changed(new_text : String):
	var text = %num_field.text
	text = regex.sub(text, "", true)
	%num_field.set_text(text)
	%num_field.caret_column = len(text)
	total_items = int(new_text)
	%total_price_lbl.text = str(slot.item.item_price * total_items)

func buy_item():
	if Money.money_resource.money < slot.item.item_price * total_items:
		%AnimationPlayer.play("not_enough")
	else:
		Money.calculate_money(-slot.item.item_price * total_items)
		slot.amount += total_items
		slot.emit_changed()
		Money.money_changed.emit()
		SaveSystem.save()
		queue_free()
