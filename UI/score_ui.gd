extends Control

var last_score: int = 0
var last_score_tick_ms: int = 0
var score_panel_floater = 1.0
var score_label_rot_direction = 1
var do_accumulate: bool
const FLOATER_DECAY_PER_SECOND = 1500

func _ready():
	self.do_accumulate = true 
	Global.score_signal.connect(_on_global_score)

func _process(delta: float) -> void:
	# apply bouncy affect to score background sprite
	score_panel_floater -= delta * FLOATER_DECAY_PER_SECOND
	if score_panel_floater < 1.0:
		score_panel_floater = 1.0
	var scale = clamp(1 + score_panel_floater / 1000.0, 1.0, 5.0)
	$ScoreBackground.set_scale(Vector2(scale, scale))
	$Label.rotation_degrees = (scale - 1) * 15 * score_label_rot_direction
	$Label.set_scale(Vector2(scale * sin(scale), scale * sin(scale)))
	# update UI
	update_score()

func _on_global_score(score: int):
	score_label_rot_direction = -score_label_rot_direction
	score_panel_floater += score

func update_score() -> void:
	var scr = str(Global.score)
	$Label.text = scr

func _on_timer_timeout() -> void:
	if do_accumulate:
		Global.score_signal.emit(1000)

func _on_bird_character_hit():
	self.do_accumulate = false
