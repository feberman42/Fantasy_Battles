class_name StatsDisplay extends VBoxContainer

signal increase_attribute(attribute: String)

@onready var strength_display: AttributeDisplay = $Strength
@onready var dexterity_display: AttributeDisplay = $Dexterity
@onready var intelligence_display: AttributeDisplay = $Intelligence

func _ready() -> void:
	strength_display.increase.connect(_on_attribute_increase)
	dexterity_display.increase.connect(_on_attribute_increase)
	intelligence_display.increase.connect(_on_attribute_increase)

func update(status: Status, can_skill: bool) -> void:
	var points_available = status.skill_points_available > 0 if can_skill else false
	strength_display.update(Refs.ATTRIBUTE_STR, status.attributes_raw.strength, points_available)
	dexterity_display.update(Refs.ATTRIBUTE_DEX, status.attributes_raw.dexterity, points_available)
	intelligence_display.update(Refs.ATTRIBUTE_INT, status.attributes_raw.intelligence, points_available)

func _on_attribute_increase(attribute: String) -> void:
	increase_attribute.emit(attribute)
