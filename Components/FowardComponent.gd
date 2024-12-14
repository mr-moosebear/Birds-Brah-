class_name CompFowardMovement
extends Node

@export var character = CharacterBody2D
var speed = 300


func _physics_process(delta: float) -> void:
	character.velocity.x = speed
