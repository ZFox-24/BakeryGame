extends Node

signal spawn_visitor
signal order_complete
signal create_order

signal open_bakery
signal close_bakery
signal bakery_opened_no_exit
var is_bakery_open := false
var is_computer_open := false

var current_visitors := 0
var max_visitors := 1

var time1 : float = 15.0
var time2: float = 30.0

var max_items := 1

func _ready() -> void:
	SaveLoad.save_data.connect(save_bakery_state)
	SaveLoad.load_other_data.connect(load_bakery_state)

func save_bakery_state():
	SaveLoad.save_file_data.data["bakery_status"] = is_bakery_open

func load_bakery_state():
	is_bakery_open = SaveLoad.save_file_data.data["bakery_status"]
	if is_bakery_open:
		open_bakery.emit()
