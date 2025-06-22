class_name GameManager extends Node2D

enum GameState
{
	BATTLE,
	REST,
	MAIN_MENU,
	GAME_OVER,
}

@onready var battle_manager: BattleScene = $BattleScene

var current_state: GameState

func _ready() -> void:
	TurnManager.end_battle.connect(_on_end_battle)
	Signals.start_battle.connect(_on_battle_start)
	Signals.toggle_menu.connect(_on_toggle_menu)
	Signals.toggle_menu.emit(Refs.Menu.MAIN)

func _on_toggle_menu(id: Refs.Menu) -> void:
	match id:
		Refs.Menu.MAIN:
			self.current_state = GameState.MAIN_MENU
		Refs.Menu.GAME_OVER:
			self.current_state = GameState.GAME_OVER
		Refs.Menu.REST:
			self.current_state = GameState.REST
		_:
			pass

func _on_battle_start() -> void:
	self.current_state = GameState.BATTLE

func _on_end_battle(winner: Actor) -> void:
	if winner.is_in_group(Refs.GROUP_PLAYER):
		battle_manager.game_run.earn_money(9)
		Signals.toggle_menu.emit(Refs.Menu.REST)
	else:
		Signals.toggle_menu.emit(Refs.Menu.GAME_OVER)
