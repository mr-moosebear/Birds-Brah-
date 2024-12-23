class_name CompObstacleMove
extends Node

@export var body: StaticBody2D
@export var shape: CollisionShape2D

var speed : float = -300.0
var frozen: bool = false

func freeze():
	frozen = true

func _physics_process(delta: float) -> void:
	if !frozen:
		body.position.x += speed * delta
