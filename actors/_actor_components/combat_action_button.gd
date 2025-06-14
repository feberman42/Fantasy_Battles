class_name CombatActionButton extends Button

signal action_button_pressed

var combat_action: BasicCombatAction
var hover: bool = false
var rect: Rect2

func initialize(_combat_action: BasicCombatAction):
	self.combat_action = _combat_action
	self.text = str(_combat_action)
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	action_button_pressed.emit(self.combat_action)

func _on_mouse_entered() -> void:
	var _tooltip_text: String = combat_action.generate_tooltip()
	Refs.TOOLTIP.build(_tooltip_text)
	Refs.TOOLTIP.global_position = get_global_mouse_position()
	Refs.TOOLTIP.visible = true

func _on_mouse_exited() -> void:
	Refs.TOOLTIP.visible = false
