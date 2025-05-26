extends Node

var ACTOR_BASE_PATH: String = "res://actors"
var ACTOR_BASE_LIST: Array[ActorBase]

func _ready() -> void:
	_fetch_actor_base_list()

func _fetch_actor_base_list() -> void:
	var actor_dirs: PackedStringArray = ResourceLoader.list_directory(ACTOR_BASE_PATH)
	for actor_dir in actor_dirs:
		var file: String = actor_dir.rstrip("/") + ".tres"
		var path: String = ACTOR_BASE_PATH + "/" + actor_dir + file
		if not ResourceLoader.exists(path):
			continue
		var actor_base: ActorBase = ResourceLoader.load(ACTOR_BASE_PATH + "/" + actor_dir + file)
		if not actor_base:
			print("Couldn't load: ", file)
			continue
		ACTOR_BASE_LIST.append(actor_base)
		print(actor_base.resource_path, " loaded.")
