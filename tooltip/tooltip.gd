class_name Tooltip_container extends Control

@onready var tooltip_node_scene: PackedScene = preload("res://tooltip/tooltip_node.tscn")
@onready var container: VBoxContainer = $VBoxContainer

func _enter_tree() -> void:
	Refs.TOOLTIP = self

func build(text: String) -> void:
	for _node in container.get_children():
		_node.queue_free()
	await get_tree().process_frame # wait for old nodes to be deleted
	var node: TooltipNode = tooltip_node_scene.instantiate()
	node.initialize(text)
	container.add_child(node)
