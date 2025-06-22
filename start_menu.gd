class_name StartMenu extends BaseMenu

@onready var battle_manager: BattleScene = %BattleScene

func _ready() -> void:
	super._ready()

func _on_start_button_pressed() -> void:
	Signals.toggle_menu.emit(Refs.Menu.MAIN)
	battle_manager.start_new_run()
