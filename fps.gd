extends Control

func _ready():
	if !OS.is_debug_build():
		queue_free()

func _process(_delta: float) -> void:
	%fps_num.text = str(Engine.get_frames_per_second())
