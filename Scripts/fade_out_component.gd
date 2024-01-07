extends Timer


func _process(_delta: float) -> void:
	get_parent().modulate.a = time_left / wait_time


func _on_timeout() -> void:
	get_parent().queue_free()
