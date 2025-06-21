extends Node

signal money_changed(amount: int)
signal show_menu(menu: Refs.Menu)

func _ready() -> void:
	show_menu.connect(log_show_menu)
	
func log_show_menu(id: Refs.Menu) -> void:
	print("Menu show: ", id)
