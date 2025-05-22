extends Node

var ACTOR_BASE_PATH: String = "res://actors"
var ACTOR_BASE_LIST: Array[ActorBase]

func _ready() -> void:
	_fetch_actor_base_list()

func _fetch_actor_base_list() -> void:
	var file_names: PackedStringArray = ResourceLoader.list_directory(ACTOR_BASE_PATH)
	for file in file_names:
		if not file.ends_with(".tres"): continue
		var actor_base: ActorBase = ResourceLoader.load(ACTOR_BASE_PATH + "/" + file)
		ACTOR_BASE_LIST.append(actor_base)
		print(actor_base.resource_path, " loaded.")
