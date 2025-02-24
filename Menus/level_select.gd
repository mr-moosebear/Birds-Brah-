extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var high_score = Global.local_leaderboard.get_high_score()
	if high_score >= 30000:
		$LevelBackground2/LockedControl.set_visible(false)
		$LevelBackground2/Level2Button.set_disabled(false)
	if high_score >= 60000:
		$LevelBackground3/LockedControl.set_visible(false)
		$LevelBackground3/Level3Button.set_disabled(false)
	if high_score >= 90000:
		$LevelBackground4/LockedControl.set_visible(false)
		$LevelBackground4/Level4Button.set_disabled(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func load_level(level: PackedScene):
	Global.selected_level = level
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_level_1_button_pressed():
	load_level(preload("res://Scenes/level_one.tscn"))

func _on_level_2_button_pressed():
	load_level(preload("res://Scenes/level_two.tscn"))

func _on_level_3_button_pressed():
	load_level(preload("res://Scenes/level_three.tscn"))

func _on_level_4_button_pressed():
	load_level(preload("res://Scenes/level_four.tscn"))
