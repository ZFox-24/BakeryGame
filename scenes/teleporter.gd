extends Area3D

@export var location_path : String

func _on_body_entered(body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file", location_path)
