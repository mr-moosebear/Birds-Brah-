extends CharacterBody2D
# Start of the new branch
const JUMP_VELOCITY = -400.0
const SPEED : float = 300
const ROTATION_DEG_MAX = 20

signal hit
signal death_animation_finished

var alive: bool

func _ready() -> void:
	alive = true
	$AnimatedSprite2D.play(Global.save_state.bird)
	$AnimatedSprite2D.play(Global.bird)

func _physics_process(_delta: float) -> void:
	if self.alive:
		set_rotation_degrees(clamp(velocity.y, JUMP_VELOCITY, -JUMP_VELOCITY) / abs(JUMP_VELOCITY) * ROTATION_DEG_MAX)
		get_input()
		move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.set_frame(17)
		var new_particles = $FwooshParticles.duplicate()
		new_particles.emitting = true
		add_child(new_particles)
		[$Fwoosh1Player, $Fwoosh2Player][randi() % 2].play()
		velocity.y = JUMP_VELOCITY
		Global.score_signal.emit(100)
	if Input.is_action_just_pressed("forward"):
		velocity.x = SPEED

func _on_hit():
	self.alive = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("object"):
		hit.emit()
		$AnimatedSprite2D.play("death")
		$AnimatedSprite2D.animation_finished.connect(death_animation_finished.emit)
# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
