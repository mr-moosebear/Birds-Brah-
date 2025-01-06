class_name SaveState

var high_score: int
var bird: String
var fwoosh_texture: Texture2D
var fwoosh_alias: String
var fwoosh_alias_names: Array = texture_aliases.keys()

const texture_aliases = {
	"default": "res://Art/FwooshTextures/default.png",
	"star": [["res://Art/FwooshTextures/star1.png", 0.2], ["res://Art/FwooshTextures/star2.png", 0.2]]
}

func _init(inst_high_score = 0, inst_bird = "huebird", inst_fwoosh = "default"):
	self.high_score = inst_high_score
	self.bird = inst_bird
	self.fwoosh_alias = inst_fwoosh
	self.fwoosh_texture = self.load_fwoosh_texture()

func fwoosh_alias_index() -> int:
	return fwoosh_alias_names.find(fwoosh_alias)

func cycle_fwoosh_particle(n: int):
	var next_idx = abs((fwoosh_alias_index() + n) % fwoosh_alias_names.size())
	self.fwoosh_alias = fwoosh_alias_names[next_idx]
	self.fwoosh_texture = self.load_fwoosh_texture()

func load_fwoosh_texture() -> Texture2D:
	if !texture_aliases.has(self.fwoosh_alias):
		printerr("Falling back to default fwoosh texture instead of ", self.fwoosh_alias)
		self.fwoosh_alias = "default"
	if typeof(texture_aliases[self.fwoosh_alias]) == TYPE_ARRAY:
		var animated_texture = AnimatedTexture.new()
		var i = 0
		for path_and_duration in texture_aliases[self.fwoosh_alias]:
			var path = path_and_duration[0]
			var duration = path_and_duration[1]
			animated_texture.set_frame_texture(i, load(path))
			animated_texture.set_frame_duration(i, duration)
			i += 1
		animated_texture.set_frames(i)
		return animated_texture
	else:
		return load(texture_aliases[self.fwoosh_alias])

# convert the object to a dictionary, which can be stored as JSON
func as_dictionary() -> Dictionary:
	return {
		"high_score": int(high_score),
		"bird": bird,
		"fwoosh": fwoosh_alias
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
