extends Panel

@export var resource := SaleItem.new()

func _ready():
	%item_name.text = resource.item_name
	%item_quantity.text = str(resource.item_quantity)
	%item_price.text = str(resource.item_price)

# посетитель может взять максимально доступное количество товара в некоторых случаях, даже если его не хватает.
# если товара нет, его надо купить
