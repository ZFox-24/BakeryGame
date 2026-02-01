extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "user://settings.ini"

func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("DON'T TOUCH IT, IT'S FRAGILE!", ">:", "(")
		config.set_value("language", "language", TranslationServer.get_locale())
		config.set_value("language", "languageID", 0)
		config.set_value("video", "fullscreen", false)

		config.save(SETTINGS_FILE_PATH)
	else:
		config.load(SETTINGS_FILE_PATH)

func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)

func save_language_setting(key: String, value):
	config.set_value("language", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings

func load_language_setting():
	var language_settings = {}
	for key in config.get_section_keys("language"):
		language_settings[key] = config.get_value("language", key)
	return language_settings
