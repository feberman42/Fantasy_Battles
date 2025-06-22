class_name GameRun extends Node

var stage: int = 0
var money: int = 0
var heal_cost: int = 10
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
	Signals.start_battle.emit()

func deduct_money(amount: int) -> bool:
	if money < amount:
		return false
	else:
		money -= amount
		Signals.money_changed.emit(money)
		return true
		
func earn_money(amount: int) -> void:
	money += amount
	Signals.money_changed.emit(money)
		
func heal() -> void:
	self.deduct_money(heal_cost)
	player.status.heal_full()
	player.update_bars()
	heal_cost *= 1.5
