class_name BasicCombatAction extends Resource

@export_category("Flat Damage")
@export var flat_physical: int
@export var flat_magical: int

@export_category("Physical Damage Scaled")
@export var physical_per_strength: int
@export var physical_per_dexterity: int
@export var physical_per_intelligence: int

@export_category("Magic Damage Scaled")
@export var magical_per_strength: int
@export var magical_per_dexterity: int
@export var magical_per_intelligence: int

func _to_string() -> String:
	return self.resource_path.get_file().get_basename()
	
func generate_tooltip() -> String:
	var tooltip: String = str(self) + "\n"
	if self._has_physical_component():
		tooltip += "Deals "
		if flat_physical:
			tooltip += str(flat_physical) + " + "
		if physical_per_strength > 0:
			tooltip += str(physical_per_strength) + "*Str + "
		if physical_per_dexterity > 0:
			tooltip += str(physical_per_dexterity) + "*Dex + "
		if physical_per_intelligence > 0:
			tooltip += str(physical_per_intelligence) + "*Int + "
		tooltip = tooltip.trim_suffix(" + ")
		tooltip += " physical damage.\n"
		
	if self._has_magical_component():
		tooltip += "Deals "
		if flat_magical:
			tooltip += str(flat_magical) + " + "
		if magical_per_strength > 0:
			tooltip += str(magical_per_strength) + "*Str + "
		if magical_per_dexterity > 0:
			tooltip += str(magical_per_dexterity) + "*Dex + "
		if magical_per_intelligence > 0:
			tooltip += str(magical_per_intelligence) + "*Int + "
		tooltip = tooltip.trim_suffix(" + ")
		tooltip += " magical damage.\n"
	
	return tooltip

func execute(actor: Actor, target: Actor) -> void:
	print(actor, " uses ", self, " on ", target)
	var payload: DamagePayload = _create_damage_payload(actor.status)
	print("Payload: ", payload)
	var report: DamageReport = target.process_damage_payload(payload)
	print("Report: ", report)
	if report.killed:
		actor.status.get_exp(70)

func _create_damage_payload(actor_status: Status) -> DamagePayload:
	var payload: DamagePayload = DamagePayload.new()
	
	payload.physical_damage = self.flat_physical
	payload.physical_damage += self.physical_per_strength * actor_status.attributes_raw.strength
	payload.physical_damage += self.physical_per_dexterity * actor_status.attributes_raw.dexterity
	payload.physical_damage += self.physical_per_intelligence * actor_status.attributes_raw.intelligence
	
	payload.magical_damage = self.flat_magical
	payload.magical_damage += self.magical_per_strength * actor_status.attributes_raw.strength
	payload.magical_damage += self.magical_per_dexterity * actor_status.attributes_raw.dexterity
	payload.magical_damage += self.magical_per_intelligence * actor_status.attributes_raw.intelligence
	
	return payload

func _has_physical_component() -> bool:
	if flat_physical > 0: return true
	if physical_per_strength > 0: return true
	if physical_per_dexterity > 0: return true
	if physical_per_intelligence > 0: return true
	return false
	
func _has_magical_component() -> bool:
	if flat_magical > 0: return true
	if magical_per_strength > 0: return true
	if magical_per_dexterity > 0: return true
	if magical_per_intelligence > 0: return true
	return false
