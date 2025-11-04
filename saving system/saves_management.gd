extends Node

var available_saves : Array[Resource] = [] # заменить ресурс на нормальный тип

var file_operation_index : int # сохраняет индекс вкладки из меню сохранений в паузе
signal create_save_menu_open

signal save_player
signal save_products
signal save_bakery_state
signal save_bought_upgrades
signal save_money

signal load_player
signal load_products
signal load_bakery_state
signal load_bought_upgrades
signal load_money
