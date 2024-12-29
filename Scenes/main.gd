extends Node2D

@onready var character : CharacterBody2D = $BirdCharacter
@onready var collider = $BirdCharacter/CollisionShape2D

func add_game_over_scene() -> void:
	var scene_path = preload("res://Menus/game_over_menu.tscn")
	var scene = scene_path.instantiate()
	add_child(scene)

func _physics_process(delta):
	if collider != null:
		var char_height = collider.shape.radius * 2
		character.position.y = clamp(character.position.y, -char_height, get_viewport_rect().end.y + char_height)
		print(character.position.y)

#NOTE: call_deferred is to remove everthing after 
# the next physics process
func _on_bird_character_hit() -> void:
	$ObstacleSpawnTimer.stop()
	for c in $Obstacles.get_children().filter(func(c): return c is BrahObstacle):
		(c as BrahObstacle).freeze()

func _on_obstacle_spawn_timer_timeout():
	var bo = BrahObstacle.new($Camera2D)
	$Obstacles.add_child(bo)

func _on_bird_character_death_animation_finished():
	var node_children = get_children()
	for node in node_children:
		node.call_deferred("queue_free")
	add_game_over_scene()
