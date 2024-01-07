extends Node2D

@export_group("Spawning Instructions", "spawn_")
@export var spawn_projectile: PackedScene
@export_range(0, 360, 1, "radians") var spawn_rotation_range: float
@export var spawn_spread_range: float
@export var spawn_count: int
@export_group("Projectile Stats", "projectile_")
@export var projectile_damage: float
@export var projectile_speed: float
@export var projectile_pierce: int


func fire() -> void:
	for spawn_location: Marker2D in get_children():
		for i: int in range(spawn_count):
			var projectile_instance: Projectile = spawn_projectile.instantiate()
			
			var projectile_position: Vector2 = spawn_location.global_position
			var projectile_rotation: float = spawn_location.global_rotation
			
			if spawn_count != 1:
				var start_point: float = spawn_spread_range / 2.0
				var position_added: float = spawn_spread_range / (spawn_count - 1)
				projectile_position += Vector2(0, position_added * i - start_point).rotated(projectile_rotation)
				
				var start_rotation_point: float = spawn_rotation_range / 2.0
				var rotation_added: float = spawn_rotation_range / (spawn_count - 1)
				projectile_rotation += rotation_added * i - start_rotation_point
				
				if i >= spawn_count / 2.0:
					projectile_instance.scale.y *= -1
			
			projectile_instance.position = projectile_position
			projectile_instance.rotation = projectile_rotation
			
			projectile_instance.average_damage = projectile_damage
			projectile_instance.speed = projectile_speed
			projectile_instance.pierce = projectile_pierce
			
			projectile_instance.z_index = -5
			
			get_tree().root.add_child(projectile_instance)
