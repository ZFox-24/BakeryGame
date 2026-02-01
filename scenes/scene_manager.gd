extends Node

@onready var current_scene : String = "res://materials/ground.tscn"

func _ready() -> void:
	get_tree().change_scene_to_file.call_deferred(current_scene)
