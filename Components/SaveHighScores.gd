class_name CompSaveScores
extends Node

var lead : Dictionary

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

func save_leaderboard_default():
	var save_file = FileAccess.open("res://PlayerData/LeaderOne.json", FileAccess.WRITE)
	var json_str = JSON.stringify(default_leaderboard)
	save_file.store_line(json_str)
	save_file.close()
	
func save_leaderboard(dict: Dictionary) -> void:
	var file = FileAccess.open("res://PlayerData/LeaderOne.json", FileAccess.WRITE)
	var json = JSON.stringify(dict)
	file.store_line(json)
	file.close
