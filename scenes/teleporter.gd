extends Area3D

@export var location := PackedScene

func _on_body_entered(body: Node3D) -> void:
	print("AAA")
	var location = self.location
	get_tree().change_scene_to_packed(location)
