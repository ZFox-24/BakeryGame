extends Node3D

func _ready() -> void:
	%AnimationPlayer.play("to_counter")

func despawn():
	if get_parent().has_method("is_inside"):
		get_parent().is_inside = false
		queue_free()

#func _physics_process(delta: float) -> void:
	#if Input.is_key_pressed(KEY_P):
		#%AnimationPlayer.play("to_exit")
