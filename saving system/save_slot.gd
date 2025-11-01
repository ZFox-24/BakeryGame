extends Button

@export var save : Resource # заменить на нормальную реализацию потом

func _ready() -> void:
	pressed.connect(operate_with_file)

func operate_with_file():
	#await SavesManagement.file_operation_index != null
	match SavesManagement.file_operation_index:
		0: # сохранить
			SaveLoad.save_data.emit()
		1: # загрузить
			SaveLoad.load_data.emit()
		2: # удалить
			pass
