class_name money extends Resource

@export var money := 999999
signal update_money

#func _ready() -> void:
	#SaveLoad.save_data.connect(save_money)
	#SaveLoad.load_other_data.connect(load_money)
#
#func save_money():
	#SaveLoad.save_file_data.data["player_money"] = money
	#SaveLoad.save_game.emit()
#
#func load_money():
	#money = SaveLoad.save_file_data.data["player_money"]
	#update_money.emit()
