extends CharacterBody2D
class_name Projectile

var damage: float
var speed: float


func _physics_process(_delta: float) -> void:
	# Basic movement, just move forward in whatever direction you are rotated.
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()
	
	# If you hit something, call the hit function.
	if get_slide_collision_count():
		hit(get_slide_collision(0))


func hit(hit_object: KinematicCollision2D) -> void:
	# Make object hit take damage.
	hit_object.get_collider().hit(damage)
	queue_free()
