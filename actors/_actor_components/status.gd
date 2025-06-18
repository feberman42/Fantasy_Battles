class_name Status extends Resource

var owner: Actor
var attributes_raw: Attributes
var level: int = 1
var experience: int = 0
var skill_points_used: int = 0
var skill_points_available: int = 0
var max_health: int
var max_energy: int
var current_health: int
var current_energy: int

func initialize(_owner: Actor, _level: int = 1) -> void:
	self.owner = _owner
	attributes_raw = owner.base.attributes.duplicate()
	while self.level < _level:
		self._level_up()
	update_secondary_attibutes()
	current_health = max_health
	current_energy = max_energy

func update_secondary_attibutes() -> void:
	var old_health: int = max_health
	max_health = attributes_raw.strength * 5
	current_health += max_health - old_health
	var old_energy: int = max_energy
	max_energy = attributes_raw.intelligence * 3
	current_energy += max_energy - old_energy
	
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
	if not owner.is_player:
		self._auto_level()

func _auto_level() -> void:
	# use skill points
	for i in range(self.skill_points_available):
		self.attributes_raw.strength += 1
	self.update_secondary_attibutes()
	
func heal_full() -> void:
	self.current_health = self.max_health
