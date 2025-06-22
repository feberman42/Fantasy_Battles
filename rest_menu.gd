extends BaseMenu

@onready var battle_manager: BattleScene = %BattleScene

func _ready() -> void:
	super._ready()

func _update() -> void:
	%Shop.update()

func _on_button_pressed() -> void:
	Signals.toggle_menu.emit(Refs.Menu.REST)
	battle_manager.game_run.start_next_battle()
