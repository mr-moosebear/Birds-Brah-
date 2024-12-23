class_name CompObstacleMove
extends Node

@export var body: StaticBody2D
@export var shape: CollisionShape2D

var speed : float = -300.0

func _physics_process(delta: float) -> void:
	body.position.x += speed * delta
	var rightmost_pixel = shape.global_position[0] + shape.shape.get_rect().size[0]
