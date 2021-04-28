extends Area

export(Array, String) var lines: Array = []

onready var indicator: Control = $DialogueIndicator

var in_area: bool setget set_in_area
var dialogue_ongoing: bool = false

func _ready() -> void:
	self.in_area = false
	DialogueManager.connect("dialogue_ended", self, "dialogue_ended")

func _input(event: InputEvent) -> void:
	if self.in_area and (not self.dialogue_ongoing) and event.is_action_pressed("A"):
		dialogue_ongoing = true
		DialogueManager.trigger(lines)

func dialogue_ended():
	dialogue_ongoing = false

func _on_Dialogue_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.in_area = true

func _on_Dialogue_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		self.in_area = false

func set_in_area(value: bool):
	in_area = value
	if value:
		indicator.show()
	else:
		indicator.hide()
