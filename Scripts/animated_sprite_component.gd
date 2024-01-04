extends AnimatedSprite2D

signal attacked


func idle() -> void:
	play("Idle")


func attack() -> void:
	if animation != "Reload":
		attacked.emit()
		play("Reload")
