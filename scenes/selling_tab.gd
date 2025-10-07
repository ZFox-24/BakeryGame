extends TabBar

@export var order : Order
var product : SaleItem
var order_item_quantity := randi_range(1, 2)

func _ready() -> void:
	if OrderManager.order_in_process:
		recieve_order()
		#VisitorManager.create_order.connect(recieve_order)
		%sell_button.pressed.connect(sell_item)
	else:
		$Panel.hide()
		%sell_button.hide()
		%nothin_to_sell_label.show()

func sell_item():
	if product.item_quantity >= order_item_quantity:
		VisitorManager.order_complete.emit()
		$Panel.hide()
		%sell_button.hide()
		%nothin_to_sell_label.show()
		Money.money += roundi((product.item_price * order_item_quantity) * 1.05)
		Money.update_money.emit()
		OrderManager.order_in_process = false
	else:
		%AnimationPlayer.play("nei")

func recieve_order():
	product = order.products.pick_random()
	var final_price : int = roundi((product.item_price * order_item_quantity) * 1.05)
	%item_name.text = product.item_name
	%item_price.text = str(product.item_price)
	%item_quantity.text = str(order_item_quantity)
	%final_price.text = str(final_price)
	$Panel.show()
	%nothin_to_sell_label.hide()
