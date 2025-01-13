extends Node2D

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe
var screen_size
var min_y : int
var max_y : int
var do_move: bool
var dangerous = false

func _ready() -> void:
	do_move = true
	position = get_random_spawn_position()
	place_bottom_pipe()
	place_center_colshape()

func set_dangerous(flag: bool):
	self.dangerous = flag
	$Area2D.set_visible(flag)

func place_center_colshape():
	$Area2D/CollisionShape2D.shape.set_size(Vector2(80, Global.gap))
	$Area2D/CollisionShape2D.set_position(Vector2(0, Global.gap / 2))
	$Area2D/ColorRect.set_size(Vector2(80, Global.gap))

func _process(_delta: float) -> void:
	if do_move:
		self.position.x += -5

func set_gap() -> void:
	Global.gap = int(float(screen_size.y) * 0.25)

func get_random_spawn_position() -> Vector2:
	screen_size = get_tree().root.get_viewport().size
	set_gap()
	var x_pos = get_tree().root.get_viewport().size.x + 500
	get_min_max_y()
	return Vector2(x_pos, randi_range(min_y, max_y))

func get_min_max_y() -> void:
	min_y = int(float(get_tree().root.get_viewport().size.y * 0.15)) 
	max_y = Global.gap + min_y
	

func place_bottom_pipe() -> void:
	bottom_pipe.position.y = top_pipe.position.y + Global.gap

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_mouse_entered():
	$Area2D/ColorRect.color = Color(0, 0, 0, 0)
	self.dangerous = false

func _on_area_2d_body_exited(body):
	if body.is_in_group("player") && self.dangerous:
		Global.signal_bus.bird_hit.emit()
