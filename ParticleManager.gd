extends Node2D

@export var left_thrusters: Array[GPUParticles2D]
@export var right_thrusters: Array[GPUParticles2D]
var moving: bool = false


func thruster_angle(current_angle, target_angle) -> void:
	var target_thrusters = left_thrusters if angle_difference(target_angle, current_angle) < 0 else right_thrusters
	
	for thruster: GPUParticles2D in left_thrusters + right_thrusters:
		if thruster in target_thrusters and abs(angle_difference(target_angle, current_angle)) > 0.1:
			thruster.emitting = true
		elif not moving:
			thruster.emitting = false


func thruster_move() -> void:
	if not moving:
		for thruster: GPUParticles2D in left_thrusters + right_thrusters:
			thruster.emitting = true
	moving = true


func thruster_off() -> void:
	if moving:
		for thruster: GPUParticles2D in left_thrusters + right_thrusters:
			thruster.emitting = false
	moving = false
