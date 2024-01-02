extends VisibleOnScreenNotifier2D


func _on_screen_exited() -> void:
	get_parent().queue_free()
