extends Node2D


func _ready() -> void:
	var string = str(Global.score)
	$ScoreLabel.text = string
	if Global.save_state.high_score < Global.score:
		Global.save_state.high_score = Global.score
		Global.save_game_state()
		print("Saved new high score")
	$HighScoreNumberLabel.text = str(Global.save_state.high_score)
	Global.score = 0

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
