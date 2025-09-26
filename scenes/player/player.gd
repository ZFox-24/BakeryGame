extends CharacterBody3D

var sensitivity := 0.4

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # убирает курсор

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * sensitivity # оборот игрока вправо/влево
		%Camera3D.rotation_degrees.x -= event.relative.y * sensitivity # вращение камеры вниз/вверх. Смотреть на оси в гизмо, чтобы определить их
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x, -80, 80
		) # ограничение угла наклона камеры вниз/вверх
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	const SPEED = 5.5 # метры/с
	
	var input_dicrection_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D = Vector3(
		input_dicrection_2D.x, 0.0, input_dicrection_2D.y
	)
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()
