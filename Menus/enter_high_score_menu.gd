extends Control

var player_name : String = "Player"
var score: int

func _ready() -> void:
	self.score = Global.score
	Global.score = 0

func _on_name_input_text_submitted(text: String) -> void:
	var placement_idx = Global.local_leaderboard.register_score(text, self.score)
	Global.save_leaderboard()
	Global.local_leaderboard_view_idx = placement_idx
	get_tree().change_scene_to_file("res://Menus/leader_board_menu.tscn")

func _on_submit_button_pressed():
	_on_name_input_text_submitted($NameInput.text)
