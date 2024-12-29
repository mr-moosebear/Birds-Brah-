extends Node2D

var player_score : int
var scores : Array
var new_high_score : bool = false
var place : int

func _ready() -> void:
	
	$ScoreLabel.text = str(Global.score)
	player_score = int(Global.score)
	Global.score = 0
	print("Player Score is: ", player_score)
	scores = scores_list()
	check_scores(scores, player_score)
	
	if new_high_score:
		Global.high_score = player_score
		enter_high_score_menu()

func scores_list() -> Array:
	var dict = Global.load_leaderboard()
	var list : Array
	for key in dict.keys():
		var i = int(dict[key]["score"])
		list.append(i)
	return list

func check_scores(list: Array, scr: int) -> void:
	for i in list.size():
		var leaderboard_score = int(list[i])
		if scr > leaderboard_score:
			print("Your placement is ", i + 1)
			Global.placement = i + 1
			new_high_score = true
			break
		else:
			print(list[i], " Is Greater than Player Score ", scr)
			print("not placed")

func enter_high_score_menu() -> void:
	var scene_path = preload("res://Menus/enter_high_score_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
