extends Node

func _init() -> void:
	print("time1: " + str(VisitorManager.time1) + "time2: " + str(VisitorManager.time2))
	VisitorManager.time1 *= 0.85
	VisitorManager.time2 *= 0.85
	print("time1: " + str(VisitorManager.time1) + "time2: " + str(VisitorManager.time2))
