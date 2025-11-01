extends Node

signal save_data
signal load_data

var save_location = "user://saves/" + save_name + ".tres"
var save_name : String

var save_file_data : save_data_resource = save_data_resource.new()

# перед сохранением обязательно обновлять данные
func _save():
	ResourceSaver.save(save_file_data, save_location)

func _load():
	if FileAccess.file_exists(save_location):
		# для удостоверниея того, что копия данных равна сохраняемым данным
		save_file_data = ResourceLoader.load(save_location).duplicate(true)

func _delete():
	if FileAccess.file_exists(save_location):
		pass

func _ready() -> void:
	if DirAccess.dir_exists_absolute("user://saves/"):
		pass
