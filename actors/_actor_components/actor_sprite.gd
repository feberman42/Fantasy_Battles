class_name ActorSprite extends Sprite2D

signal hit
signal returned

func _ready() -> void:
	pass

func run_anim(type: Refs.AnimType, target: Actor) -> void:
	match type:
		Refs.AnimType.physical:
			%AttackAnimTween.run(target)
		_:
			print("Couldn't resolve Anim Type: ", str(type))
