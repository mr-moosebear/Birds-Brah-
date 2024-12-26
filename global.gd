extends Node

var bird : String = "huebird"
var score : int = 0
var gap : int


func convert_score_to_string(i: int) -> String:
	return str(i) 

func save_game_score():
	var scr = convert_score_to_string(score)
	#var save_file = FileAccess.open("res://PlayerData/savegame.txt", FileAccess.WRITE)
	var save_file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	save_file.store_string(scr)
	save_file.close()

func load_score() -> String:
	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	var string = file.get_as_text()
	file.close()
	return string

func save_leaderboard() -> void:
	var save_file = FileAccess.open("res://PlayerData/leader.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
func load_leaderboard() -> void:
	var file = FileAccess.open("res://PlayerData/leader.txt", FileAccess.READ)
