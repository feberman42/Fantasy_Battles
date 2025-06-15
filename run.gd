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
	opponent.load_base()
	TurnManager.start_battle.emit()
