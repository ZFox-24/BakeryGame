extends VBoxContainer

@export var list: UpgInv #нужно, чтобы тут обязательно были апгрейды
#signal set_item_finished

func _ready() -> void:
	list = SaveSystem.save_game.upgrades_data
	load_upgrades()

func load_upgrades():
	for i in list.slots:
		var upgrade_button = load("uid://7yj7tdeo2lhr").instantiate()
		upgrade_button.slot = i
		add_child(upgrade_button)
	#Warehouse.load_upgrades.emit()
