extends TabBar

@export var order : Order

func _ready() -> void:
	VisitorManager.create_order.connect(recieve_order)
	%sell_button.pressed.connect(sell_item)

func sell_item():
	VisitorManager.order_complete.emit()
	$Panel.hide()
	%sell_button.hide()
	%nothin_to_sell_label.show()

func recieve_order():
	# передача ресурса
	$Panel.show()
	%nothin_to_sell_label.hide()
