extends CharacterBody2D

@export var speed: float
@export var rotation_speed: float
@export var hard_stop_distance: float
var _time: float


func _physics_process(delta: float) -> void:
	var mouse_distance: Vector2 = get_global_mouse_position() - global_position
	var target_angle: float = mouse_distance.angle()
	
	$ParticleManager.thruster_angle(rotation, target_angle)
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	var current_speed: float = lerp(0.0, speed, _time)
	var distance: float = current_speed / 2 + 15
	var hard_stop: bool = abs(mouse_distance.x) <= hard_stop_distance and abs(mouse_distance.y) <= hard_stop_distance
	var stop: bool = sqrt(mouse_distance.x**2 + mouse_distance.y**2) - distance < 0 or hard_stop
	
	if Input.is_mouse_button_pressed(1) and not stop:
		$ParticleManager.thruster_move()
		_time += delta
	else:
		$ParticleManager.thruster_off()
		_time -= delta
	
	_time = clamp(_time, 0, 1)
	
	velocity = Vector2(current_speed, 0).rotated(rotation)
	move_and_slide()
