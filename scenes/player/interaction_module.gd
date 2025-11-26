extends Node

@export var SeeCast : RayCast3D
@onready var is_colliding := false
@onready var target 

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and is_colliding:
		#%InteractText.hide()
		%crosshair.hide()
		if target.has_method("interact"):
			target.interact()

func _process(delta: float) -> void:
	%crosshair.change_crosshair("default")
	if SeeCast.is_colliding():
		target = SeeCast.get_collider()
		if target.has_method("interact"):
			#%InteractText.show() # переделать взаимодействие
			%crosshair.show()
			%crosshair.change_crosshair("hand")
			is_colliding = true 
