extends Node2D

var player_score : int

func _ready() -> void:
	self.player_score = Global.score
	$ScoreLabel.text = Global.format_int_with_commas(self.player_score)

	if self.player_score > Global.local_leaderboard.get_high_score():
		$HighScoreMenu/HighScoreLabel.set_text(Global.format_int_with_commas(self.player_score))
		$HighScoreMenu.set_visible(true)
	$HighScoreNumberLabel.text = Global.format_int_with_commas(Global.local_leaderboard.get_high_score())
	Global.score = 0

func enter_high_score_menu() -> void:
	get_tree().change_scene_to_file("res://Menus/enter_high_score_menu.tscn")

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_high_score_submit_button_pressed():
	var name = $HighScoreMenu/HighScorePlayerNameInput.get_text()
	var placement_idx = Global.local_leaderboard.register_score(name, self.player_score)
	Global.save_leaderboard()
	Global.local_leaderboard_view_idx = placement_idx
	get_tree().change_scene_to_file("res://Menus/leader_board_menu.tscn")
