class_name CharacterMenu extends PanelContainer

@onready var player_name_label: Label = %PlayerName
@onready var player_sprite: TextureRect = %PlayerSprite

func _update(player: Actor) -> void:
	player_name_label.text = "Name"
	player_sprite.texture = player.base.sprite

func toggle(player: Actor) -> void:
	if self.visible:
		self.visible = false
	else:
		_update(player)
		self.visible = true
