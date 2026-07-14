extends Area3D

@export var location_path : String

func _ready() -> void:
	body_entered.connect(teleport)

func teleport(_body: Node3D) -> void:
	if location_path == "res://materials/ground.tscn" and VisitorManager.is_bakery_open:
		VisitorManager.bakery_opened_no_exit.emit()
	elif !VisitorManager.is_bakery_open:
		VisitorManager.is_lamp_on = false
		VisitorManager.change_lamp_state.emit()
		get_tree().call_deferred("change_scene_to_file", location_path)
		SceneManager.current_scene = location_path
	
	if location_path == "res://scenes/bakery_interior.tscn" and OS.get_name() == "Android":
		location_path = "res://scenes/bakery_interior_mobile.tscn"
		get_tree().call_deferred("change_scene_to_file", location_path)
	if location_path == "res://materials/ground.tscn" and OS.get_name() == "Android":
		location_path = "res://materials/ground_mobile.tscn"
		get_tree().call_deferred("change_scene_to_file", location_path)
