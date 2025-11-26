extends Node3D

@onready var is_on = VisitorManager.is_lamp_on
@export var text_on : StandardMaterial3D
@export var text_off : StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisitorManager.change_lamp_state.connect(state)

func state():
	if !is_on:
		%OmniLight3D.show()
		%light.mesh.material = text_on
		is_on = true
	else:
		%OmniLight3D.hide()
		%light.mesh.material = text_off
		%OmniLight3D.hide()
		is_on = false
