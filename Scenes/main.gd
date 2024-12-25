extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter


func _ready() -> void:
	spawn_pipe_object()

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)
#NOTE: fix the scene position
func spawn_pipe_object() -> void:
	var scene_path = preload("res://Objects/pipe_static_body.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)
	scene.position = Vector2(1500, randi_range(-100, 100))

func _on_bird_character_hit() -> void:
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()

func _on_obstacle_spawn_timer_timeout():
	print("spawn obstacle")
	spawn_pipe_object()
