class_name CombatActionList extends ItemList

func update_list(combat_actions: Array[BasicCombatAction]) -> void:
	self.clear()
	for action in combat_actions:
		var index: int = self.add_item(str(action))
		self.set_item_tooltip(index, action.generate_tooltip())
