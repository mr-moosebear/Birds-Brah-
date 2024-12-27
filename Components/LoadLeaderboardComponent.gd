class_name CompLoadGameScores
extends Node

func load_leaderboard():
	var file = FileAccess.open("res://PlayerData/LeaderOne.json", FileAccess.READ)
	var str = file.get_as_text()
	var json = JSON.new()
	var err = json.parse(str)
	if err == OK:
		var data_retrieved = json.data
		if typeof(data_retrieved) == TYPE_DICTIONARY:
			return data_retrieved
		else:
			return
	else:
		return
	file.close()
