extends CharacterBody2D

@export var speed: float
@export var rotation_speed: float
@export var hard_stop_distance: float
var _time: float


func _physics_process(delta: float) -> void:
	# Get mouse mouse distance and angle to mouse
	var mouse_distance: Vector2 = get_global_mouse_position() - global_position
	var target_angle: float = mouse_distance.angle()
	
	# Rotate towards the mouse using lerp_angle and activate according thrusters
	$ParticleManager.thruster_angle(rotation, target_angle)
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	# Calculates when to de-accelerate so that you will always reach the mouse exactly.
	# First, it gets the current speed you are traveling at.
	var current_speed: float = lerp(0.0, speed, _time)
	# Then it calculates the distance you would travel if you started de-accelerating.
	# Multiplied by _time to make it proportional to the de-acceleration of time and +15 makes it smoother.
	var distance: float = current_speed / 2 * _time + 15
	# Hard stop distance is just the distance from the ship at which point it will automatically activate.
	var hard_stop: bool = abs(mouse_distance.x) <= hard_stop_distance and abs(mouse_distance.y) <= hard_stop_distance
	# Checks if the distance that can be traveled is less than target distance to mouse, if so stop.
	var stop: bool = sqrt(mouse_distance.x**2 + mouse_distance.y**2) < distance or hard_stop
	
	# Acceleration and de-acceleration
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not stop:
		$ParticleManager.thruster_move()
		_time += delta
	else:
		$ParticleManager.thruster_off()
		_time -= delta
	
	_time = clamp(_time, 0, 1)
	
	velocity = Vector2(current_speed, 0).rotated(rotation)
	move_and_slide()
