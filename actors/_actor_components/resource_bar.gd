class_name ResourceBar extends ProgressBar

@onready var label: Label = $Label
@export var style: StyleBox

func _ready() -> void:
	if self.has_theme_stylebox_override("fill"):
		self.remove_theme_stylebox_override("fill")
	self.add_theme_stylebox_override("fill", style)

func update(_value: int, _max: int) -> void:
	max_value = _max
	value = _value
	_update_label()

func _update_label() -> void:
	label.text = str(int(value), "/", int(max_value))
	label.pivot_offset.x = label.size.x / 2
