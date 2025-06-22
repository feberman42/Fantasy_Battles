class_name GameManager extends Node2D

@onready var battle_manager: BattleScene = $BattleScene
@onready var menu_layer: MenuLayer = $MenuLayer

func _ready() -> void:
	TurnManager.end_battle.connect(_on_end_battle)
	Signals.toggle_menu.emit(Refs.Menu.MAIN)

func _on_end_battle(winner: Actor) -> void:
	if winner.is_in_group(Refs.GROUP_PLAYER):
		battle_manager.game_run.earn_money(9)
		Signals.toggle_menu.emit(Refs.Menu.REST)
	else:
		Signals.toggle_menu.emit(Refs.Menu.GAME_OVER)
