class_name LocalLeaderboard

const PLACEMENT_NAME = 0
const PLACEMENT_SCORE = 1
const DEFAULT_PLACEMENTS: Array = [
	["moose", 10000],
	["andrew", 9000],
	["bird master", 8000],
	["dude", 7000],
	["me", 6000],
	["hue", 5000],
	["bo", 4000],
	["juice", 3000],
	["main_man", 2000],
	["bear", 1000],
]

var placements: Array

func _init(placements: Array = []):
	if placements.is_empty():
		self.placements = DEFAULT_PLACEMENTS.duplicate(true)
	else:
		self.placements = placements
	self.sort_placements()

func size() -> int:
	return self.placements.size()

func get_score_at_index(index: int):
	if index >= self.placements.size():
		return
	return self.placements[index]

func get_placement_of_score(score: int):
	for placement_idx in self.placements.size():
		if self.placements[placement_idx][PLACEMENT_SCORE] < score:
			return placement_idx
	return self.placements.size()

func get_placement_of_name(name: String):
	for placement_idx in self.placements.size():
		if self.placements[placement_idx][PLACEMENT_NAME] == name:
			return placement_idx
	return

func get_high_score() -> int:
	return self.get_score_at_index(0)[PLACEMENT_SCORE]

func sort_placements():
	self.placements.sort_custom(func(lbItem1, lbItem2): lbItem1[PLACEMENT_SCORE] > lbItem2[PLACEMENT_SCORE])

# Check if a user has a leaderboard entry - create a new entry if they don't,
# or update their existing entry if they exceeded their old high score.
# Returns the user's updated (or un-updated) position in the leaderboard.
func register_score(name: String, score: int) -> int:
	# find the leaderboard item corresponding to the given name
	var lb_item_idx = self.placements.find(func(lbItem): lbItem[PLACEMENT_NAME] == name)
	# find where the leaderboard item should be, even if it isn't there yet
	if lb_item_idx != -1:
		if self.placements[lb_item_idx][PLACEMENT_SCORE] >= score:
			# score isn't a new high score
			return lb_item_idx
		# new high score - update the leaderboard
		self.placements[lb_item_idx][PLACEMENT_SCORE] = score
		self.sort_placements()
		return self.get_placement_of_name(name)
	else:
		# new leaderboard entry - add the new entry to the placements
		var placement_idx = self.get_placement_of_score(score)
		self.placements.insert(placement_idx, [name, score])
		return placement_idx

# # # # # # # # # # # # # # # # # # # # # # # #
# JSON functions for saving leaderboard state #
# # # # # # # # # # # # # # # # # # # # # # # #

func to_json():
	return JSON.stringify(self.placements)

func save_to_path(path: String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(self.to_json())
	file.close()

static func from_json(s: String):
	var json = JSON.new()
	var err = json.parse(s)
	# check for json error
	if err == OK:
		# check type of parsed data
		var loaded_dict = json.data
		var is_valid_state = typeof(loaded_dict) == TYPE_ARRAY
		if !is_valid_state:
			printerr("Invalid local leaderboard data: ", s)
		else:
			return LocalLeaderboard.new(loaded_dict)
	else:
		printerr("JSON parse error: ", json.get_error_message(), " in ", s, " at line ", json.get_error_line())
	return null

static func load_from_path(path: String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var s = file.get_as_text()
		file.close()
		return from_json(s)
	else:
		return LocalLeaderboard.new()
