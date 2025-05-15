extends ProgressBar

var actor: Actor

func _ready() -> void:
	actor = get_parent()

func update() -> void:
	max_value = actor.base.stats.health
