extends Node2D

@onready var sprite = $AnimatedSprite2D
const BIRDS : Array = ["huebird", "duck_norris", "kiwi_reeves"]
var bird_index : int = 0

func _ready() -> void:
	sprite.play(BIRDS[bird_index])

func show_bird_name() -> void:
	var name = BIRDS[bird_index]
	match name:
		"huebird":
			$Label.text = "Hue Birdman"
		"duck_norris":
			$Label.text = "Duck Norris"
		"kiwi_reeves":
			$Label.text = "Kiwi Reeves"
		_:
			print("Invalid")

func _on_right_button_pressed() -> void:
	if bird_index == BIRDS.size() - 1:
		bird_index = 0
		sprite.play(BIRDS[bird_index])
	else:
		bird_index += 1
		sprite.play(BIRDS[bird_index])
	show_bird_name()


func _on_left_button_pressed() -> void:
	if bird_index == 0:
		bird_index = BIRDS.size() - 1
		sprite.play(BIRDS[bird_index])
	else:
		bird_index -= 1
		sprite.play(BIRDS[bird_index])
	show_bird_name()


func _on_select_button_pressed() -> void:
	Global.bird = BIRDS[bird_index]
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
