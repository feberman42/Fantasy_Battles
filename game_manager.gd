class_name GameManager extends Node2D

@onready var battle_manager: BattleScene = $BattleScene
@onready var menu_layer: CanvasLayer = $MenuLayer

func _on_button_pressed() -> void:
	menu_layer.visible = false
	battle_manager.start_battle()
