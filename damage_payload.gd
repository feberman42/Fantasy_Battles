class_name DamagePayload extends Resource

@export var physical_damage: int
@export var magical_damage: int

func _to_string() -> String:
	return "phys_dmg: " + str(physical_damage) + " - mag_dmg: " + str(magical_damage)
