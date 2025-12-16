extends CollisionShape3D

## ВЗАИМОДЕЙСТВИЕ
func interact():
	%object_camera_manager.switch_to_OC.emit()
