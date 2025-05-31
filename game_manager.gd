class_name GameManager extends Node2D

@onready var battle_manager: BattleScene = $BattleScene
@onready var menu_layer: MenuLayer = $MenuLayer

func _ready() -> void:
	TurnManager.end_battle.connect(_on_end_battle)
	menu_layer.visible = true
	menu_layer.show_start_menu()

func _on_button_pressed() -> void:
	menu_layer.hide_menus()
	battle_manager.start_run()

func _on_main_menu_button_pressed() -> void:
	menu_layer.show_start_menu()

func _on_continue_button_pressed() -> void:
	menu_layer.hide_menus()
	battle_manager.start_battle()

func _on_end_battle(winner: Actor) -> void:
	if winner.is_in_group(Refs.GROUP_PLAYER):
		menu_layer.show_rest_menu()
	else:
		menu_layer.show_game_over_menu()
