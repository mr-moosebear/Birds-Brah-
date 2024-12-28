extends Node

var save_state: SaveState
var score = 0

func _ready():
	# load the saved game state on game instantiation
	var loaded_save_state = load_game_state()
	if loaded_save_state == null:
		save_state = SaveState.new()
	else:
		save_state = loaded_save_state

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
