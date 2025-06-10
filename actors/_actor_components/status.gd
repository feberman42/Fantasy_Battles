class_name Status extends Resource

var attributes_raw: Attributes
var level: int = 1
var experience: int = 0
var skill_points_used: int = 0
var skill_points_available: int = 0
var max_health: int
var max_energy: int
var current_health: int
var current_energy: int

func initialize(stats: Attributes) -> void:
	attributes_raw = stats.duplicate()
	update()
	current_health = max_health
	current_energy = max_energy

func update() -> void:
	max_health = attributes_raw.strength * 5
	max_energy = attributes_raw.intelligence * 3
	
func get_exp(amount: int) -> void:
	if amount < 0:
		printerr("Tried to assign negative exp.")
		return
	experience += amount
	if experience >= 100:
		_level_up()
		experience -= 100

func _level_up() -> void:
	level += 1
	skill_points_available += 3
