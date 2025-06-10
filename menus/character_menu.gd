class_name CharacterMenu extends PanelContainer

@onready var player_name_label: Label = %PlayerName
@onready var player_sprite: TextureRect = %PlayerSprite
@onready var stats_display: StatsDisplay = %StatsDisplay

var actor: Actor

func _ready() -> void:
	stats_display.increase_attribute.connect(_on_attribute_increase)

func _update() -> void:
	player_name_label.text = "Name"
	player_sprite.texture = actor.base.sprite
	stats_display.update(actor.status)

func toggle(player: Actor) -> void:
	self.actor = player
	if self.visible:
		self.visible = false
	else:
		_update()
		self.visible = true

func _on_attribute_increase(attribute: String) -> void:
	actor.status.skill_points_available -= 1
	match attribute:
		Refs.ATTRIBUTE_STR:
			actor.status.attributes_raw.strength += 1
		Refs.ATTRIBUTE_DEX:
			actor.status.attributes_raw.dexterity += 1
		Refs.ATTRIBUTE_INT:
			actor.status.attributes_raw.intelligence += 1
		_:
			print_rich("[color=red]Error:[/color] Stat increse of unknown type. ", attribute)
	_update()
