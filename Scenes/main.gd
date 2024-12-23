extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter
@onready var collider = $BirdCharacter/CollisionShape2D

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

#NOTE: call_deferred is to remove everthing after 
# the next physics process
func _on_bird_character_hit() -> void:
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()

func _on_obstacle_spawn_timer_timeout():
	var bo = BrahObstacle.new($Camera2D)
	self.add_child(bo)
