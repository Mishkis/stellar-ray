extends Node2D

@export var left_thrusters: Array[GPUParticles2D]
@export var right_thrusters: Array[GPUParticles2D]
@export var rotation_range: int
@export var move_speed: int
var moving: bool = false


func thruster_angle(current_angle, target_angle) -> void:
	var target_thrusters = left_thrusters if current_angle < target_angle else right_thrusters
	var set_speed = move_speed + rotation_range if moving else move_speed - rotation_range
	
	for thruster: GPUParticles2D in target_thrusters:
		thruster.emitting = true
		thruster.speed_scale = set_speed


func thruster_move() -> void:
	if not moving:
		for thruster: GPUParticles2D in left_thrusters + right_thrusters:
			thruster.emitting = true
			thruster.speed_scale = move_speed
	moving = true


func thruster_off() -> void:
	for thruster: GPUParticles2D in left_thrusters + right_thrusters:
		thruster.emitting = false
	moving = false
