extends Node

signal dialogue_ended

# Array de strings...
func trigger(dialogue: Array):
	Globals.player.freeze()
	Globals.dialogue_box.start(dialogue)

	if not Globals.dialogue_box.is_connected("exited", self, "end"):
		Globals.dialogue_box.connect("exited", self, "end")

func end():
	Globals.player.unfreeze()
	emit_signal("dialogue_ended")
