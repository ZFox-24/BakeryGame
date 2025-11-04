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
	"scene_loaded": "",
	"player_position": [],
	"product_quantity": [], # надо подумать
	"player_money": 0,
	"bought_upgrades": [],
	"bakery_status": false
}
