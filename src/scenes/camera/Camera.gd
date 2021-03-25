extends Camera

export var target_path: NodePath
export var smoothing: float = 0.5

onready var target: Spatial = get_node(target_path)

var offset: Vector3

func _ready() -> void:
	offset = translation - target.translation

func _process(delta: float) -> void:
	translation = lerp(translation, target.translation + offset, smoothing)


