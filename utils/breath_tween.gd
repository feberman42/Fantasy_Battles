class_name BreathTween extends Node

@export var intensity: Vector2 = Vector2(1.02, 0.98)
@export var speed: float = 1.0

var tween: Tween
@onready var parent = get_parent()

func _ready():
	var starting_scale: Vector2 = parent.scale
	var breath_scale: Vector2 = starting_scale * intensity
	await get_tree().create_timer(randf_range(0, speed)).timeout
	tween = create_tween()
	tween.set_loops()  # Loop forever
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(parent, "scale", breath_scale, speed)
	tween.tween_property(parent, "scale", starting_scale, speed)
