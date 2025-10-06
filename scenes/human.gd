extends Node3D

func _ready() -> void:
	%AnimationPlayer.play("to_counter")

func despawn():
	VisitorManager.current_visitors -= 1
	queue_free()
	print("Чел освобожден")
	VisitorManager.spawn_visitor.emit()
	#else: printerr("Нет родителя")

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_P):
		%AnimationPlayer.play("to_exit")
