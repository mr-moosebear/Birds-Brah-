extends Node2D

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe
var screen_size
var min_y : int
var max_y : int

func _ready() -> void:
	position = get_random_spawn_position()
	place_bottom_pipe()

func _process(_delta: float) -> void:
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
