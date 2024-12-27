extends Node2D

var player_score : int

func _ready() -> void:
	Global.save_game_score()
	var string = Global.load_score()
	$ScoreLabel.text = string
	player_score = int(string)
	Global.score = 0
	print("Player Score is: ", player_score)
	foo()

func foo() -> void:
	var dict = $CompLoadGameScores.load_leaderboard()
	var scores : Array
	for key in dict.keys():
		var i = int(dict[key]["score"])
		scores.append(i)
	check_scores(scores, player_score)

func check_scores(list: Array, scr: int) -> void:
	for i in list.size():
		var j = int(list[i])
		if scr > j:
			print("Your placement is ", i + 1)
			break
		else:
			print("not placed")

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
