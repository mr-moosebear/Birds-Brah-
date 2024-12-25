class_name CompObstacleMove
extends Node

@export var body : StaticBody2D

var speed : float = -300.0

func _physics_process(delta: float) -> void:
	body.velocity.x = speed * delta
