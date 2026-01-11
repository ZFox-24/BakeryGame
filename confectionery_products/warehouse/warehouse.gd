extends Node

#@export var products: Inventory# = load("res://confectionery_products/products.tres")
#@export var upgrades: Inventory# = load("res://upgrades/upgrades.tres")

#func _ready():
	#products = load("res://confectionery_products/products.tres")
	#upgrades = load("res://upgrades/upgrades.tres")
# 	load_products()
	
const SAVE_PATH = "user://save.tres"

signal transfer_item(tr_item: SaleItem)
#signal transfer_products(tr_item: Inventory)
#signal transfer_upgrades(tr_item: Inventory)
signal update_item
signal update_item_card

signal update_upgrade
signal load_upgrades
signal loading_upgrades_finished
signal loading_items_finished
# signal products_loaded

#region старая система загрузки ресурсов
# товары для загрузки
var products_array = ["res://confectionery_products/croissant.tres",
					"res://confectionery_products/baguette.tres",
					"res://confectionery_products/bun.tres",
					"res://confectionery_products/cake.tres",
					"res://confectionery_products/donut.tres",
					"res://confectionery_products/eclair.tres",
					"res://confectionery_products/macaroon.tres"]

var loaded_products : Array = []

# улучшения для загрузки
var upgrades_array := ["res://upgrades/popularity/popularity.tres",
					"res://upgrades/buy_more/buy_more_upg.tres"]

var loaded_upgrades : Array = []
#endregion

func load_products():
	loaded_products.clear()
	for i in products_array:
		loaded_products.append(load(i))
	loading_items_finished.emit()

#func save_items(prods: Inventory, upgrs: Inventory):
	#var saved_data = load("res://scripts/save_data.gd")
	#var save_file = saved_data.new()
	#if products != null:
		#save_file.products_data = prods
	#if upgrades != null:
		#save_file.upgrades_data = upgrs
	#save_file.money_data = Moneyyy.Money
	#print("Сохранено: " + str(prods) + ", " +str(upgrs) + ", " + str(Moneyyy.Money.money))
	#ResourceSaver.save(save_file, SAVE_PATH)
#
#func load_items():
	#if FileAccess.file_exists(SAVE_PATH):
		#var saved_game = ResourceLoader.load(SAVE_PATH)
		#products = saved_game.products_data
		#upgrades = saved_game.upgrades_data
#
		##loaded_upgrades = []
		##loaded_products = []
		##loaded_products = saved_game.products_data.duplicate()
		##loaded_upgrades = saved_game.upgrades_data.duplicate()
		#Moneyyy.Money = saved_game.money_data #.duplicate()
		#Moneyyy.Money.update_money.emit()
		#loading_upgrades_finished.emit()
		#update_upgrade.emit()
		#print("СОХРАНЕНИЕ ЕСТЬ: загружаю сохранения и всякое прочее")
	#else:
		#products = load("res://confectionery_products/products.tres")
		#upgrades = load("res://upgrades/upgrades.tres")
		#print("загружаю сохранения и всякое прочее")
	#transfer_products.emit(products)
	#transfer_upgrades.emit(upgrades)
#
#
	## else:
	## 	load_products()
	## 	upgrades_loaded()
	## print(loaded_products)
	## print(loaded_upgrades)
	## print(Moneyyy.Money.money)
#
#func delete_items(prods: Inventory, upgrs: Inventory):
	#for i in prods.items:
		#i.item_quantity = 0
	#for u in upgrs.items:
		#u.upgrade_bought = false
	#Moneyyy.Money.money = 20000
	#Moneyyy.Money.update_money.emit()
	#save_items(products, upgrades)

func upgrades_loaded():
	loaded_upgrades.clear()
	for i in upgrades_array:
		loaded_upgrades.append(load(i))
	loading_upgrades_finished.emit()
	update_upgrade.emit()
