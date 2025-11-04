extends VBoxContainer

func _ready() -> void:
	await Warehouse.upgrades_loaded()
	for u in Warehouse.loaded_upgrades:
		var upgrade_button = load("uid://7yj7tdeo2lhr").instantiate()
		add_child(upgrade_button)
		upgrade_button.upgrade = u
		Warehouse.load_upgrades.emit()
