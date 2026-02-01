extends Area3D

@export var location_path : String

func _on_body_entered(_body: Node3D) -> void:
	if location_path == "res://materials/ground.tscn" and VisitorManager.is_bakery_open:
		VisitorManager.bakery_opened_no_exit.emit()
	elif !VisitorManager.is_bakery_open:
		VisitorManager.is_lamp_on = false
		VisitorManager.change_lamp_state.emit()
		get_tree().call_deferred("change_scene_to_file", location_path)
		SceneManager.current_scene = location_path
