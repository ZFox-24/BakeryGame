extends Node

@onready var current_scene : String = "res://materials/ground.tscn"
signal reload_game

func _ready() -> void:
	#reload_game.connect(load_scene)
	#SaveLoad.save_data.connect(save_last_scene)
	#SaveLoad.load_data.connect(load_last_scene)
	#load_scene()
	
	# временно для теста монитора
	# "res://test_monitor/node_3d.tscn"
	# "res://interior_models (blender)/computer.tscn"
	# "res://interior_models (blender)/bakery_monitor.tscn"
	get_tree().change_scene_to_file(current_scene)
	#Warehouse.load_items()

#func save_last_scene():
	#SaveLoad.save_file_data.data["scene_loaded"] = current_scene
	#print("Сцена сохранена")
#
#func load_last_scene():
	#if current_scene != null:
		#current_scene = SaveLoad.save_file_data.data["scene_loaded"]
		#get_tree().change_scene_to_file(current_scene)
		#get_tree().paused = false
		#SaveLoad.load_other_data.emit()
	#else:
		#get_tree().change_scene_to_file.call_deferred("res://materials/ground.tscn")
	#print("Сцена загружена")
#
#func load_scene():
	#get_tree().change_scene_to_file.call_deferred(SaveLoad.save_file_data.data["scene_loaded"])
	#SaveLoad.load_other_data.emit()
	#get_tree().paused = false
