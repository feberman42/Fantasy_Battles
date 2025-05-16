extends ProgressBar

var actor: Actor

func _ready() -> void:
	actor = get_parent()

func update() -> void:
	max_value = actor.current_stats.health
	value = actor.status.current_health
