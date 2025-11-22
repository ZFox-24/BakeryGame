extends Panel

# всякие сигналы по типу "сохранение завершено", "появилось новое сохранение"

func _ready() -> void:
	add_languages()
	%exit_button.pressed.connect(exit_window)
	%lng_select_butt.item_selected.connect(_on_lang_selected)
	# сигнал ожидания?
	#for s in SavesManagement.available_saves:
		#var save_slot = load("uid://3b2ncqvlbla6").instantiate()
		#%saves_list.add_child(save_slot)

func exit_window():
	%AnimationPlayer.play("close_save_menu")

func _on_lang_selected(index: int):
	var ID = %lng_select_butt.get_item_text(index)
	TranslationServer.set_locale(GameSettings.language[ID])
	GameSettings.current_language = TranslationServer.get_locale()

func add_languages():
	var current_lang = TranslationServer.get_locale()
	var ID = 0
	for language in GameSettings.language:
		%lng_select_butt.add_item(language, ID)
		if GameSettings.language[language] == current_lang:
			%lng_select_butt.select(ID)
			ID += 1
