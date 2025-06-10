class_name ActorSprite extends Sprite2D

signal hit
signal returned

func _ready() -> void:
	var tex_offset: int = floor(texture.get_height() / 2)
	offset.y = -tex_offset
	position.y = tex_offset

func run_anim(type: Refs.AnimType, target: Actor) -> void:
	match type:
		Refs.AnimType.physical:
			%AttackAnimTween.run(target)
		_:
			print("Couldn't resolve Anim Type: ", str(type))
