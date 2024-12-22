extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter
@onready var collider = $BirdCharacter/CollisionShape2D



func _ready() -> void:
	get_random_spawn_point()
	add_object_scene()

# TODO: Change y position for spawning
func get_random_spawn_point() -> Vector2:
	var screen_size = get_viewport_rect().size
	var x_point : int = screen_size.x + 100
	var y_point : int = randi_range(0, screen_size.y)
	return Vector2(x_point, y_point)
	
func add_object_scene() -> void:
	var scene_path = preload("res://Objects/obstacle.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)
	if scene:
		scene.position = get_random_spawn_point()
		print("Spawn a pipe at: ", scene.position)

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func _on_spawn_timer_timeout() -> void:
	add_object_scene()

#NOTE: call_deferred is to remove everthing after 
# the next physcics process
func _on_bird_character_hit() -> void:
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()
