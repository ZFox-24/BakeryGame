extends Node

@onready var current_scene : String = "res://materials/ground.tscn"
#@onready var current_scene: String = "res://scenes/bakery_interior.tscn"

var main_scene: String = "res://materials/ground.tscn"
var interior_scene: String = "res://scenes/bakery_interior.tscn"

func _ready() -> void:
	if OS.get_name() == "Android":
		interior_scene = "res://scenes/bakery_interior_mobile.tscn"
		main_scene = "res://materials/ground_mobile.tscn"
	get_tree().change_scene_to_file.call_deferred(main_scene)
