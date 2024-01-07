extends CollisionShape2D

signal got_hit

@export var immunity_time: float
@export_group("Constant")
@export var damage_number: PackedScene
@export var timer: Timer


func _ready() -> void:
	timer.wait_time = immunity_time


func hit(average_damage: float, damage: float) -> void:
	if not disabled:
		disabled = true
		
		timer.start()
		
		var damage_text: Label = damage_number.instantiate().get_node("AnimatedScale/Label")
		
		damage_text.text = str(damage)
		
		if  damage > average_damage:
			damage_text.text += "!"
		
		var control: Control = damage_text.get_parent().get_parent()
		
		control.scale = Vector2.ONE * damage / average_damage
		control.position = global_position + Vector2(randi_range(-5, 5), randi_range(-5, 5))
		control.rotation = randf_range(-PI/10, PI/10)
		
		get_tree().root.add_child(control)
		
		got_hit.emit(damage)


func _on_timer_timeout() -> void:
	disabled = false
