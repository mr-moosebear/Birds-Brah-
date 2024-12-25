extends Node2D

func _process(delta: float) -> void:
	self.position.x += -5


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Goodbye")
	queue_free()
