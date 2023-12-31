extends CharacterBody2D

@export var speed: float
@export var rotation_speed: float
var _time: float


func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position() - global_position
	var target_angle: float = mouse_pos.angle()
	
	$ParticleManager.thruster_angle(rotation, target_angle)
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	if Input.is_mouse_button_pressed(1):
		$ParticleManager.thruster_move()
		_time += delta
	else:
		$ParticleManager.thruster_off()
		_time -= delta
	
	_time = clamp(_time, 0, 1)
	
	velocity = lerp(Vector2.ZERO, Vector2(speed, 0).rotated(rotation), _time)
	move_and_slide()
