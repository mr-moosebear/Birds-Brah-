extends Control

func _ready() -> void:
	var labels = [
		{"placement": $NumberPlaceLabels/Label, "name": $NameLabels/Label, "score": $ScoreLabels/Label},
		{"placement": $NumberPlaceLabels/Label2, "name": $NameLabels/Label2, "score": $ScoreLabels/Label2},
		{"placement": $NumberPlaceLabels/Label3, "name": $NameLabels/Label3, "score": $ScoreLabels/Label3},
		{"placement": $NumberPlaceLabels/Label4, "name": $NameLabels/Label4, "score": $ScoreLabels/Label4},
		{"placement": $NumberPlaceLabels/Label5, "name": $NameLabels/Label5, "score": $ScoreLabels/Label5},
		{"placement": $NumberPlaceLabels/Label6, "name": $NameLabels/Label6, "score": $ScoreLabels/Label6},
		{"placement": $NumberPlaceLabels/Label7, "name": $NameLabels/Label7, "score": $ScoreLabels/Label7},
		{"placement": $NumberPlaceLabels/Label8, "name": $NameLabels/Label8, "score": $ScoreLabels/Label8},
		{"placement": $NumberPlaceLabels/Label9, "name": $NameLabels/Label9, "score": $ScoreLabels/Label9},
		{"placement": $NumberPlaceLabels/Label10, "name": $NameLabels/Label10, "score": $ScoreLabels/Label10}
	]
	var view_radius = labels.size() / 2
	var lower_limit = max(Global.local_leaderboard_view_idx - view_radius, 0)
	var upper_limit = min(lower_limit + labels.size(), Global.local_leaderboard.size())
	# blank all the labels
	for placement_labels in labels:
		placement_labels["placement"].text = ""
		placement_labels["name"].text = ""
		placement_labels["score"].text = ""
	# populate the labels
	for placement in range(lower_limit, upper_limit):
		var placement_label_idx = placement - lower_limit
		var score_item = Global.local_leaderboard.get_score_at_index(placement)
		var score_name = score_item[Global.local_leaderboard.PLACEMENT_NAME]
		var score_int = score_item[Global.local_leaderboard.PLACEMENT_SCORE]
		labels[placement_label_idx]["placement"].text = Global.format_int_with_commas(placement + 1) + "."
		labels[placement_label_idx]["name"].text = score_name
		labels[placement_label_idx]["score"].text = Global.format_int_with_commas(score_int)
		

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
