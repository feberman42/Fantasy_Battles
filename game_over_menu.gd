extends BaseMenu

func _on_button_pressed() -> void:
	Signals.toggle_menu.emit(Refs.Menu.MAIN)
