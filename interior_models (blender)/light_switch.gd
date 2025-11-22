extends StaticBody3D

@onready var is_on := false

@export var is_off_material : StandardMaterial3D
@export var is_on_material : StandardMaterial3D

func interact():
	if !is_on:
		%OmniLight3D.hide()
		%light.mesh.material = is_on_material
		%switch.rotate_x(180)
		is_on = true
	else:
		%OmniLight3D.show()
		%light.mesh.material = is_off_material
		%switch.rotate_x(-180)
		is_on = false
