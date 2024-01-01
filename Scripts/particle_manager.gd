extends Node2D

@export var left_thrusters: Array[GPUParticles2D]
@export var right_thrusters: Array[GPUParticles2D]
var moving: bool = false


func thruster_angle(current_angle: float, target_angle: float) -> void:
	# Get the thruster you are using based on the difference of angles.
	var target_thrusters: Array[GPUParticles2D] = left_thrusters if angle_difference(target_angle, current_angle) < 0 else right_thrusters
	
	# Activate the correct thruster.
	for thruster: GPUParticles2D in left_thrusters + right_thrusters:
		# Get the distance between the angles as otherwise it will make micro adjustments that look bad.
		if thruster in target_thrusters and abs(angle_difference(target_angle, current_angle)) > 0.1:
			thruster.emitting = true
		elif not moving:
			thruster.emitting = false


func thruster_move() -> void:
	# Fired once if not moving, turns everything on.
	if not moving:
		for thruster: GPUParticles2D in left_thrusters + right_thrusters:
			thruster.emitting = true
	moving = true


func thruster_off() -> void:
	# Fired once if moving, turns everything off.
	if moving:
		for thruster: GPUParticles2D in left_thrusters + right_thrusters:
			thruster.emitting = false
	moving = false
