extends MeshInstance3D

func _ready() -> void:
	if OS.get_name() == "Windows":
			GameSettings.disable_shadows(get_tree().current_scene)
