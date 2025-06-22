extends Node

signal money_changed(amount: int)
signal toggle_menu(menu: Refs.Menu)

func _ready() -> void:
	toggle_menu.connect(log_show_menu)
	
func log_show_menu(id: Refs.Menu) -> void:
	print("Menu show: ", id)
