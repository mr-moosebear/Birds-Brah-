class_name MissileScene
extends Node2D

var swooping = false
var flipped = false

func flip():
	self.flipped = true
	$MissileBird.set_rotation(deg_to_rad(-140))
	$MissileBird/RigidBody2D/AnimatedSprite2D.flip_h = true

func move_y(y: int):
	var p = get_position()
	set_position(Vector2(p.x, y))

# Called when the node enters the scene tree for the first time.
func _ready():
	$MissileBird/RigidBody2D/AnimatedSprite2D.play("kiwi_reeves")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if swooping:
		var rot_rad = $MissileBird.get_rotation()
		var direction_coef = -1 if flipped else 1
		var rot = rad_to_deg(rot_rad) - 180 * delta * direction_coef
		$MissileBird.set_rotation(deg_to_rad(rot))

func _on_swoop_timer_timeout():
	$WarningTexture/BlinkTimer.stop()
	$WarningTexture.visible = false
	swooping = true

func _on_blink_timer_timeout():
	$WarningTexture.visible = !$WarningTexture.visible

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Global.signal_bus.bird_hit.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	swooping = false
