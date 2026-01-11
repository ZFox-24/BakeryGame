extends Label

func _ready() -> void:
	text = str(Money.money_resource.money)
	Money.money_changed.connect(func(): text = str(Money.money_resource.money))
