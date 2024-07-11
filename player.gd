extends RigidBody3D

@export var speed: float = 1000

@onready var ini_pos: Vector3 = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		apply_central_force(basis.y * delta * speed)
	
	if Input.is_action_pressed("ui_left"):
		apply_torque(Vector3(0, 0, 100 * delta))
	if Input.is_action_pressed("ui_right"):
		apply_torque(Vector3(0, 0, -100 * delta))
