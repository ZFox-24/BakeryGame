extends Node

@export var SeeCast : RayCast3D
@onready var is_colliding := false
@onready var target

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and is_colliding:
		if target.has_method("interact"):
			target.interact()
			%InteractText.hide()
			%crosshair.hide()

func _physics_process(_delta: float) -> void:
	%InteractText.hide()
	%interact_button.hide()
	%crosshair.change_crosshair("default")
	if SeeCast.is_colliding():
		target = SeeCast.get_collider()
		if target.has_method("interact"):
			%crosshair.show()
			if OS.get_name() == "Android" or OS.get_name() == "iOS" or OS.get_name() == "Windows": # изменить перед релизом
				%interact_button.show()
			%crosshair.change_crosshair("hand")
			is_colliding = true
		elif target.has_method("show_obj_name"):
			print("is interacting: showing tewxt")
			%InteractText.show()
			%InteractText.text = target.show_obj_name()
			is_colliding = true
