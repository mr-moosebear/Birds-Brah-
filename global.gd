extends Node

var bird : String = "huebird"
var score : int = 0


#NOTE: Will change where the file saves but this is for testing
func save_game_score():
	var save_file = FileAccess.open("res://PlayerData/savegame.txt", FileAccess.WRITE)
	save_file.store_line(str(score))

func load_score() -> String:
	var file = FileAccess.open("res://PlayerData/savegame.txt", FileAccess.READ)
	var string = file.get_line()
	return string
