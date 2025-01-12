class_name SaveState

var high_score: int
var bird: Bird
var fwoosh_config: FwooshConfig

func _init(inst_high_score = 0, inst_bird = "huebird", inst_fwoosh = "default"):
	self.high_score = inst_high_score
	self.bird = Bird.from_name(inst_bird)
	self.fwoosh_config = FwooshConfig.new(inst_fwoosh)


# convert the object to a dictionary, which can be stored as JSON
func as_dictionary() -> Dictionary:
	return {
		"high_score": int(high_score),
		"bird": bird.name(),
		"fwoosh": fwoosh_config.alias
	}

# load values from a dictionary (loaded via json parser) into a new SaveState 
static func from_dictionary(d: Dictionary):
	var required_value_types = {"high_score": TYPE_FLOAT, "bird": TYPE_STRING, "fwoosh": TYPE_STRING}
	for key in required_value_types:
		var type = required_value_types[key]
		if !d.has(key):
			print("Missing key \"", key, "\" with type: ", type_string(typeof(type)))
			return null
		if typeof(d[key]) != required_value_types[key]:
			print("Save state value \"", key, "\" has invalid type: ", type_string(typeof(d[key])))
			return null
	return SaveState.new(int(d["high_score"]), d["bird"], d["fwoosh"])
