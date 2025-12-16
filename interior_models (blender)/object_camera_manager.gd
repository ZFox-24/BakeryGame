extends Node

signal switch_to_PC
signal switch_to_OC

@export var object_camera : Camera3D

func _ready() -> void:
	pass
	#object_camera.current = true
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	#switch_to_OC.connect(switch_to_oc)
	#switch_to_PC.connect(switch_to_pc)

func switch_to_pc():
	object_camera.current = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func switch_to_oc():
	object_camera.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
