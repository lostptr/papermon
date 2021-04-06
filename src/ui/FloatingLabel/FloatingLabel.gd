extends PanelContainer

export var anchor_path: NodePath

onready var anim: AnimationPlayer = $AnimationPlayer

var anchor: Spatial
var label_offset: Vector2

func _ready() -> void:
	self_modulate.a = 0
	$VBoxContainer.modulate.a = 0
	self.visible = false
	self.label_offset = self.rect_position
	anchor = get_node(anchor_path)

func _process(delta: float) -> void:
	if visible:
		reposition_label()

func show():
	anim.play("show")

func hide():
	anim.play("hide")

func reposition_label() -> void:
	set_position(
		self.label_offset +
		Globals.camera.unproject_position(
			anchor.global_transform.origin
		)
	)
