class_name DamageReport extends Resource

@export var physical_damage_dealt: int
@export var magical_damage_dealt: int
@export var killed: bool

func _to_string() -> String:
	return "phys_dmg: " + str(physical_damage_dealt) + " - mag_dmg: " + str(magical_damage_dealt) + " - killed: " + str(killed)
