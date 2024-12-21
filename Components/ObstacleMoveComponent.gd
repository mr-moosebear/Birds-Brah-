class_name CompObstacleMove
extends Node

#NOTE: Buggy when passing charcter will probably use position

@export var character : CharacterBody2D

var speed : float = -300.0

func _physics_process(delta: float) -> void:
	character.velocity.x = speed
	character.move_and_slide()
