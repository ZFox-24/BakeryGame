extends Node

var available_saves : Array[Resource] = [] # заменить ресурс на нормальный тип

var file_operation_index : int # сохраняет индекс вкладки из меню сохранений в паузе
signal create_save_menu_open
