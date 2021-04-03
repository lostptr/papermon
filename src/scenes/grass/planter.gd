tool
extends MultiMeshInstance

const MeshFactory = preload("res://scenes/grass/mesh_factory.gd")

export var span: Vector2 = Vector2(1.0, 1.0) setget set_span
export var density: int = 65 setget set_density
export var width: Vector2 = Vector2(0.3, 0.5) setget set_width
export var height: Vector2 = Vector2(0.4, 0.6) setget set_height
export var sway_yaw: Vector2 = Vector2(0.0, 10.0) setget set_sway_yaw
export var sway_pitch: Vector2 = Vector2(0.0, 10.0) setget set_sway_pitch

func _init() -> void:
	rebuild()

func _ready() -> void:
	rebuild()

func rebuild():
	multimesh = MultiMesh.new()
	multimesh.instance_count = 0
	multimesh.mesh = MeshFactory.simple_grass()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.set_custom_data_format(MultiMesh.CUSTOM_DATA_FLOAT)
	multimesh.set_color_format(MultiMesh.COLOR_NONE)
	multimesh.instance_count = get_count()

	for i in (multimesh.instance_count):
		var pos = Vector3(rand_range(-span.x, span.x), 0.0, rand_range(-span.y, span.y))
		var basis = Basis(Vector3.UP, deg2rad(rand_range(0, 359)))
		multimesh.set_instance_transform(i, Transform(basis, pos))
		multimesh.set_instance_custom_data(i, Color(
			rand_range(width.x, width.y),
			rand_range(height.x, height.y),
			deg2rad(rand_range(sway_pitch.x, sway_pitch.y)),
			deg2rad(rand_range(sway_yaw.x, sway_yaw.y))
		))


func set_span(new_value: Vector2):
	span = new_value
	rebuild()

func get_count() -> int:
	return int(span.x * span.y * density)

func set_density(new_value: int):
	density = new_value
	rebuild()

func set_width(new_value: Vector2):
	width = new_value
	rebuild()

func set_height(new_value: Vector2):
	height = new_value
	rebuild()

func set_sway_yaw(new_value: Vector2):
	sway_yaw = new_value
	rebuild()

func set_sway_pitch(new_value: Vector2):
	sway_pitch = new_value
	rebuild()
