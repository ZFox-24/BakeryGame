extends Resource
class_name save_data_resource

@export var scene_loaded = PackedScene

# в player обработка сигнала передачи данных сюда. Или вызвать этот скрипт
@export var player_position : Vector3

# применяться только после вызова сигнала
@export var products_quantity : Array

@export var player_money : int
@export var bought_upgrades : Array
@export var bakery_status : bool

@export var data = {
<<<<<<< HEAD
	"scene_loaded": "res://materials/ground.tscn",
	"player_position": [],
	"product_quantity": [], # надо подумать
	"player_money": 0,
	"bought_upgrades": [],
	"bakery_status": false
}

@export var empty_data = {
	"scene_loaded": "res://materials/ground.tscn",
=======
	"scene_loaded": "",
>>>>>>> 8de7062445f4cba91c07c0846043b40e238b92fe
	"player_position": [],
	"product_quantity": [], # надо подумать
	"player_money": 0,
	"bought_upgrades": [],
	"bakery_status": false
}
