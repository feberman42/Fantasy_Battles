class_name CharacterMenu extends BaseMenu

@onready var player_name_label: Label = %PlayerName
@onready var player_level_label: Label = %Level
@onready var player_sprite: TextureRect = %PlayerSprite
@onready var stats_display: StatsDisplay = %StatsDisplay
@onready var game_manager: GameManager = get_node("/root/main")

var actor: Actor
var skip_process: bool

func _ready() -> void:
	super._ready()
	stats_display.increase_attribute.connect(_on_attribute_increase)
	actor = get_tree().get_first_node_in_group(Refs.GROUP_PLAYER)
	
func _process(delta: float) -> void:
	if not visible or game_manager.current_state != game_manager.GameState.REST:
		return
	if skip_process:
		skip_process = false
		return
	if Input.is_action_just_pressed("char_menu"):
		Signals.toggle_menu.emit(Refs.Menu.REST)

func _update() -> void:
	player_name_label.text = "Name"
	player_level_label.text = str("Level: ", actor.status.level)
	player_sprite.texture = actor.base.sprite
	stats_display.update(actor.status, game_manager.current_state == game_manager.GameState.REST)
	actor.update_bars()
	skip_process = true

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
	actor.status.update_secondary_attibutes()
	actor.update_bars_and_ca()
