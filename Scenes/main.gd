extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter
@onready var collider : CollisionShape2D = $BirdCharacter/CollisionShape2D
var loaded_level : Node

func _ready():
	Global.signal_bus.bird_hit.connect(_on_bird_character_hit)
	Global.signal_bus.bird_death_finished.connect(_on_bird_character_death_animation_finished)
	Global.signal_bus.obstacle_spawn.connect(spawn_pipe_object)
	loaded_level = Global.selected_level.instantiate()
	loaded_level.setup(character)
	add_child(loaded_level)

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func _physics_process(delta):
	if collider != null:
		var char_height = collider.shape.radius * 2
		character.position.y = clamp(character.position.y, -char_height, get_viewport_rect().end.y + char_height)

#NOTE: call_deferred is to remove everthing after 
# the next physics process
func spawn_pipe_object(dangerous: bool = false) -> void:
	var scene_path = preload("res://Objects/pipe_static_body.tscn")
	var scene = scene_path.instantiate()
	scene.set_dangerous(dangerous)
	$Obstacles.add_child(scene)

func _on_bird_character_death_animation_finished():
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()

func _on_bird_character_hit() -> void:
	loaded_level.stop_scroller()
	for node in $Obstacles.get_children():
		node.do_move = false

func _on_obstacle_spawn_timer_timeout():
	if character.alive:
		spawn_pipe_object()
