extends Node3D

var timer: float = 0.0
var spaces: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('Player ini')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if Input.is_action_just_pressed("ui_accept"):
		spaces += 1
		print("spaces: %s, timer: %s" % [spaces, timer])
