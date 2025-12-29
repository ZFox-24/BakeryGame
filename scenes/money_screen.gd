extends Label

func _ready() -> void:
	text = str(Moneyyy.Money.money)
	Moneyyy.Money.update_money.connect(update_money_value)

func update_money_value():
	text = str(Moneyyy.Money.money)
	queue_redraw()
