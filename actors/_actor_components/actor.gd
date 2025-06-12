class_name Actor extends Node2D

@export var base: ActorBase
var attributes_raw: Attributes = Attributes.new()
var combat_actions: Array[BasicCombatAction]
var status: Status = Status.new()

@export var opponent: Actor
@onready var name_tag: Label = %NameTag
@onready var sprite: ActorSprite = %Sprite
@onready var health_bar: ResourceBar = %HealthBar
@onready var energy_bar: ResourceBar = %EnergyBar
@onready var combat_action_list: CombatActionList = %CombatActionsList

var wait_for_input: bool = false


func _to_string() -> String:
	return str("(" + self.name + " " + self.base.resource_path.get_file().get_basename() + ")")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	combat_action_list.visible = false
	TurnManager.turn_start.connect(_on_turn_start)
	combat_action_list.action_selected.connect(_on_action_selected)
	load_base()

func load_base() -> void:
	print(self, " load_base...")
	update_sprite_and_name()
	status.initialize(base.attributes)
	self.combat_actions = self.base.combat_actions.duplicate()
	health_bar.update(status.current_health, status.max_health)
	energy_bar.update(status.current_energy, status.max_energy)
	self.visible = true
	
func update_sprite_and_name() -> void:
	self.sprite.texture = base.sprite
	self.name_tag.text = "Player"
	if not self.is_in_group("player"):
		self.sprite.flip_h = true
		self.name_tag.text = base.name

func _on_turn_start(actor: Actor) -> void:
	if actor != self: return
	if self.is_in_group("player"):
		combat_action_list.update_list(combat_actions, status)
		combat_action_list.visible = true
		wait_for_input = true
		return
	else:
		combat_actions[0].execute(self, opponent)
		await get_tree().create_timer(0.5).timeout
		TurnManager.turn_end.emit(self)

func _on_action_selected(action: BasicCombatAction) -> void:
	var report: DamageReport
	report = await action.execute(self, opponent)
	self._end_turn()

func _end_turn() -> void:
	self.wait_for_input = false
	TurnManager.turn_end.emit(self)

func process_damage_payload(payload: DamagePayload) -> DamageReport:
	var report: DamageReport = DamageReport.new()
	
	var physical_damage = maxi(payload.physical_damage, 0)
	report.physical_damage_dealt = self._take_damage(physical_damage)
	var magical_damage = maxi(payload.magical_damage, 0)
	report.magical_damage_dealt = self._take_damage(magical_damage)
	report.killed = self._check_death()
	return report
	
func _take_damage(amount: int) -> int:
	if amount > status.current_health:
		amount = status.current_health
	status.current_health -= amount
	health_bar.update(status.current_health, status.max_health)
	return amount

func _check_death() -> bool:
	if self.status.current_health <= 0:
		TurnManager.actor_died.emit(self)
		self.visible = false
		return true
	else:
		return false
