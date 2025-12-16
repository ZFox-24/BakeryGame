extends Node

@export var SeeCast : RayCast3D
@onready var is_colliding := false
@onready var target 

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and is_colliding:
		if target.has_method("interact"):
			target.interact()
			%InteractText.hide()
			%crosshair.hide()

func _process(delta: float) -> void:
	%InteractText.hide()
	%crosshair.change_crosshair("default")
	if SeeCast.is_colliding():
		target = SeeCast.get_collider()
		if target.has_method("interact"):
			#%InteractText.show() # переделать взаимодействие
			%crosshair.show()
			%crosshair.change_crosshair("hand")
			is_colliding = true
		if target.has_method("show_obj_name"):
			%InteractText.show()
			%InteractText.text = target.show_obj_name()
			is_colliding = true
