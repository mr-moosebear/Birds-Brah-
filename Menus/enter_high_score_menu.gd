extends Control

var player_name : String = "Player"
var leader_dict : Dictionary
var player_score : String = "9500"
var player_place : String = "2"
var new_dict : Dictionary

func _ready() -> void:
	#player_place = str(Global.placement)
	#player_score = str(Global.high_score)
	$ScoreLabel.text = player_score
	leader_dict = Global.load_leaderboard()

func reset_leaderboard_dictionary(dict: Dictionary, place: String) -> Dictionary:
	var temp_dict : Dictionary ={}
	for i in range(dict.size()):
		if i <= int(place):
			#print(i, " is less than ", int(place))
			temp_dict[str(i + 1)] = dict[str(i + 1)]
		else:
			temp_dict[str(i)] = dict[str(i - 1)]
		if i + 1 == 10:
			temp_dict[str(i + 1)] = dict[str(i)]
	return temp_dict

func set_player_info(dict: Dictionary, place: String, player: String, score: String) -> Dictionary:
	var t_dict = dict.duplicate()
	t_dict.erase(place)
	t_dict[place] = {}
	t_dict[place]["name"] = player
	t_dict[place]["score"] = score
	return t_dict

func _on_submit_button_pressed() -> void:
	new_dict = reset_leaderboard_dictionary(leader_dict, player_place)
	var modified_dict = set_player_info(new_dict, player_place, player_name, player_score)
	#Global.save_leaderboard(modified_dict)
	#get_tree().change_scene_to_file("res://Menus/leader_board_menu.tscn")
	print(modified_dict)

func _on_name_input_text_changed(new_text: String) -> void:
	player_name = new_text
	print("Player Name is: ", player_name)

func _on_name_input_text_submitted(new_text: String) -> void:
	_on_submit_button_pressed()
