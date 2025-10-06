extends Label

func _ready() -> void:
	text = str(Money.money)
	Money.update_money.connect(update_money_value)

func update_money_value():
	text = str(Money.money)
	queue_redraw()
