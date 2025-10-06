extends Node3D

var time1 : int = 2
var time2: int
var is_inside : bool = false

func _ready() -> void:
	%Timer.timeout.connect(spawn_human)
	#human.set_global_position(Vector3(-0.005, 1.575,-2.446))

func spawn_human():
	if !is_inside:
		var human = load("res://scenes/human.tscn").instantiate()
		add_child(human)
	is_inside = true
