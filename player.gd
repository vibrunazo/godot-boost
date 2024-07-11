extends RigidBody3D

@export var speed: float = 1000
@export var turn_speed: float = 100

@onready var ini_pos: Vector3 = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * speed)
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0, 0, turn_speed * delta))
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0, 0, -turn_speed * delta))
