class_name FwooshConfig

var texture: Texture2D
var alias: String

static var fwoosh_alias_names: Array = texture_aliases.keys()
static var fwoosh_process: ParticleProcessMaterial = preload("res://Characters/fwoosh_particle_process.tres")
const texture_aliases = {
	"default": "res://Art/FwooshTextures/default.png",
	"star": [["res://Art/FwooshTextures/star1.png", 0.2], ["res://Art/FwooshTextures/star2.png", 0.2]]
}

func _init(alias: String):
	self.alias = alias
	self.texture = load_texture()

func duplicate() -> FwooshConfig:
	return FwooshConfig.new(self.alias)

func unlock_req() -> int:
	match self.alias:
		"star": return 150000
		_: return 0

func is_unlocked() -> bool:
	return Global.local_leaderboard.get_high_score() >= self.unlock_req()

func fwoosh(parent: Node2D):
	var particles = GPUParticles2D.new()
	particles.one_shot = true
	particles.emitting = true
	particles.texture = self.texture
	particles.process_material = self.fwoosh_process
	particles.amount = 16
	particles.lifetime = 2
	particles.explosiveness = 1.0
	particles.randomness = 1.0
	parent.add_child(particles)

func alias_index() -> int:
	return fwoosh_alias_names.find(self.alias)

func cycle(n: int):
	var next_idx = abs((alias_index() + n) % fwoosh_alias_names.size())
	self.alias = fwoosh_alias_names[next_idx]
	self.texture = self.load_texture()

func load_texture() -> Texture2D:
	if !texture_aliases.has(self.alias):
		printerr("Falling back to default fwoosh texture instead of ", self.alias)
		self.alias = "default"
	if typeof(texture_aliases[self.alias]) == TYPE_ARRAY:
		var animated_texture = AnimatedTexture.new()
		var i = 0
		for path_and_duration in texture_aliases[self.alias]:
			var path = path_and_duration[0]
			var duration = path_and_duration[1]
			animated_texture.set_frame_texture(i, load(path))
			animated_texture.set_frame_duration(i, duration)
			i += 1
		animated_texture.set_frames(i)
		return animated_texture
	else:
		return load(texture_aliases[self.alias])
