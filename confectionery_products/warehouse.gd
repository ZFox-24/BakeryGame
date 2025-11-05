extends Node

# Предметы должны загружаться только когда открыто меню управления пекарней

signal transfer_item(tr_item: SaleItem)
signal update_item
signal update_item_card

signal update_upgrade
signal load_upgrades
signal loading_upgrades_finished
signal loading_items_finished
# signal products_loaded

#var item : SaleItem
var item := {
	"croissant": preload("res://confectionery_products/croissant.tres"),
	"baguette": preload("res://confectionery_products/baguette.tres"),
	"bun": preload("res://confectionery_products/bun.tres"),
	"cake": preload("res://confectionery_products/cake.tres"),
	"donut": preload("res://confectionery_products/donut.tres"),
	"eclair": preload("res://confectionery_products/eclair.tres"),
	"macaroon": preload("res://confectionery_products/macaroon.tres")
}

var loaded_products := []
var array_item = ["res://confectionery_products/croissant.tres",
					"res://confectionery_products/baguette.tres",
					"res://confectionery_products/bun.tres",
					"res://confectionery_products/cake.tres",
					"res://confectionery_products/donut.tres",
					"res://confectionery_products/eclair.tres",
					"res://confectionery_products/macaroon.tres"]

var upgrades_list := ["res://upgrades/popularity/popularity.tres",
					"res://upgrades/buy_more/buy_more_upg.tres"]

var loaded_upgrades := []

func load_products():
	if !SaveLoad.save_file_data.data["product_quantity"].is_empty():
		for i in SaveLoad.save_file_data.data["product_quantity"]:
			loaded_products.append(load(i))
	else:
		if loaded_products.size() < array_item.size(): 
			for i in array_item:
				loaded_products.append(load(i))
	loading_items_finished.emit()

func _ready():
	SaveLoad.save_data.connect(save_items)
	SaveLoad.save_data.connect(save_upgrades)

func save_items():
	if VisitorManager.is_computer_open == true:
		SaveLoad.save_file_data.data["product_quantity"].clear()
		var items_data = []
		for i in loaded_products:
			items_data.append({
				"resource_path": i.resource_path,
				"item_quantity": i.item_quantity
			})
		SaveLoad.save_file_data.data["product_quantity"] = items_data

func load_items():
	loaded_products.clear()
	if !SaveLoad.save_file_data.data["product_quantity"].is_empty():
		for i in SaveLoad.save_file_data.data["product_quantity"]:
			var res = load(i["resource_path"])
			res.item_quantity = i["item_quantity"]
			loaded_products.append(i)
	else:
		if loaded_products.size() < array_item.size(): 
			for i in array_item:
				loaded_products.append(load(i))
	loading_items_finished.emit()
	update_item.emit()

func save_upgrades():
	SaveLoad.save_file_data.data["bought_upgrades"].clear()
	var upgrades_data = []
	for i in loaded_upgrades:
		upgrades_data.append({
			"upgrade_path": i.resource_path,
			"upgrade_bought": i.upgrade_bought
		})
	SaveLoad.save_file_data.data["bought_upgrades"] = upgrades_data

func upgrades_loaded():
	loaded_upgrades.clear()
	if !SaveLoad.save_file_data.data["bought_upgrades"].is_empty():
		for i in SaveLoad.save_file_data.data["bought_upgrades"]:
			var res = load(i["upgrade_path"])
			res.upgrade_bought = i["upgrade_bought"]
			loaded_upgrades.append(i)
	else:
		if loaded_upgrades.size() < upgrades_list.size(): 
			for i in upgrades_list:
				loaded_upgrades.append(load(i))
	loading_upgrades_finished.emit()
	update_upgrade.emit()
