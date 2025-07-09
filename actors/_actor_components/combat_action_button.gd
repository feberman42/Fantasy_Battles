class_name CombatActionButton extends Button

signal action_button_pressed

var combat_action: BasicCombatAction
var hover: bool = false
var rect: Rect2
var tooltip: String
var tooltip_pos: Vector2

func _enter_tree() -> void:
	self.pressed.connect(_on_pressed)

func initialize(_combat_action: BasicCombatAction):
	self.combat_action = _combat_action
	self.text = str(_combat_action)
	tooltip = combat_action.generate_tooltip()
	tooltip_pos = Vector2(global_position.x + (size.x * get_global_transform().get_scale().x), global_position.y)

func _on_pressed() -> void:
	action_button_pressed.emit(self.combat_action)
