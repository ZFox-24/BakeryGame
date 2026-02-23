extends Panel

func _ready() -> void:
	if OS.get_name() == "Android":
		%sensitivity_settings.queue_free()
		%fullscreen_mode_chkbox.queue_free()
	add_languages()
	%exit_button.pressed.connect(exit_window)
	%lng_select_butt.item_selected.connect(_on_lang_selected)
	%fullscreen_mode_chkbox.toggled.connect(window_mode)
	
	if ConfigFileHandler.load_video_settings().fullscreen:
		%fullscreen_mode_chkbox.set_pressed_no_signal(true)
	
	select_language_on_start()
	
	#%lng_select_butt.select(func() -> int:
		#%lng_select_butt.items)

func exit_window():
	%AnimationPlayer.play("close_save_menu")

func _on_lang_selected(index: int):
	var ID = %lng_select_butt.get_item_text(index)
	TranslationServer.set_locale(GameSettings.language[ID])
	GameSettings.current_language = TranslationServer.get_locale()
	ConfigFileHandler.save_language_setting("language", GameSettings.current_language)
	ConfigFileHandler.save_language_setting("languageID", index)

func add_languages():
	var current_lang = TranslationServer.get_locale()
	var ID = 0
	for language in GameSettings.language:
		%lng_select_butt.add_item(language, ID)
		if GameSettings.language[language] == current_lang:
			%lng_select_butt.select(ID)
			ID += 1

func select_language_on_start():
	var lang_sett = ConfigFileHandler.load_language_setting()
	%lng_select_butt.select(int(lang_sett.languageID))

func window_mode(toggled_on: bool):
	ConfigFileHandler.save_video_setting("fullscreen", toggled_on)
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
