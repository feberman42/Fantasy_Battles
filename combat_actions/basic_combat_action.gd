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

func _to_string() -> String:
	return self.resource_path.get_file().get_basename()
	
func generate_tooltip() -> String:
	var tooltip: String = str(self) + "\n"
	if self._has_physical_component():
		tooltip += "Deals "
		if flat_physical:
			tooltip += str(flat_physical) + " + "
		if physical_per_health > 0:
			tooltip += str(physical_per_health) + "*max_health + "
		if physical_per_attack > 0:
			tooltip += str(physical_per_attack) + "*attack + "
		if physical_per_defense > 0:
			tooltip += str(physical_per_defense) + "*defense + "
		if physical_per_intelligence > 0:
			tooltip += str(physical_per_intelligence) + "*intelligence + "
		if physical_per_resistence > 0:
			tooltip += str(physical_per_resistence) + "*resistence + "
		tooltip = tooltip.trim_suffix(" + ")
		tooltip += " physical damage.\n"
		
	if self._has_magical_component():
		tooltip += "Deals "
		if flat_magical:
			tooltip += str(flat_magical) + " + "
		if magical_per_health > 0:
			tooltip += str(magical_per_health) + "*max_health + "
		if magical_per_attack > 0:
			tooltip += str(magical_per_attack) + "*attack + "
		if magical_per_defense > 0:
			tooltip += str(magical_per_defense) + "*defense + "
		if magical_per_intelligence > 0:
			tooltip += str(magical_per_intelligence) + "*intelligence + "
		if magical_per_resistence > 0:
			tooltip += str(magical_per_resistence) + "*resistence + "
		tooltip = tooltip.trim_suffix(" + ")
		tooltip += " magical damage.\n"
	
	return tooltip

func execute(actor: Actor, target: Actor) -> void:
	print(actor, " uses ", self, " on ", target)
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

func _has_physical_component() -> bool:
	if flat_physical > 0: return true
	if physical_per_health > 0: return true
	if physical_per_attack > 0: return true
	if physical_per_defense > 0: return true
	if physical_per_intelligence > 0: return true
	if physical_per_resistence > 0: return true
	return false
	
func _has_magical_component() -> bool:
	if flat_magical > 0: return true
	if magical_per_health > 0: return true
	if magical_per_attack > 0: return true
	if magical_per_defense > 0: return true
	if magical_per_intelligence > 0: return true
	if magical_per_resistence > 0: return true
	return false
