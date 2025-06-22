extends BaseMenu

@onready var battle_manager: BattleScene = %BattleScene

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	if self.visible == false: return
	if Input.is_action_just_pressed("char_menu"):
		Signals.toggle_menu.emit(Refs.Menu.CHARACTER)

func _update() -> void:
	%Shop.update()

func _on_button_pressed() -> void:
	Signals.toggle_menu.emit(Refs.Menu.REST)
	battle_manager.game_run.start_next_battle()
