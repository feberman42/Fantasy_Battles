class_name BasicCombatAction extends Resource

@export_category("Flat Damage")
@export var flat_physical: int
@export var flat_magical: int

@export_category("Physical Damage Scaled")
@export var physical_per_health: int
@export var physical_per_attack: int
@export var physical_per_defense: int
@export var physical_per_intelligence: int
@export var physical_per_resistence: int

@export_category("Magic Damage Scaled")
@export var magical_per_health: int
@export var magical_per_attack: int
@export var magical_per_defense: int
@export var magical_per_intelligence: int
@export var magical_per_resistence: int

func execute(actor: Actor, target: Actor) -> void:
	print(actor, " uses ", self.resource_path.get_file().get_basename(), " on ", target)
	var payload: DamagePayload = _create_damage_payload(actor.current_stats)
	print("Payload: ", payload)
	var report: DamageReport = target.process_damage_payload(payload)
	print("Report: ", report)

func _create_damage_payload(actor_stats: Stats) -> DamagePayload:
	var payload: DamagePayload = DamagePayload.new()
	
	payload.physical_damage = self.flat_physical
	payload.physical_damage += self.physical_per_health * actor_stats.health
	payload.physical_damage += self.physical_per_attack * actor_stats.attack
	payload.physical_damage += self.physical_per_defense * actor_stats.defense
	payload.physical_damage += self.physical_per_intelligence * actor_stats.intelligence
	payload.physical_damage += self.physical_per_resistence * actor_stats.resistance
	
	payload.magical_damage = self.flat_magical
	payload.magical_damage += self.magical_per_health * actor_stats.health
	payload.magical_damage += self.magical_per_attack * actor_stats.attack
	payload.magical_damage += self.magical_per_defense * actor_stats.defense
	payload.magical_damage += self.magical_per_intelligence * actor_stats.intelligence
	payload.magical_damage += self.magical_per_resistence * actor_stats.resistance
	
	return payload
