class_name Actor extends Sprite2D

@export var base: ActorBase
var current_stats: Stats = Stats.new()
var status: Status = Status.new()

@onready var health_bar: ProgressBar = $HealthBar

var wait_for_input: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = base.sprite
	_calculate_stats()
	status.initialize(current_stats)
	health_bar.update()
	TurnManager.turn_start.connect(_on_turn_start)

func _on_turn_start(actor: Actor) -> void:
	if actor != self: return
	if self.is_in_group("player"):
		wait_for_input = true
		return
	else:
		await get_tree().create_timer(0.5).timeout
		print(self, " acted")
		TurnManager.turn_end.emit(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not wait_for_input: return
	if Input.is_action_just_pressed("ui_accept"):
		wait_for_input = false
		TurnManager.turn_end.emit(self)
		
func _calculate_stats() -> void:
	current_stats.health = base.stats.health
	current_stats.energy = base.stats.energy
	current_stats.attack = base.stats.attack
	current_stats.defence = base.stats.defence
	current_stats.intelligence = base.stats.intelligence
	current_stats.resistance = base.stats.resistance
