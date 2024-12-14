extends Node2D


func _ready() -> void:
	var str = Global.load_score()
	$ScoreLabel.text = str
	Global.score = 0

func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
