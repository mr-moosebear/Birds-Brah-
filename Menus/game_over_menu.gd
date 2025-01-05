extends Node2D

var player_score : int

func _ready() -> void:
	self.player_score = Global.score
	$ScoreLabel.text = str(self.player_score)

	if self.player_score > Global.local_leaderboard.get_high_score():
		enter_high_score_menu()
	else:
		Global.score = 0
	$HighScoreNumberLabel.text = Global.format_int_with_commas(Global.local_leaderboard.get_high_score())

func enter_high_score_menu() -> void:
	get_tree().change_scene_to_file("res://Menus/enter_high_score_menu.tscn")

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
