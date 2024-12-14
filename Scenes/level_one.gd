extends Node2D
# NOTE: Script is not being used as I will move this to main 
# Im am doing this for the random obstacle spawn to save me 
# time with level building and to make the game exciting MAYBE???



# NOTE: POS set from manually placed node positions 
const MAX_TOP_POS : int = 168
const MAX_BOTTOM_POS : int = 544

const obstacle : Dictionary = {
	"top": "res://Objects/top_obstacle.tscn",
	"bottom": "res://Objects/bottom_obstacle.tscn"
}


func set_random_top_position() -> int:
	var num = randi_range(0, MAX_TOP_POS)
	return num

func set_random_bottom_position() -> int:
	var num = randi_range(MAX_BOTTOM_POS, 648)
	return num

func spawn_obstacle() -> void:
	var choice = randi_range(0, 10)
	var pos : int
	if choice <= 5:
		pos = set_random_top_position()
	else:
		pos = set_random_bottom_position()
	print(pos)
