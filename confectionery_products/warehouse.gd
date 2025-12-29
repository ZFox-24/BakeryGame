extends Node

func _ready():
	load_products()
	upgrades_loaded()
	
	SaveLoad.save_data.connect(save_items)
	SaveLoad.save_data.connect(save_upgrades)

# Предметы должны загружаться только когда открыто меню управления пекарней

signal transfer_item(tr_item: SaleItem)
signal update_item
signal update_item_card

signal update_upgrade
signal load_upgrades
signal loading_upgrades_finished
signal loading_items_finished
# signal products_loaded

# товары для загрузки
var products_array = ["res://confectionery_products/croissant.tres",
					"res://confectionery_products/baguette.tres",
					"res://confectionery_products/bun.tres",
					"res://confectionery_products/cake.tres",
					"res://confectionery_products/donut.tres",
					"res://confectionery_products/eclair.tres",
					"res://confectionery_products/macaroon.tres"]

var loaded_products : Array[SaleItem] = []

# улучшения для загрузки
var upgrades_array := ["res://upgrades/popularity/popularity.tres",
					"res://upgrades/buy_more/buy_more_upg.tres"]

var loaded_upgrades : Array[Upgrade] = []


func load_products():
	loaded_products.clear()
	if !SaveLoad.save_file_data.data["product_quantity"].is_empty():
		for i in SaveLoad.save_file_data.data["product_quantity"]:
			loaded_products.append(load(i))
	else:
		for i in products_array:
			loaded_products.append(load(i))
	loading_items_finished.emit()

func save_items():
	SaveLoad.save_file_data.data["product_quantity"].clear()
	var items_data = []
	for i in loaded_products:
		items_data.append({
			"resource_path": i.resource_path,
			"item_quantity": i.item_quantity
		})
	SaveLoad.save_file_data.data["product_quantity"] = items_data
	return

func load_items():
	loaded_products.clear()
	if !SaveLoad.save_file_data.data["product_quantity"].is_empty():
		for i in SaveLoad.save_file_data.data["product_quantity"]:
			var res = load(i["resource_path"])
			res.item_quantity = i["item_quantity"]
			loaded_products.append(res) # может, оставить i
	else:
		for i in products_array:
			loaded_products.append(load(i))
	loading_items_finished.emit()
	update_item.emit()

func save_upgrades():
	SaveLoad.save_file_data.data["bought_upgrades"].clear()
	var upgrades_data = []
	for i in loaded_upgrades:
		if i is Resource and i.resource_path != "":
			upgrades_data.append({
				"upgrade_path": i.resource_path,
				"upgrade_bought": i.upgrade_bought
			})
		else:
			push_error("Неверный тип элемента" + str(i))
	SaveLoad.save_file_data.data["bought_upgrades"] = upgrades_data

func upgrades_loaded():
	loaded_upgrades.clear()
	for i in upgrades_array:
		loaded_upgrades.append(load(i))
	loading_upgrades_finished.emit()
	update_upgrade.emit()
	#if !SaveLoad.save_file_data.data["bought_upgrades"].is_empty():
		#for i in SaveLoad.save_file_data.data["bought_upgrades"]:
			#var res = load(i["upgrade_path"])
			#res.upgrade_bought = i["upgrade_bought"]
			#loaded_upgrades.append(i)
	#else:
		#for i in upgrades_array:
			#loaded_upgrades.append(load(i))
	#loading_upgrades_finished.emit()
	#update_upgrade.emit()

func find_product_path(array: Array, resource_path: String):
	for i in array:
		if i and i.resource_path == resource_path:
			return i
	return null
