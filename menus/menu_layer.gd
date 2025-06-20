class_name MenuLayer extends CanvasLayer

@onready var main_menu_container: PanelContainer = $MenuContainer
@onready var start_menu: CenterContainer = %StartMenu
@onready var rest_menu: Control = %RestMenu
@onready var game_over_menu: CenterContainer = %GameOverMenu

func show_start_menu() -> void:
	hide_menus()
	start_menu.visible = true
	main_menu_container.visible = true

func show_rest_menu() -> void:
	hide_menus()
	%Shop.update()
	rest_menu.visible = true
	main_menu_container.visible = true

func show_game_over_menu() -> void:
	hide_menus()
	game_over_menu.visible = true
	main_menu_container.visible = true
	
func hide_menus() -> void:
	for menu in get_tree().get_nodes_in_group(Refs.GROUP_MAIN_MENU):
		menu.visible = false
	main_menu_container.visible = false
