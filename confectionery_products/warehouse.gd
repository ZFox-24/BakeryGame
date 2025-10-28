extends Node

# Предметы должны загружаться только когда открыто меню управления пекарней

signal transfer_item(tr_item: SaleItem)
signal update_item
signal update_item_card

signal load_upgrades
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
	if loaded_products.size() < array_item.size(): 
		for i in array_item:
			loaded_products.append(load(i))

func upgrades_loaded():
	if loaded_upgrades.size() < upgrades_list.size():
		for i in upgrades_list:
			loaded_upgrades.append(load(i))
