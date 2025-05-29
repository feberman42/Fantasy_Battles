class_name MenuLayer extends CanvasLayer

@onready var main_menu_container: PanelContainer = $MenuContainer
@onready var start_menu: CenterContainer = %StartMenu

func _ready() -> void:
	start_menu.visible = false
	main_menu_container.visible = false

func show_start_menu() -> void:
	start_menu.visible = true
	main_menu_container.visible = true
	
func hide_menus() -> void:
	for menu in get_tree().get_nodes_in_group(Refs.GROUP_MAIN_MENU):
		menu.visible = false
	main_menu_container.visible = false
