class_name Status extends Resource

var attributes: Attributes
var level: int = 1
var exp: int = 0
var skill_points_total: int = 0
var skill_points_available: int = 0
var max_health: int
var max_energy: int
var current_health: int
var current_energy: int

func initialize(stats: Attributes) -> void:
	attributes = stats.duplicate()
	update()
	current_health = max_health
	current_energy = max_energy

func update() -> void:
	max_health = attributes.strength * 5
	max_energy = attributes.intelligence * 3
	
