class_name BattleScene extends Node2D

@export var player_actor: Actor
@export var opponent_actor: Actor
var game_run: GameRun = GameRun.new()

func _process(delta: float) -> void:
	if not player_actor.wait_for_input:
		return
	if Input.is_action_just_pressed("char_menu"):
		Signals.toggle_menu.emit(Refs.Menu.CHARACTER)

func start_new_run() -> void:
	print("Start new run")
	self.game_run.initialize(self.player_actor, self.opponent_actor)
	self.game_run.start_next_battle()
