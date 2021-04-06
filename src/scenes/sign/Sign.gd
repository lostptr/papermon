extends Spatial

onready var label: Control = $FloatingLabel

var in_area: bool setget set_in_area

func _ready() -> void:
	self.in_area = false

func _on_Area_body_entered(body: Node) -> void:
	self.in_area = true

func _on_Area_body_exited(body: Node) -> void:
	self.in_area = false

func set_in_area(value: bool):
	in_area = value
	if value:
		label.show()
	else:
		label.hide()
