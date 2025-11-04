extends Node

func _ready() -> void:
	if get_tree().current_scene.scene_file_path == SaveLoad.save_file_data.data["scene_loaded"]:
		get_parent().load_player_pos()
