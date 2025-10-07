extends Node3D

func _ready() -> void:
	VisitorManager.open_bakery.connect(bakery_opened)
	VisitorManager.spawn_visitor.connect(bakery_opened)
	VisitorManager.close_bakery.connect(%Timer.stop)

func spawn_human():
	if VisitorManager.current_visitors < VisitorManager.max_visitors and VisitorManager.is_bakery_open:
		var human = load("res://scenes/human.tscn").instantiate()
		add_child(human)
		VisitorManager.current_visitors += 1
		%Timer.disconnect("timeout", spawn_human)

func bakery_opened():
	var time1 = VisitorManager.time1
	var time2 = VisitorManager.time2
	%Timer.wait_time = randi_range(time1, time2)
	print(str(time1) + " : " + str(time2))
	%Timer.start()
	%Timer.timeout.connect(spawn_human)
