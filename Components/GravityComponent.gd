class_name CompGravity
extends Node

@export var character : CharacterBody2D


func _physics_process(delta: float) -> void:
	character.velocity += character.get_gravity() * delta
