extends Node2D




func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_bird_select_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/character_select_menu.tscn")
