class_name Laser
extends Area2D

const COLOR_INACTIVE: Color = Color(0.5, 1, 0, 0.6)   # green
const COLOR_TARGETED: Color = Color(1, 0.6, 0.2, 0.6) # orange
const COLOR_FIRING: Color = Color(1, 0, 0, 0.6)       # red

@export var target: CollisionObject2D
@export var impossible_countdown: int = -1

@onready var last_collide_time_ms = Time.get_ticks_msec()
@onready var last_state_change_ms = Time.get_ticks_msec()

var height = 90

enum LaserState {Inactive, Targeted, Firing}
var state: LaserState = LaserState.Inactive
var laser_collided = false

func set_height(h: int):
	self.height = h
	var vp_width: int = self.get_viewport_rect().size.x
	$ColorRect.set_size(Vector2(vp_width, height))
	$CollisionShape2D.shape.size = Vector2(vp_width, height)

func time_spent_in_state() -> int:
	return Time.get_ticks_msec() - last_state_change_ms

func time_spent_collided() -> int:
	if !laser_collided:
		return 0
	return Time.get_ticks_msec() - last_collide_time_ms

func color() -> Color:
	match self.state:
		LaserState.Targeted: return COLOR_TARGETED
		LaserState.Firing: return COLOR_FIRING
		LaserState.Inactive, _: return COLOR_INACTIVE

func update_color():
	$ColorRect.set_color(self.color())

func set_state(state: LaserState):
	self.last_state_change_ms = Time.get_ticks_msec()
	self.state = state

func set_rect_position(v: Vector2):
	# ColorRect is anchored at the top left, CollisionShape2D is anchored in the middle,
	# so we have to do conversions to make sure the shapes occupy the same space
	var x = v.x - ($CollisionShape2D.shape.get_rect().size.x / 2)
	var y = v.y - height / 2
	$ColorRect.set_position(Vector2(v.x, v.y))
	$CollisionShape2D.set_position(Vector2(0, 0))

# Called when the node enters the scene tree for the first time.
func _ready():
	# set the laser to fill the width of the entire screen, starting at the top of the screen
	var vp_width: int = self.get_viewport_rect().size.x
	$ColorRect.set_size(Vector2(vp_width, height))
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = Vector2(vp_width, height)
	set_rect_position(Vector2(0, 0))
	self.position.y = -height

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.state != LaserState.Firing:
		# move the laser at a constant speed in the direction of the target
		var diff = target.position.y - (self.position.y + height / 2)
		var dir = 1 if diff > 0 else -1
		var vel_y = dir * 200
		self.position.y += vel_y * delta
	if impossible_countdown == 0:
		self.position.y = target.position.y - height / 2
	
	match self.state:
		LaserState.Inactive:
			if time_spent_collided() > 100:
				set_state(LaserState.Targeted)
				# locking in
		LaserState.Targeted:
			if laser_collided:
				if time_spent_in_state() >= 1000:
					set_state(LaserState.Firing)
					# target locked
			else:
				set_state(LaserState.Inactive)
				# lost lock
		LaserState.Firing:
			if time_spent_in_state() >= 1500:
				if laser_collided:
					set_state(LaserState.Inactive)
					# hit!
					Global.signal_bus.bird_hit.emit()
				else:
					set_state(LaserState.Inactive)
					# missed
					if self.impossible_countdown > 0:
						self.impossible_countdown -= 1
	
	update_color()

func _on_body_entered(body):
	if body.is_in_group("player") && !laser_collided:
		last_collide_time_ms = Time.get_ticks_msec()
		laser_collided = true

func _on_body_exited(body):
	if body.is_in_group("player") && laser_collided:
		laser_collided = false
