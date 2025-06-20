class_name CombatActionButton extends Button

signal action_button_pressed

var combat_action: BasicCombatAction
var hover: bool = false
var rect: Rect2
var tooltip: String

func initialize(_combat_action: BasicCombatAction):
	self.combat_action = _combat_action
	self.text = str(_combat_action)
	self.pressed.connect(_on_pressed)
	tooltip = combat_action.generate_tooltip()

func _on_pressed() -> void:
	action_button_pressed.emit(self.combat_action)
