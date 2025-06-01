class_name AttributeDisplay extends HBoxContainer

@onready var attribute_label: Label = $Attribute
@onready var value_label: Label = $Value
@onready var increase_button: Button = $PlusButton
@onready var decrease_button: Button = $MinusButton

var editable: bool = false

func update(attribute: String, value: int) -> void:
	attribute_label.text = attribute
	value_label.text = str(value)
	if editable:
		increase_button.visible = true
		decrease_button.visible = true
	else:
		increase_button.visible = false
		decrease_button.visible = false
