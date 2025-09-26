extends Node3D

func _ready() -> void:
	var player = load("res://scenes/player/player.tscn").instantiate()
	add_child(player)
