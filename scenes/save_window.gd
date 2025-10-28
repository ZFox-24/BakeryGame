extends Panel

# всякие сигналы по типу "сохранение завершено", "появилось новое сохранение"

func _ready() -> void:
	%exit_button.pressed.connect(exit_window)
	# сигнал ожидания?
	for s in SavesManagement.available_saves:
		var save_slot = load("uid://3b2ncqvlbla6").instantiate()
		%saves_list.add_child(save_slot)

func exit_window():
	%AnimationPlayer.play_backwards("close_save_menu")
