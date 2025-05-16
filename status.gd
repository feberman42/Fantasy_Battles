class_name Status extends Resource

var current_health: int
var current_energy: int

func initialize(stats: Stats) -> void:
	current_health = stats.health
	current_energy = stats.energy
