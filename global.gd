extends Node

var bird : String = "huebird"
var score : int = 0
var gap : int
var high_score : int
var placement : int

var default_leaderboard : Dictionary = {
	"1": {"name": "moose", "score": "10000"},
	"2": {"name": "bear", "score": "9000"},
	"3": {"name": "bird master", "score": "8000"},
	"4": {"name": "dude", "score": "7000"},
	"5": {"name": "me", "score": "6000"},
	"6": {"name": "hue", "score": "5000"},
	"7": {"name": "bo", "score": "4000"},
	"8": {"name": "juice", "score": "3000"},
	"9": {"name": "main_man", "score": "2000"},
	"10": {"name": "done", "score": "1000"}
}


func save_leaderboard(dict: Dictionary) -> void:
	var file = FileAccess.open("res://PlayerData/LeaderOne.json", FileAccess.WRITE)
	#var file = FileAccess.open("user:PlayerBoard.json", FileAccess.WRITE)
	var json = JSON.stringify(dict)
	file.store_line(json)
	file.close()

func load_leaderboard():
	var file = FileAccess.open("res://PlayerData/LeaderOne.json", FileAccess.READ)
	#var file = FileAccess.open("res://PlayerBoard.json", FileAccess.READ)
	var string = file.get_as_text()
	var json = JSON.new()
	var err = json.parse(string)
	if err == OK:
		var data_retrieved = json.data
		if typeof(data_retrieved) == TYPE_DICTIONARY:
			return data_retrieved
		else:
			return
	else:
		return
