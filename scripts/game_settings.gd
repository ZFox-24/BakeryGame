extends Node

signal change_window_mode
signal change_language

@onready var language := {
	"Русский": "ru",
	"English": "en"
}

var current_language : String = ""# en / ru - 2 буквы

var fullscreen: bool

func _ready() -> void:
	# загрузка настроек видео
	var video_setting = ConfigFileHandler.load_video_settings()
	fullscreen = video_setting.fullscreen
	check_fullscreen()
	
	change_window_mode.connect(check_fullscreen)

func check_fullscreen():
	if fullscreen == true:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)

	# загрузка настроек языка
	var language_setting = ConfigFileHandler.load_language_setting()
	current_language = language_setting.language
	TranslationServer.set_locale(current_language)
	
