extends VBoxContainer

func _ready() -> void:
	await Warehouse.loading_upgrades_finished
	if !SaveLoad.save_file_data.data["bought_upgrades"].is_empty():
		for i in Warehouse.loaded_upgrades:
			var item = load(i["upgrade_path"])
			var upgrade_button = load("uid://7yj7tdeo2lhr").instantiate()
			add_child(upgrade_button)
			upgrade_button.upgrade = item
			upgrade_button.upgrade.upgrade_bought = i["upgrade_bought"] # почему мне нужно прописывать
																	# доп.свойство, если у ресурсов с
																	# товарами это не нужно?
	else:
		for i in Warehouse.upgrades_list:
			i = load(i)
			var upgrade_button = load("uid://7yj7tdeo2lhr").instantiate()
			add_child(upgrade_button)
			upgrade_button.upgrade = i
	Warehouse.load_upgrades.emit()
