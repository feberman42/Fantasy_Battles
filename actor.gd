class_name Actor extends Sprite2D

@export var base: ActorBase
@export var combat_cations: Array[BasicCombatAction]
var current_stats: Stats = Stats.new()
var status: Status = Status.new()

@export var opponent: Actor

@onready var health_bar: HealthBar = $HealthBar

var wait_for_input: bool = false

func _to_string() -> String:
	return str("(" + self.name + " " + self.base.resource_path.get_file().get_basename() + ")")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = base.sprite
	_calculate_stats()
	status.initialize(current_stats)
	health_bar.update()
	TurnManager.turn_start.connect(_on_turn_start)

func _on_turn_start(actor: Actor) -> void:
	if actor != self: return
	if self.is_in_group("player"):
		wait_for_input = true
		return
	else:
		combat_cations[0].execute(self, opponent)
		await get_tree().create_timer(0.5).timeout
		TurnManager.turn_end.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not wait_for_input: return
	if Input.is_action_just_pressed("num_1"):
		combat_cations[0].execute(self, opponent)
		wait_for_input = false
		TurnManager.turn_end.emit(self)
	elif Input.is_action_just_pressed("num_2"):
		combat_cations[1].execute(self, opponent)
		wait_for_input = false
		TurnManager.turn_end.emit(self)
		
func _calculate_stats() -> void:
	current_stats.health = base.stats.health
	current_stats.energy = base.stats.energy
	current_stats.attack = base.stats.attack
	current_stats.defense = base.stats.defense
	current_stats.intelligence = base.stats.intelligence
	current_stats.resistance = base.stats.resistance
	
func process_damage_payload(payload: DamagePayload) -> DamageReport:
	var report: DamageReport = DamageReport.new()
	
	var physical_damage = maxi(payload.physical_damage - self.current_stats.defense, 0)
	report.physical_damage_dealt = self._take_damage(physical_damage)
	var magical_damage = maxi(payload.magical_damage - self.current_stats.resistance, 0)
	report.magical_damage_dealt = self._take_damage(magical_damage)
	report.killed = self._check_death()
	return report
	
func _take_damage(amount: int) -> int:
	if amount > status.current_health:
		amount = status.current_health
	status.current_health -= amount
	health_bar.update()
	return amount

func _check_death() -> bool:
	if self.status.current_health <= 0:
		TurnManager.actor_died.emit(self)
		self.queue_free()
		return true
	else:
		return false
