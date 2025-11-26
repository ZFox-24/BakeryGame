extends StaticBody3D

@onready var is_on := false

@export var is_off_material : StandardMaterial3D
@export var is_on_material : StandardMaterial3D

func interact():
	if !is_on:
		%OmniLight3D.hide()
		%light.mesh.material = is_on_material
		%switch.rotation_degrees = Vector3(180, 90, -180)
		is_on = true
		VisitorManager.is_lamp_on = is_on
		VisitorManager.change_lamp_state.emit()
	else:
		%OmniLight3D.show()
		%light.mesh.material = is_off_material
		%switch.rotation_degrees = Vector3(0, 90, -180)
		is_on = false
		VisitorManager.is_lamp_on = is_on
		VisitorManager.change_lamp_state.emit()
