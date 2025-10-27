class_name Order extends Resource

@export var products : Array[SaleItem] = []

var final_price := 0

func calc_finprice():
	await OrderManager.order_opened
	for p in products:
		final_price += p.item_price * p.item_quantity
	final_price *= 1.1
	print("final_price:" + str(final_price))

func _init() -> void:
	calc_finprice()

# Когда приходит посетитель, он должен добавлять в синглтон заказ
# Заказ должен передасться в интерфейс взаимодействия при открытии интерфейса пекарни
# Заказ должен генерироваться из рандомного набора товаров и его рандомного кол-ва
# Заказ должен с определенной вероятностью добавить 2 товара, если надо
# Должны создаваться кнопки под каждый товар. Для этого придется итерировать products
# При выполнении заказа он должен удаляться, а состояние в интерфейсе обновляться
