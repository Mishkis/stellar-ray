extends Timer

signal off_cooldown

var on_cooldown: bool = false


func activate() -> void:
	if not on_cooldown:
		off_cooldown.emit()
		on_cooldown = true
		start()


func _on_timeout() -> void:
	on_cooldown = false
