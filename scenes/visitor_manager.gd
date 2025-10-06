extends Node

signal spawn_visitor
signal order_complete
signal create_order

signal open_bakery
signal close_bakery
var is_bakery_open := false

var current_visitors := 0
var max_visitors := 1

var time1 : int = 2
var time2: int = 5
