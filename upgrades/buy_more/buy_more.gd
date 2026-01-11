extends Node

func _init():
	VisitorManager.max_items += 1
	print(VisitorManager.max_items)
