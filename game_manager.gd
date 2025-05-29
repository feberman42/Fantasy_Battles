class_name GameManager extends Node2D

@onready var battle_manager: BattleScene = $BattleScene
@onready var menu_layer: MenuLayer = $MenuLayer

func _ready() -> void:
	menu_layer.show_start_menu()

func _on_button_pressed() -> void:
	menu_layer.hide_menus()
	battle_manager.start_battle()
	
