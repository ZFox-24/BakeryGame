extends StaticBody3D

func _ready() -> void:
	pass

func interact():
	var monitor_screen = load("res://scenes/monitor_screen.tscn").instantiate()
	add_child(monitor_screen)
