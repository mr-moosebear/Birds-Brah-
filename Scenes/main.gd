extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func spawn_pipe_object() -> void:
	var scene_path = preload("res://Objects/pipe_static_body.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func _on_bird_character_hit() -> void:
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()

func _on_obstacle_spawn_timer_timeout():
	spawn_pipe_object()
