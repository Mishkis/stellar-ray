extends Timer

@export var projectile_manager: Node2D
var on_cooldown: bool = false


func attack() -> void:
	if not on_cooldown:
		projectile_manager.fire()
		on_cooldown = true
		start()


func _on_timeout() -> void:
	on_cooldown = false
