class_name StatsDisplay extends VBoxContainer

@onready var strength_display: AttributeDisplay = $Strength
@onready var dexterity_display: AttributeDisplay = $Dexterity
@onready var intelligence_display: AttributeDisplay = $Intelligence

func update(status: Status) -> void:
	strength_display.update("Strength", status.attributes.strength)
	dexterity_display.update("Dexterity", status.attributes.dexterity)
	intelligence_display.update("Intelligence", status.attributes.intelligence)
