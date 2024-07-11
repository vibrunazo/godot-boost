extends Node3D

@export var speed: float = 2.0
@export var gravity: float = 1.0

@onready var ini_pos: Vector3 = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		position.y += delta * speed
	if position.y >= ini_pos.y:
		position.y -= delta * gravity
	position.y = maxf(ini_pos.y, position.y)
	
	if Input.is_action_pressed("ui_left"):
		rotate_z(delta)
	if Input.is_action_pressed("ui_right"):
		rotate_z(-delta)
