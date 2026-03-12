extends Node

@export var object_collision: Area3D = Area3D.new()
@export var object_text: String

func _ready() -> void:
	if object_collision:
		object_collision.body_entered.connect(func(_body: Node3D) -> String: return object_text)
	else: push_error("❌ Отсутствует тело!")
