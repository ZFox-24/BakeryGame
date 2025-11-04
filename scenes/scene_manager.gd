extends Node

@onready var current_scene : String = "res://materials/ground.tscn"
<<<<<<< HEAD
signal reload_game

func _ready() -> void:
	reload_game.connect(load_scene)
	SaveLoad.save_data.connect(save_last_scene)
	SaveLoad.load_data.connect(load_last_scene)
	load_scene()
=======

func _ready() -> void:
	if FileAccess.file_exists(SaveManagerLite.save_path):
		SaveManagerLite.load_game()
	SaveLoad.save_file_data.data["scene_loaded"] = current_scene
	SaveLoad.save_data.connect(save_last_scene)
	SaveLoad.load_data.connect(load_scene)
	load_scene()
	#SaveLoad.load_data.connect(load_last_scene)
	#load_last_scene()
>>>>>>> 8de7062445f4cba91c07c0846043b40e238b92fe

func save_last_scene():
	SaveLoad.save_file_data.data["scene_loaded"] = current_scene
	print("Сцена сохранена")

func load_last_scene():
	if current_scene != null:
		current_scene = SaveLoad.save_file_data.data["scene_loaded"]
		get_tree().change_scene_to_file(current_scene)
		get_tree().paused = false
		SaveLoad.load_other_data.emit()
	else:
		get_tree().change_scene_to_file.call_deferred("res://materials/ground.tscn")
	print("Сцена загружена")
<<<<<<< HEAD
=======
# надо разобраться с загрузкой главной сцены при первом запуске игры
>>>>>>> 8de7062445f4cba91c07c0846043b40e238b92fe

func load_scene():
	get_tree().change_scene_to_file.call_deferred(SaveLoad.save_file_data.data["scene_loaded"])
	SaveLoad.load_other_data.emit()
	get_tree().paused = false
<<<<<<< HEAD
=======
	
>>>>>>> 8de7062445f4cba91c07c0846043b40e238b92fe
