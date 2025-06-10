class_name AttackAnimTween extends Node

var tween: Tween
@onready var parent: ActorSprite = get_parent()

func run(target: Actor) -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	var start_pos: Vector2 = parent.global_position
	var target_pos: Vector2 = target.sprite.global_position
	if start_pos.x < target_pos.x: target_pos.x -= 150
	else: target_pos.x += 150
	tween.tween_property(parent, "global_position", target_pos, 0.5)
	if parent.flip_h:
		tween.tween_property(parent, "rotation", -0.5, 0.1)
	else:
		tween.tween_property(parent, "rotation", 0.5, 0.1)
	tween.tween_callback(parent.hit.emit)
	tween.tween_property(parent, "rotation", 0, 0.1)
	tween.tween_property(parent, "global_position", start_pos, 0.2)
	tween.tween_callback(parent.returned.emit)

	tween.play()
	
