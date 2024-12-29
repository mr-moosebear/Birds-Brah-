extends Control

var leaderboard : Dictionary

func _ready() -> void:
	leaderboard = Global.load_leaderboard()
	set_leaderboard_names(leaderboard)
	set_leaderboard_scores(leaderboard)


func set_leaderboard_scores(dict: Dictionary) -> void:
	$ScoreLabels/Label.text = dict["1"]["score"]
	$ScoreLabels/Label2.text = dict["2"]["score"]
	$ScoreLabels/Label3.text = dict["3"]["score"]
	$ScoreLabels/Label4.text = dict["4"]["score"]
	$ScoreLabels/Label5.text = dict["5"]["score"]
	$ScoreLabels/Label6.text = dict["6"]["score"]
	$ScoreLabels/Label7.text = dict["7"]["score"]
	$ScoreLabels/Label8.text = dict["8"]["score"]
	$ScoreLabels/Label9.text = dict["9"]["score"]
	$ScoreLabels/Label10.text = dict["10"]["score"]
	
func set_leaderboard_names(dict: Dictionary) -> void:
	$NameLabels/Label.text = dict["1"]["name"]
	$NameLabels/Label2.text = dict["2"]["name"]
	$NameLabels/Label3.text = dict["3"]["name"]
	$NameLabels/Label4.text = dict["4"]["name"]
	$NameLabels/Label5.text = dict["5"]["name"]
	$NameLabels/Label6.text = dict["6"]["name"]
	$NameLabels/Label7.text = dict["7"]["name"]
	$NameLabels/Label8.text = dict["8"]["name"]
	$NameLabels/Label9.text = dict["9"]["name"]
	$NameLabels/Label10.text = dict["10"]["name"]


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
