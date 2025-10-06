extends Area3D

func _ready() -> void:
	#pass
	area_entered.connect(create_order)

func create_order(area: Area3D):
	VisitorManager.create_order.emit()
