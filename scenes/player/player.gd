extends CharacterBody3D

var sensitivity := GameSettings.sensitivity

func _ready() -> void:
	GameSettings.sensitivity_slider_changed.connect(func() -> void: sensitivity = GameSettings.sensitivity)
	VisitorManager.bakery_opened_no_exit.connect(play_anim)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # убирает курсор
	
	if OS.get_name() != "Android":
		%interact_button.queue_free()
		%pause_button.queue_free()
	
	if !OS.is_debug_build():
		%fps.queue_free()

func play_anim():
	$CanvasLayer/CantExitText/text_animate.play("text")

var mouse_input: Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.relative
		#rotation_degrees.y -= event.relative.x * sensitivity # оборот игрока вправо/влево
		#%Camera3D.rotation_degrees.x -= event.relative.y * sensitivity # вращение камеры вниз/вверх. Смотреть на оси в гизмо, чтобы определить их
		#%Camera3D.rotation_degrees.x = clamp(
			#%Camera3D.rotation_degrees.x, -80, 80
		#) # ограничение угла наклона камеры вниз/вверх
	elif event.is_action_pressed("ui_cancel"):
		var pause_menu = load("uid://cbglsp3wlye20").instantiate() # новые добавления
		add_child(pause_menu) #

func _physics_process(_delta: float) -> void:
	const SPEED: int = 5.5 # метры/с
	var input_direction_2D: Vector2
	
	self.rotate_y(deg_to_rad(-mouse_input.x * GameSettings.sensitivity))
	%Camera3D.rotate_x(deg_to_rad(-mouse_input.y * GameSettings.sensitivity))
	%Camera3D.rotation.x = clamp(%Camera3D.rotation.x,deg_to_rad(-70.0),deg_to_rad(70.0))
	mouse_input = Vector2.ZERO
	
	# компьютерное или мобильное управление
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		input_direction_2D = %joystick.get_value()
	else:
		input_direction_2D = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
	)
	var input_direction_3D: Vector3 = Vector3(
		input_direction_2D.x, 0.0, input_direction_2D.y
	)
	var direction: Vector3 = transform.basis * input_direction_3D
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()
	
	if velocity.x or velocity.z > 0:
		%camera_animation.current_animation = "camera_bob"
	elif velocity.x or velocity.z == 0:
		%camera_animation.current_animation = "idle"

func _play_footstep_audio():
	%footstep_audio.pitch_scale = randf_range(.8, 1.2)
	%footstep_audio.play()
