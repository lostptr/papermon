tool
extends Spatial

export var span: Vector2 = Vector2(5.0, 5.0) setget set_span
export var reset_meshes: bool = false setget set_reset_meshes

func reset():
	if get_node_or_null("GrassMesh") != null:
		$GrassMesh.multimesh = null
		$GrassMesh.rebuild()
	if get_node_or_null("UnderPlane") != null:
		$UnderPlane.mesh = PlaneMesh.new()

func set_span(new_value: Vector2):
	span = new_value
	if get_node_or_null("GrassMesh") != null:
		$GrassMesh.span = span

	if get_node_or_null("UnderPlane") != null:
		$UnderPlane.mesh = PlaneMesh.new()
		$UnderPlane.mesh.size = span * 2

func set_reset_meshes(_new_value: bool):
	reset()
