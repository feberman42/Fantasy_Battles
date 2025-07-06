class_name CombatActionList extends PanelContainer

signal action_selected

@onready var button_container: VBoxContainer = $ButtonContainer
var button_scene: PackedScene = preload("res://actors/_actor_components/combat_action_button.tscn") 

func _ready() -> void:
	for i in range(10):
		var button: CombatActionButton = button_scene.instantiate()
		button_container.add_child(button)
		button.visible = false

func update_list(combat_actions: Array[BasicCombatAction], status: Status) -> void:
	self.visible = false
	var buttons: Array[Node] = button_container.get_children()
	for button in buttons:
		button.visible = false
	for i in range(combat_actions.size()):
		var button: CombatActionButton = buttons[i] as CombatActionButton
		var action: BasicCombatAction = combat_actions[i]
		button.initialize(action)
		button.action_button_pressed.connect(_on_button_pressed)
		if action.energy_cost > status.current_energy:
			button.disabled = true
			button.focus_mode = Control.FOCUS_NONE
		button.visible = true

func _on_button_pressed(action: BasicCombatAction):
	action_selected.emit(action)
	self.visible = false
