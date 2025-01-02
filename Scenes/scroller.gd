extends Node

@export var scroll_rect: TextureRect
@export var scroll_px_sec: float

var rect_width: int

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_width = scroll_rect.get_rect().end[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tick_ms = Time.get_ticks_msec();
	var offset = int(scroll_px_sec * (tick_ms / 1000.0)) % (rect_width / 2)
	scroll_rect.set_position(Vector2(-offset, 0))
