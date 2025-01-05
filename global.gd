extends Node

signal score_signal

var local_leaderboard: LocalLeaderboard
var save_state: SaveState

var local_leaderboard_view_idx: int = 0 # the placement the leaderboard view should center around
var selected_level: PackedScene

const LOCAL_LEADERBOARD_PATH: String = "user://leaderboard_local.json"

#var score = 0
var bird : String = "huebird"
var score : int = 0
var gap : int
var high_score : int
var placement : int

func _ready():
	# load the saved game state on game instantiation
	var loaded_save_state = load_game_state()
	if loaded_save_state == null:
		save_state = SaveState.new()
	else:
		save_state = loaded_save_state
	# load the local leaderboard
	local_leaderboard = LocalLeaderboard.load_from_path(LOCAL_LEADERBOARD_PATH)
	
	self.score_signal.connect(_on_score)

func _on_score(score: int):
	Global.score += score

func save_game_state():
	var save_file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	var save_data = JSON.stringify(save_state.as_dictionary())
	save_file.store_string(save_data)
	save_file.close()

# returns a SaveState or null if an error occurred
func load_game_state():
	# read file
	var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
	var string = file.get_as_text()
	file.close()
	# parse json
	var json = JSON.new()
	var loaded_state = json.parse(string)
	# check for json error
	if loaded_state == OK:
		# check type of parsed data
		var loaded_state_data = json.data
		var is_valid_state = typeof(loaded_state_data) == TYPE_DICTIONARY 
		if !is_valid_state:
			print("Invalid save game state: ", string)
			return null
		return SaveState.from_dictionary(loaded_state_data)
	else:
		print("JSON parse error: ", json.get_error_message(), " in ", string, " at line ", json.get_error_line())
		return null

func save_leaderboard():
	self.local_leaderboard.save_to_path(LOCAL_LEADERBOARD_PATH)

func load_leaderboard():
	self.local_leaderboard = LocalLeaderboard.load_from_path(LOCAL_LEADERBOARD_PATH)

func format_int_with_commas(i: int) -> String:
	var buffer = str(i).reverse()
	var output_segments = []
	for idx in range(0, buffer.length(), 3):
		var chunk = buffer.substr(idx, 3)
		output_segments.append(chunk)
	return ",".join(output_segments).reverse()
