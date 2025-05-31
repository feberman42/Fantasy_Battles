class_name Status extends Resource

var attributes: Attributes
var max_health: int
var max_energy: int
var current_health: int
var current_energy: int

func initialize(stats: Attributes) -> void:
	attributes = stats.duplicate()
	
	max_health = attributes.strength * 5
	current_health = max_health
	max_energy = attributes.intelligence * 3
	current_energy = max_energy
