class_name BattleScene extends Node2D

@export var player_actor: Actor
@export var opponent_actor: Actor
@onready var char_menu: CharacterMenu = %CharacterMenu

func _ready() -> void:
	char_menu.visible = false

func _process(delta: float) -> void:
	if not player_actor.wait_for_input:
		return
	if Input.is_action_just_pressed("char_menu"):
		char_menu.toggle(player_actor)

func start_run() -> void:
	print("Start new run")
	player_actor.load_base()
	start_battle()

func start_battle() -> void:
	print("Start next battle")
	opponent_actor.base = Refs.ACTOR_BASE_LIST.pick_random()
	opponent_actor.load_base()
	TurnManager.start_battle.emit()
