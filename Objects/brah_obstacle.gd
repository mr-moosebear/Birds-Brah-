class_name BrahObstacle
extends Node

var top: StaticBody2D
var bottom: StaticBody2D

const pad = 175
const gap = 520
const top_texture = preload("res://Art/Backgrounds/Obstacle1.png")
const bottom_texture = preload("res://Art/Backgrounds/Obstacle2.png")

func _init(camera: Camera2D):
	top = StaticBody2D.new()
	top.add_to_group("obstacles", true)
	bottom = StaticBody2D.new()
	bottom.add_to_group("obstacles", true)
	
	var top_shape = CollisionShape2D.new()
	top_shape.shape = RectangleShape2D.new()
	top_shape.shape.set_size(Vector2(86, 342))
	top.add_child(top_shape)
	
	var top_sprite = Sprite2D.new()
	top_sprite.texture = top_texture
	top.add_child(top_sprite)
	var top_movement_comp = CompObstacleMove.new()
	top_movement_comp.body = top
	top_movement_comp.shape = top_shape
	top.add_child(top_movement_comp)
	
	var bottom_shape = CollisionShape2D.new()
	bottom_shape.shape = RectangleShape2D.new()
	bottom_shape.shape.set_size(Vector2(86, 342))
	bottom.add_child(bottom_shape)
	
	var bottom_sprite = Sprite2D.new()
	bottom_sprite.texture = bottom_texture
	bottom.add_child(bottom_sprite)
	var bottom_movement_comp = CompObstacleMove.new()
	bottom_movement_comp.body = bottom
	bottom_movement_comp.shape = bottom_shape
	bottom.add_child(bottom_movement_comp)
	
	var far_x = camera.get_viewport_rect().size[0]
	top.position.x = far_x
	bottom.position.x = far_x
	
	var y = randi_range(pad, camera.get_viewport_rect().abs().size[1] - pad)
	top.position.y = y - (gap / 2)
	bottom.position.y = y + (gap / 2)
	
	var vosn = VisibleOnScreenNotifier2D.new()
	vosn.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	top.add_child(vosn)
	
	self.add_child(top)
	self.add_child(bottom)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("free")
	queue_free()
