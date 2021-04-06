extends Camera

export var target_path: NodePath
export var smoothing: float = 0.5

onready var target: Spatial = get_node(target_path)

var offset: Vector3

func _ready() -> void:
	Globals.camera = self
	offset = translation - target.translation

func _physics_process(_delta: float) -> void:
	translation = lerp(translation, target.translation + offset, smoothing)


