extends Node2D

@onready var character : CharacterBody2D = $Huebird

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flap"):
		print_shit()
	
func update_player() -> void:
	await get_tree().create_timer(3.0).timeout

func print_shit() -> void:
	print("Character Postion is: ", character.position)
	print("Camera Viewport is: ", $Huebird/Camera2D.get_viewport_rect())
	print("Top Obstacle position is: ", $LevelOne/TopObstacle.position)
	print("Bottom Postion is: ", $LevelOne/BottomObstacle.position)
