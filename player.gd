extends RigidBody3D

## How much vertical force to apply when moving
@export_range(750, 3000) var thrust: float = 1000
@export_range(50, 300) var torque_thrust: float = 100

@onready var explosion_audio: AudioStreamPlayer = $ExplosionAudio
@onready var success_audio: AudioStreamPlayer = $SuccessAudio
@onready var rocket_audio: AudioStreamPlayer3D = $RocketAudio
@onready var rcs_audio: AudioStreamPlayer3D = $RCSAudio
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles

@onready var ini_pos: Vector3 = position

var is_ready: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_ready: return
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * thrust)
		if not rocket_audio.playing:
			rocket_audio.play()
			booster_particles.emitting = true
	else:
		rocket_audio.stop()
		booster_particles.emitting = false
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(Vector3(0, 0, torque_thrust * delta))
		if not rcs_audio.playing:
			rcs_audio.play()
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(Vector3(0, 0, -torque_thrust * delta))
		if not rcs_audio.playing:
			rcs_audio.play()
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false
		#if not Input.is_action_pressed("rotate_right"):
			#rcs_audio.stop()
	if not Input.is_action_pressed("rotate_right") and not Input.is_action_pressed("rotate_left"):
		rcs_audio.stop()

func disable_controls() -> void:
	is_ready = false
	set_process(false)
	rocket_audio.stop()
	booster_particles.emitting = false
	right_booster_particles.emitting = false
	left_booster_particles.emitting = false
	rcs_audio.stop()
	
func crash_sequence() -> void:
	print('die')
	disable_controls()
	explosion_audio.play()
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
	
func complete_level(next_level: String) -> void:
	print('win')
	disable_controls()
	success_audio.play()
	await get_tree().create_timer(3).timeout
	if next_level.is_empty():
		get_tree().reload_current_scene()
		return
	get_tree().change_scene_to_file(next_level)

func _on_body_entered(body: Node) -> void:
	if not is_ready: return
	print(body.name)
	if body is Landingpad:
		complete_level(body.next_level)
	if body.is_in_group("hazard"):
		crash_sequence()
