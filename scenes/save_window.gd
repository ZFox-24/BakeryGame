extends Panel

func _ready() -> void:
	add_languages()
	%exit_button.pressed.connect(exit_window)
	%lng_select_butt.item_selected.connect(_on_lang_selected)
	$fullscreen_mode_chkbox.toggled.connect(window_mode)
	
	if get_window().get_mode() == Window.MODE_FULLSCREEN:
		$fullscreen_mode_chkbox.set_pressed_no_signal(true)

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

func window_mode(toggled_on: bool):
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
