extends Node3D

func _ready() -> void:
	VisitorManager.open_bakery.connect($bakery_ambient.play)
	VisitorManager.close_bakery.connect($bakery_ambient.stop)
