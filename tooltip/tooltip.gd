class_name Tooltip extends Control

@onready var tooltip_node_scene: PackedScene = preload("res://tooltip/tooltip_node.tscn")
@onready var container: VBoxContainer = $VBoxContainer
@onready var parent: Control = get_parent()
var tooltip_found: bool = false

func _ready() -> void:
	self.visible = false
	var transform: Transform2D = get_global_transform()
	self.scale = Vector2(1 / transform.get_scale().x, 1 / transform.get_scale().x)
	parent.mouse_entered.connect(_on_mouse_entered)
	parent.mouse_exited.connect(_on_mouse_exited)
	for property in parent.get_property_list():
		if property["name"] == "tooltip":
			tooltip_found = true
			break
	

func build(text: String) -> void:
	for _node in container.get_children():
		_node.queue_free()
	await get_tree().process_frame # wait for old nodes to be deleted
	var node: TooltipNode = tooltip_node_scene.instantiate()
	node.initialize(text)
	container.add_child(node)

func _on_mouse_entered() -> void:
	var text: String = str("No tooltip implemented on ", parent)
	if tooltip_found:
		text = parent.tooltip
	build(text)
	global_position = get_global_mouse_position()
	visible = true

func _on_mouse_exited() -> void:
	visible = false
