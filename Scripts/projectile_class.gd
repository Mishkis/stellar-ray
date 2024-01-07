extends CharacterBody2D
class_name Projectile

var average_damage: float
var speed: float
var pierce: int


func _physics_process(_delta: float) -> void:
	# Basic movement, just move forward in whatever direction you are rotated.
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()
	
	# If you hit something, call the hit function.
	if get_slide_collision_count():
		hit(get_slide_collision(0))


func hit(hit_object: KinematicCollision2D) -> void:
	var damage: float = average_damage * randf_range(0.8, 1.2)
	damage = roundf(damage * 10) / 10
	
	# Make object hit take damage.
	hit_object.get_collider().hit(average_damage, damage)
	pierce -= 1
	if pierce <= 0:
		queue_free()
