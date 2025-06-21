class_name BaseMenu extends CanvasLayer

@export var menu_id: Refs.Menu

func _ready() -> void:
	Signals.show_menu.connect(_on_show_menu)

func _update() -> void:
	pass

func _on_show_menu(id: Refs.Menu) -> void:
	if id == self.menu_id and self.visible == false:
		_show()
	else:
		_hide()

func _show() -> void:
	_update()
	self.visible = true

func _hide() -> void:
	self.visible = false
