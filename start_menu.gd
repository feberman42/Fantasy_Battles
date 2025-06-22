class_name StartMenu extends BaseMenu

@onready var battle_manager: BattleScene = %BattleScene

func _ready() -> void:
	super._ready()

func _on_start_button_pressed() -> void:
	self._hide()
	battle_manager.start_new_run()
