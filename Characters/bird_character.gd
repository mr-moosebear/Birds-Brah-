extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const ROTATION_DEG_MAX = 40
var alive: bool
signal hit
signal death_animation_finished

func _ready() -> void:
	alive = true
	$AnimatedSprite2D.play(Global.bird)

func _physics_process(_delta: float) -> void:
	if alive:
		set_rotation_degrees(clamp(velocity.y, JUMP_VELOCITY, -JUMP_VELOCITY) / abs(JUMP_VELOCITY) * ROTATION_DEG_MAX)
		get_input()
		move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
		Global.score += 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D && (body as StaticBody2D).is_in_group("obstacles"):
		# freeze movement
		hit.emit()
		alive = false
		$AnimatedSprite2D.play("death")
		$AnimatedSprite2D.animation_finished.connect(death_animation_finished.emit)
# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
