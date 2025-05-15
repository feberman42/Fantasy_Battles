extends Node

signal turn_start(actor:Actor)
signal turn_end(actor:Actor)

var active_actors: Array[Actor]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn_end.connect(_on_turn_end)
	_load_actors()
	await get_tree().create_timer(1).timeout #replace with ui 
	_next_turn()

func _load_actors() -> void:
	var actor_group: Array[Node] = get_tree().get_nodes_in_group("actor")
	for node in actor_group:
		active_actors.append(node as Actor)

func _next_turn() -> void:
	var active_actor: Actor = active_actors.pop_front()
	active_actors.push_back(active_actor)
	print("Turn start: ", active_actor)
	turn_start.emit(active_actor)

func _on_turn_end(actor:Actor) -> void:
	print("Turn end: ", actor)
	await get_tree().create_timer(0.5).timeout
	_next_turn()
