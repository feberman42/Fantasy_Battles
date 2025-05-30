class_name BattleScene extends Node2D

@export var player_actor: Actor
@export var opponent_actor: Actor

func start_run() -> void:
	print("Start new run")
	player_actor.load_base()
	start_battle()

func start_battle() -> void:
	print("Start next battle")
	opponent_actor.base = Refs.ACTOR_BASE_LIST.pick_random()
	opponent_actor.load_base()
	TurnManager.start_battle.emit()
