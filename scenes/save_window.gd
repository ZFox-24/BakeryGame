extends Panel

func _ready() -> void:
	if OS.get_name() == "Android":
		%fullscreen_mode_chkbox.queue_free()
	add_languages()
	%exit_button.pressed.connect(exit_window)
	%lng_select_butt.item_selected.connect(_on_lang_selected)
	%fullscreen_mode_chkbox.toggled.connect(window_mode)
	%antialiasing_chkbox.toggled.connect(antialiasing_mode)
	
	if ConfigFileHandler.load_video_settings().fullscreen:
		%fullscreen_mode_chkbox.set_pressed_no_signal(true)
	
	if ConfigFileHandler.load_video_settings().anti_aliasing:
		%antialiasing_chkbox.set_pressed_no_signal(true)
	
	
	##
	var video_sett = ConfigFileHandler.load_video_settings()
	var misc_sett = ConfigFileHandler.load_misc_setting()
	#%lighting_slider.value = 0 #TODO: заменить настройку на два чек-бокса
	%shadows_slider.value = video_sett.shadows
	%textures_slider.value = video_sett.textures
	%sensitivity_slider.value = misc_sett.sensitivity
	%sens_num.text = str(misc_sett.sensitivity)
	
	# Число для слайдеров
		
	%sensitivity_slider.value_changed.connect(func(value: float): %sens_num.text = str(value))
	
	%sensitivity_slider.drag_ended.connect(func(value: bool): save_slider_value(1, "sensitivity", %sensitivity_slider.value))
	#%lighting_slider.drag_ended.connect(func(value: bool): save_slider_value(0, "lighting", %lighting_slider.value))
	%shadows_slider.drag_ended.connect(func(value: bool):
		save_slider_value(0, "shadows", %shadows_slider.value)
		GameSettings.change_shadows_setting(%shadows_slider.value))
	%textures_slider.drag_ended.connect(func(value: bool): save_slider_value(0, "textures", %textures_slider.value))
	
	select_language_on_start()
	
	#%lng_select_butt.select(func() -> int:
		#%lng_select_butt.items)

func exit_window():
	%AnimationPlayer.play("close_save_menu")

func _on_lang_selected(index: int):
	var ID = %lng_select_butt.get_item_text(index)
	TranslationServer.set_locale(GameSettings.language[ID])
	GameSettings.current_language = TranslationServer.get_locale()
	ConfigFileHandler.save_misc_setting("language", GameSettings.current_language)
	ConfigFileHandler.save_misc_setting("languageID", index)

func add_languages():
	var current_lang = TranslationServer.get_locale()
	var ID = 0
	for language in GameSettings.language:
		%lng_select_butt.add_item(language, ID)
		if GameSettings.language[language] == current_lang:
			%lng_select_butt.select(ID)
			ID += 1

func select_language_on_start():
	var lang_sett = ConfigFileHandler.load_misc_setting()
	%lng_select_butt.select(int(lang_sett.languageID))

func window_mode(toggled_on: bool):
	ConfigFileHandler.save_video_setting("fullscreen", toggled_on)
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)

func antialiasing_mode(toggled_on: bool):
	ConfigFileHandler.save_video_setting("anti_aliasing", toggled_on)
	if toggled_on:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_SMAA
		get_viewport().msaa_3d = Viewport.MSAA_4X
	else:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_DISABLED


func save_slider_value(category: int, key_word: String, value: float):
	match category:
		0: ConfigFileHandler.save_video_setting(key_word, value)
		1: ConfigFileHandler.save_misc_setting(key_word, value)
	print("saved: " + key_word + " - " + str(value))
	return true
