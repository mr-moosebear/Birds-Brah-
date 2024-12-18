extends CharacterBody2D

const JUMP_VELOCITY = -400.0



func _ready() -> void:
	$AnimatedSprite2D.play(Global.bird)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
		Global.score += 100

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.save_game_score()
	get_tree().change_scene_to_file("res://Menus/game_over_menu.tscn")
	
