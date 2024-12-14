extends Control

func _process(delta: float) -> void:
	update_score()

func update_score() -> void:
	var scr = str(Global.score)
	$Label.text = scr

func _on_timer_timeout() -> void:
	Global.score += 1000
