class_name Shop extends HBoxContainer

var battle_manager: BattleScene
var run: GameRun
@onready var heal_button: Button = %HealButton

func _ready() -> void:
	battle_manager = get_tree().get_nodes_in_group("battle_manager")[0]
	self.run = battle_manager.game_run

func update() -> void:
	if run.heal_cost > run.money:
		heal_button.disabled = true
	else:
		heal_button.disabled = false

func _on_heal_pressed() -> void:
	print("Button pressed")
	heal_button.disabled = true
	if battle_manager.game_run.deduct_money(10):
		for actor: Actor in get_tree().get_nodes_in_group("player"):
			actor.status.heal_full()
			actor.update_bars()
