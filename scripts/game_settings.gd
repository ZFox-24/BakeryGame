extends Node

signal change_window_mode
signal change_language
signal change_light_mode

signal show_mobile_buttons
signal hide_mobile_buttons

signal sensitivity_slider_changed

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
	var misc_setting = ConfigFileHandler.load_misc_setting()
	fullscreen = video_setting.fullscreen
	antialiasing = video_setting.anti_aliasing
	lighting = video_setting.lighting
	shadows = video_setting.shadows
	textures = video_setting.textures
	sensitivity = misc_setting.sensitivity

	handle_fullscreen()
	handle_antialiasing()
	handle_lighting(lighting)
	change_shadows_setting(shadows)

func handle_antialiasing():
	if antialiasing == true:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_SMAA
		get_viewport().msaa_3d = Viewport.MSAA_4X
	else:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_DISABLED


func handle_lighting(mode: int) -> bool:
	match mode:
		0: #baked
			return false
		1: #dynamic
			return true
	change_light_mode.emit()
	return mode


func handle_fullscreen():
	if fullscreen == true:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)

	# загрузка настроек языка
	var language_setting = ConfigFileHandler.load_misc_setting()
	current_language = language_setting.language
	TranslationServer.set_locale(current_language)


func change_shadows_setting(level: int):
	match level:
		0:
			RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_HARD)
			RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_HARD)
			if OS.get_name() == "Android":
				RenderingServer.directional_shadow_atlas_set_size(256, false)
			else: RenderingServer.directional_shadow_atlas_set_size(512, false)
		1:
			if OS.get_name() == "Android":
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_VERY_LOW)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_VERY_LOW)
				RenderingServer.directional_shadow_atlas_set_size(512, false)
			else:
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
				RenderingServer.directional_shadow_atlas_set_size(1024, false)
		2:
			if OS.get_name() == "Android":
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_LOW)
				RenderingServer.directional_shadow_atlas_set_size(1024, false)
			else:
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
				RenderingServer.directional_shadow_atlas_set_size(2048, true)
		3:
			if OS.get_name() == "Android":
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_MEDIUM)
				RenderingServer.directional_shadow_atlas_set_size(2048, false)
			else:
				RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_ULTRA)
				RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_ULTRA)
				RenderingServer.directional_shadow_atlas_set_size(4096, true)

func change_sensitivity(value: float) -> void:
	sensitivity = value
