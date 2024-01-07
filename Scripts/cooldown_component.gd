extends Timer

signal off_cooldown


func activate() -> void:
	if is_stopped():
		off_cooldown.emit()
		start()
