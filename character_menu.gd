class_name CharacterMenu extends PanelContainer

@onready var player_name_label: Label = %PlayerName
@onready var player_sprite: TextureRect = %PlayerSprite
@onready var stats_display: StatsDisplay = %StatsDisplay

func _update(player: Actor) -> void:
	player_name_label.text = "Name"
	player_sprite.texture = player.base.sprite
	stats_display.update(player.status)

func toggle(player: Actor) -> void:
	if self.visible:
		self.visible = false
	else:
		_update(player)
		self.visible = true
