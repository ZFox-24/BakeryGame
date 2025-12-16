#extends Area3D
extends StaticBody3D

func interact():
	var monitor_screen = load("res://scenes/monitor_screen.tscn").instantiate()
	add_child(monitor_screen)
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
