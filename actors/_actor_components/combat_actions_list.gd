class_name CombatActionList extends PanelContainer

signal action_selected

@onready var button_container: VBoxContainer = $ButtonContainer
var button_scene: PackedScene = preload("res://actors/_actor_components/combat_action_button.tscn") 

func update_list(combat_actions: Array[BasicCombatAction], status: Status) -> void:
	for button in button_container.get_children():
		button.queue_free()
	await get_tree().process_frame # wait for old buttons to be deleted
	for action in combat_actions:
		var button: CombatActionButton = button_scene.instantiate()
		button.initialize(action)
		button.action_button_pressed.connect(_on_button_pressed)
		if action.energy_cost > status.current_energy:
			button.disabled = true
			button.focus_mode = Control.FOCUS_NONE
		button_container.add_child(button)
		#var index: int = self.add_item(str(action))
		#self.set_item_tooltip(index, action.generate_tooltip())

func _on_button_pressed(action: BasicCombatAction):
	action_selected.emit(action)
	self.visible = false
