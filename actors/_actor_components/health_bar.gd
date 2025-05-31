class_name HealthBar extends ProgressBar

var actor: Actor

func _ready() -> void:
	actor = get_parent().get_parent()

func update() -> void:
	max_value = actor.status.max_health
	value = actor.status.current_health
