class_name AttributeDisplay extends HBoxContainer

signal increase(attribute: String)

@onready var attribute_label: Label = $Attribute
@onready var value_label: Label = $Value
@onready var increase_button: Button = $PlusButton
@onready var decrease_button: Button = $MinusButton

func _ready() -> void:
	increase_button.pressed.connect(_on_increase_button_pressed)

func update(attribute: String, value: int, points_available: bool) -> void:
	attribute_label.text = attribute
	value_label.text = str(value)
	if points_available:
		increase_button.visible = true
		decrease_button.visible = false
	else:
		increase_button.visible = false
		decrease_button.visible = false

func _on_increase_button_pressed() -> void:
	increase.emit(attribute_label.text)
