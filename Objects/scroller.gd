extends Node

@export var scroll_rect: TextureRect
@export var scroll_px_sec: float

var rect_width: int
var active: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	var vp_width = get_viewport().get_visible_rect().end[0]
	# get the size of the tiling texture
	var default_rect_width = scroll_rect.texture.get_size()[0]
	var default_rect_height = scroll_rect.texture.get_size()[1]
	# make the rectangle wide enough to fill the viewport at least twice
	var scaled_rect_width = ceil((vp_width * 2) / float(default_rect_width)) * default_rect_width
	scroll_rect.stretch_mode = TextureRect.STRETCH_TILE
	scroll_rect.set_size(Vector2(scaled_rect_width, default_rect_height))
	self.rect_width = scaled_rect_width
	self.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.active:
		var tick_ms = Time.get_ticks_msec()
		var offset = int(scroll_px_sec * (tick_ms / 1000.0)) % (self.rect_width / 2)
		scroll_rect.set_position(Vector2(-offset, 0))
