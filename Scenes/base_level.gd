class_name BaseLevel
extends Node2D

@export var character: CharacterBody2D
@export var scroller: Node

const LASER = preload("res://Objects/laser.tscn")
const MISSILE = preload("res://Characters/missile_scene.tscn")

var lasers = []

func spawn_missile():
	var missile = MISSILE.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var target_y = character.get_position().y
	missile.move_y(randi_range(target_y + 75, target_y - 75))
	if randi() % 2 == 0:
		missile.flip()
	add_child(missile)

func spawn_laser(impossible_countdown: int = -1):
	var new_laser = LASER.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	new_laser.target = self.character
	new_laser.impossible_countdown = impossible_countdown
	lasers.append(new_laser)
	add_child(new_laser)

func setup(character: CharacterBody2D):
	self.character = character

func stop_scroller():
	if scroller != null:
		scroller.active = false
