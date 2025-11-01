extends Node

signal update_money
@onready var money := 999999

func _ready() -> void:
	SaveLoad.save_data.connect(save_money)
	SaveLoad.load_data.connect(load_money)

func save_money():
	SaveLoad.save_file_data.player_money = money
	SaveLoad._save()

func load_money():
	SaveLoad._load()
	money = SaveLoad.save_file_data.player_money
	update_money.emit()
