extends Node

var SAVE_GAME_PATH = set_save_path() # увы, с методом использовать const не выйдет

var save_game : SaveData = null

func _ready() -> void:
	set_save_path()
	load_game()

static func set_save_path() -> String:
	var extension = ".tres" if OS.is_debug_build() else ".res"
	return "user://save" + extension

func load_game():
	if ResourceLoader.exists(SAVE_GAME_PATH):
		save_game = ResourceLoader.load(SAVE_GAME_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		create_new_save()

func save():
	var err_code := ResourceSaver.save(save_game, SAVE_GAME_PATH)
	if err_code != OK:
		push_error("Not able to save: " + error_string(err_code))

func create_new_save():
	save_game = SaveData.new()
	save_game.products_data = new_inventory()
	save_game.upgrades_data = new_upgrades()
	save_game.money_resource = MoneyResource.new()
	save_game.money_resource.money = 200
	save()
	if Money.money_resource != null:
		Money.money_resource.emit_changed()

func new_inventory() -> ProdInv:
	var new_inv = ProdInv.new()
	new_inv = load("res://inventory/products.tres").duplicate()
	return new_inv

func new_upgrades() -> UpgInv:
	var new_upg = UpgInv.new()
	new_upg = load("res://inventory/upgrades.tres").duplicate()
	return new_upg
