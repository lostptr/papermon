extends RigidBody


export var speed: float = 10

onready var anim: AnimationTree = $AnimationTree
onready var animState = anim.get("parameters/playback")

var input: Vector3
var velocity: Vector3
var frozen: bool = false

func _ready() -> void:
	Globals.player = self
	anim.active = true

func _process(delta: float) -> void:
	if not frozen:
		get_input()
		handle_anim()

func _physics_process(delta: float) -> void:
	velocity = input.normalized() * speed
	apply_central_impulse(velocity * delta)

func get_input():
	input = Vector3.ZERO

	if Input.is_action_pressed("down"):
		input.z += 1
	if Input.is_action_pressed("up"):
		input.z -= 1
	if Input.is_action_pressed("left"):
		input.x -= 1
	if Input.is_action_pressed("right"):
		input.x += 1


func handle_anim():
	if input.length() > 0.1:
		var blend_pos = Vector2(input.x, input.z)
		anim.set("parameters/Idle/blend_position", blend_pos)
		anim.set("parameters/Walk/blend_position", blend_pos)
		animState.travel("Walk")
	else:
		animState.travel("Idle")

func freeze():
	frozen = true
	input = Vector3.ZERO

func unfreeze():
	frozen = false
