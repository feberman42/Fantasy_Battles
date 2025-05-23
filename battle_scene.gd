class_name BattleScene extends Node2D

@export var player_actor: Actor
@export var opponent_actor: Actor

func _ready() -> void:
	TurnManager.end_battle.connect(_on_end_battle)
	start_battle()

func start_battle() -> void:
	print("Start next battle")
	opponent_actor.base = Refs.ACTOR_BASE_LIST.pick_random()
	opponent_actor.load_base()
	TurnManager.start_battle.emit()

func _on_end_battle() -> void:
	if not player_actor: return
	await get_tree().create_timer(3).timeout
	start_battle()
