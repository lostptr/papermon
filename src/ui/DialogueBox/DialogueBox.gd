extends Panel

signal exited

onready var anim: AnimationPlayer = $AnimationPlayer
onready var timer: Timer = $TypeTimer
onready var label: RichTextLabel = $MarginContainer/RichTextLabel

var is_active: bool = false
var lines: Array
var current_line_index: int
var current_line: String setget , get_current_line
var is_typing: bool = false

func _ready() -> void:
	Globals.dialogue_box = self

func _input(event: InputEvent) -> void:
	if is_active and event.is_action_pressed("A"):
		if self.is_typing:
			stop_typing()
		else:
			advance()

func start(dialogue: Array):
	current_line_index = -1
	label.bbcode_text = ""
	self.lines = dialogue
	yield(enter(), "completed")
	is_active = true
	advance()

func enter():
	label.visible_characters = 0
	anim.play("enter")
	yield(anim, "animation_finished")

func advance():
	current_line_index += 1
	if current_line_index < len(lines):
		start_typing()
	else:
		exit()

func start_typing():
	self.is_typing = true
	label.visible_characters = 1
	label.bbcode_text = self.current_line
	timer.start()

func type():
	label.visible_characters += 1
	if label.visible_characters >= len(label.text):
		stop_typing()

func stop_typing():
	timer.stop()
	label.visible_characters = -1
	self.is_typing = false

func exit():
	is_active = false
	anim.play("exit")
	yield(anim, "animation_finished")
	emit_signal("exited")

func get_current_line() -> String:
	return lines[current_line_index]

func _on_TypeTimer_timeout() -> void:
	type()
