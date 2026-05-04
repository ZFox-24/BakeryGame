extends Node

#@onready var current_scene : String = "res://materials/ground.tscn"
@onready var current_scene: String = "res://scenes/bakery_interior.tscn"

func _ready() -> void:
	get_tree().change_scene_to_file.call_deferred(current_scene)
