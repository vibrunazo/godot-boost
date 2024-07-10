extends Node3D

@export var speed: float = 2.0
@export var gravity: float = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		position.y += delta * speed
	if position.y >= 0:
		position.y -= delta * gravity
	position.y = maxf(0, position.y)
	
	if Input.is_action_pressed("ui_left"):
		rotate_z(delta)
	if Input.is_action_pressed("ui_right"):
		rotate_z(-delta)
