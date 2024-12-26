extends Node2D

func _ready() -> void:
	Global.save_game_score()
	var string = Global.load_score()
	$ScoreLabel.text = string
	Global.score = 0

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
