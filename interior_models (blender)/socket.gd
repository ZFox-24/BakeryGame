extends CSGCombiner3D

func _ready() -> void:
	if OS.get_name() == "Windows":
			GameSettings.disable_lights(get_tree().current_scene)
