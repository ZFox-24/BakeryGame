extends Panel

@export var slot: ProdSlot

func _ready():
	%item_name.text = slot.item.item_name
	%item_quantity.text = str(slot.amount)
	%item_price.text = str(slot.item.item_price)

# посетитель может взять максимально доступное количество товара в некоторых случаях, даже если его не хватает.
# если товара нет, его надо купить
