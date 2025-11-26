extends TextureRect

@export var default : CompressedTexture2D
@export var hand : CompressedTexture2D

func change_crosshair(type : String):
	match type:
		"default":
			texture = default
		"hand":
			texture = hand
