extends Node

signal change_window_mode
signal change_language

signal show_mobile_buttons
signal hide_mobile_buttons

@onready var language := {
	"Русский": "ru",
	"English": "en"
}

var current_language : String = ""# en / ru - 2 буквы

var fullscreen: bool
var antialiasing: bool
var lighting: int
var shadows: int
var textures: int
var sensitivity: float

func _ready() -> void:
	# загрузка настроек видео
	var video_setting = ConfigFileHandler.load_video_settings()
	fullscreen = video_setting.fullscreen
	check_fullscreen()
	check_antialiasing()
	check_lighting()
	check_shadows()
	check_textures()
	
	change_window_mode.connect(check_fullscreen)

func check_antialiasing():
	if antialiasing == true:
		ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 1)
	else:
		ProjectSettings.set_setting("rendering/anti_aliasing/quality/screen_space_aa", 0)


func check_lighting():
	match lighting:
		0:
			pass
		1:
			pass
		2:
			pass

func check_shadows():
	match shadows:
		0:
			pass
		1:
			pass
		2:
			pass
		3:
			pass

func check_textures():
	match textures:
		0:
			pass
		1:
			pass
		2:
			pass


func check_fullscreen():
	if fullscreen == true:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)

	# загрузка настроек языка
	var language_setting = ConfigFileHandler.load_language_setting()
	current_language = language_setting.language
	TranslationServer.set_locale(current_language)
	
