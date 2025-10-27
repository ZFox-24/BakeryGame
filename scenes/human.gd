extends Node3D

func _ready() -> void:
	VisitorManager.close_bakery.connect(to_exit)
	VisitorManager.order_complete.connect(to_exit)
	%AnimationPlayer.play("to_counter")

func despawn():
	VisitorManager.current_visitors -= 1
	queue_free()
	print("Чел освобожден")
	VisitorManager.spawn_visitor.emit()

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P):
		to_exit()

func to_exit():
	%AnimationPlayer.play("to_exit")
