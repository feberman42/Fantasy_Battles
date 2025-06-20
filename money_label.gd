extends Label

func _ready() -> void:
	Signals.money_changed.connect(_update)
	
func _update(value: int) -> void:
	self.text = str(value) + "G"
