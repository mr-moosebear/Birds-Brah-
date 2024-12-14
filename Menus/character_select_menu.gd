extends Node2D


const character : Dictionary = {
	"huebird": "res://Characters/huebird.tscn",
	"duck_norris": "soon"
}

func _ready() -> void:
	spawn_character()

func spawn_character() -> void:
	var bird = preload(character["huebird"])
	add_child(bird)
	bird.position = $SpawnPosition.position
