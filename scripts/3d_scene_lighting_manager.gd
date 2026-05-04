extends Node

@export var dynamic_lights : Array[DirectionalLight3D] = []
@export var baked_lights : LightmapGI = null

enum modes {
	BAKED,
	DYNAMIC
}

func _ready() -> void:
	pass

func change_lighting_mode(mode: modes) -> void:
	if !is_inside_tree(): return
	match mode:
		modes.BAKED:
			for l: DirectionalLight3D in dynamic_lights:
				if l: l.visible = false
			if baked_lights:
				baked_lights.visible = true
			print("BAKED LIGHTING ENABLED") 
		modes.DYNAMIC:
			for l: DirectionalLight3D in dynamic_lights:
				if l: l.visible = true
			if baked_lights:
				baked_lights.visible = false
			print("DYNAMIC LIGHTING ENABLED")
