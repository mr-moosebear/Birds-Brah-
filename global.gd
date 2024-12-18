extends Node

var bird : String = "huebird"
var score : int = 0

func convert_score_to_string(i: int) -> String:
	var s = str(i)
	return s 

func save_game_score():
	var scr = convert_score_to_string(score)
	#var save_file = FileAccess.open("res://PlayerData/savegame.txt", FileAccess.WRITE)
	var save_file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	save_file.store_string(scr)
	save_file.close()

func load_score() -> String:
	#var file = FileAccess.open("res://PlayerData/savegame.txt", FileAccess.READ)
	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	var string = file.get_as_text()
	file.close()
	return string
