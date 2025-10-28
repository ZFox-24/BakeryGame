extends CanvasLayer

func _process(delta: float) -> void:
	%fps_num.text = str(Engine.get_frames_per_second())
