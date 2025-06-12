class_name CombatActionButton extends Button

signal action_button_pressed

var combat_action: BasicCombatAction

func initialize(_combat_action: BasicCombatAction):
	self.combat_action = _combat_action
	self.text = str(_combat_action)
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	action_button_pressed.emit(self.combat_action)
