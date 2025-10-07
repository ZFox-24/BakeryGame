extends Node

signal spawn_visitor
signal order_complete
signal create_order

signal open_bakery
signal close_bakery
signal bakery_opened_no_exit
var is_bakery_open := false

var current_visitors := 0
var max_visitors := 1

var time1 : float = 15.0
var time2: float = 30.0
