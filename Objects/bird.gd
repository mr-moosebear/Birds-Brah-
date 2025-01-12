class_name Bird

enum BirdType {HUE, DUCK, FEATHER, EMU, KIWI}
var type: BirdType

func _init(type: BirdType):
	self.type = type

static func from_name(name: String) -> Bird:
	var type: BirdType
	match name:
		"Duck Norris", "duck_norris": type = BirdType.DUCK
		"Kiwi Reeves", "kiwi_reeves": type = BirdType.KIWI
		"Featherlock Holmes", "featherlock_holmes": type = BirdType.FEATHER
		"Emu Watson", "emu_watson": type = BirdType.EMU
		_: type = BirdType.HUE
	return Bird.new(type)

func unlock_req() -> int:
	match self.type:
		BirdType.DUCK:    return 15000
		BirdType.FEATHER: return 40000
		BirdType.EMU:     return 50000
		BirdType.KIWI:    return 100000
	return 0

func is_unlocked() -> bool:
	return self.unlock_req() <= Global.local_leaderboard.get_high_score()

func cycle(change: int):
	self.type += change
	if self.type >= BirdType.size():
		self.type = 0
	elif self.type < 0:
		self.type = BirdType.size() - 1

func animation_name() -> String:
	match self.type:
		BirdType.HUE:     return "huebird"
		BirdType.DUCK:    return "duck_norris"
		BirdType.KIWI:    return "kiwi_reeves"
		BirdType.FEATHER: return "featherlock_holmes"
		BirdType.EMU:     return "emu_watson"
	return "Unknown"

func name() -> String:
	match self.type:
		BirdType.HUE:     return "Hue Birdman"
		BirdType.DUCK:    return "Duck Norris"
		BirdType.KIWI:    return "Kiwi Reeves"
		BirdType.FEATHER: return "Featherlock Holmes"
		BirdType.EMU:     return "Emu Watson"
	return "Unknown"

func duplicate() -> Bird:
	return Bird.from_name(self.name())
