extends Sprite2D

func _ready() -> void:
	var tex_offset: int = floor(texture.get_height() / 2)
	offset.y = -tex_offset
	position.y = tex_offset
