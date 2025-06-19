class_name Shop extends HBoxContainer

var battle_manager: BattleScene
var run: GameRun
@onready var heal_item: ShopItem = $HealItem

func _ready() -> void:
	heal_item.bought.connect(_on_heal_pressed)
	battle_manager = get_tree().get_nodes_in_group("battle_manager")[0]
	self.run = battle_manager.game_run

func update() -> void:
	heal_item.update(run.heal_cost, run)

func _on_heal_pressed(_cost: int) -> void:
	run.heal()
