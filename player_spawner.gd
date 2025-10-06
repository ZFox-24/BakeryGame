extends Node3D

func _ready() -> void:
	var player = load("res://scenes/human.tscn").instantiate()
	add_child(player)
