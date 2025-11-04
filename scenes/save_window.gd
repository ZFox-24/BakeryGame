extends Panel

# всякие сигналы по типу "сохранение завершено", "появилось новое сохранение"

func _ready() -> void:
	SavesManagement.create_save_menu_open.connect($add_panel.show)
	%exit_button.pressed.connect(exit_window)
	%operations_tab.tab_changed.connect(_on_tab_changed)
	# сигнал ожидания?
	#for s in SavesManagement.available_saves:
		#var save_slot = load("uid://3b2ncqvlbla6").instantiate()
		#%saves_list.add_child(save_slot)

func exit_window():
	%AnimationPlayer.play("close_save_menu")

func _on_tab_changed(tab : int):
	SavesManagement.file_operation_index = tab
