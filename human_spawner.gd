extends Node3D

func _ready() -> void:
	var human = load("uid://bhp2d1h17nly4").instantiate()
	add_child(human)
	human.set_global_position(Vector3(-2.4, 0.97, 0))
