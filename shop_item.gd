class_name ShopItem extends Control

signal bought(cost: int)

@onready var button: Button = %Button
@onready var label: Label = %Label
var cost: int
var only_once: bool = true
var buyable: bool = true

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	self.visibility_changed.connect(_reset)

func _reset() -> void:
	self.buyable = true

func update(_cost: int, run: GameRun) -> void:
	button.disabled = true
	self.cost = _cost
	label.text = str(self.cost) + "G"
	if _can_afford(run) and buyable:
		button.disabled = false
	
func _can_afford(run: GameRun) -> bool:
	if self.cost > run.money:
		return false
	else:
		return true

func _on_button_pressed() -> void:
	if only_once:
		buyable = false
		button.disabled = true
	bought.emit(cost)
	
func _on_mouse_entered() -> void:
	print("test")
	var _tooltip_text: String = "Heal your party."
	$Tooltip.build(_tooltip_text)
	$Tooltip.global_position = get_global_mouse_position()
	$Tooltip.visible = true

func _on_mouse_exited() -> void:
	$Tooltip.visible = false
