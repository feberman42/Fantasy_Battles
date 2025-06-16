class_name GameRun

var stage: int = 0
var player: Actor
var opponent: Actor

func initialize(_player: Actor, _opponent: Actor) -> void:
	self.player = _player
	self.opponent = _opponent
	self.player.load_base()

func start_next_battle() -> void:
	self.stage += 1
	print("Start next battle. Stage: ", str(stage))
	opponent.base = Refs.ACTOR_BASE_LIST.pick_random()
	var enemy_level: int = floor(stage / 3) + 1
	opponent.load_base(enemy_level)
	player.update_sprite_and_name()
	TurnManager.start_battle.emit()
