class_name CompOutofBounds
extends Node

@export var character : CharacterBody2D
@export var camera : Camera2D
@onready var bottom_boundry : int = camera.get_viewport_rect().size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if character.position.y >= bottom_boundry or character.position.y <= -25:
		character.queue_free()
