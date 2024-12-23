extends CharacterBody2D

const JUMP_VELOCITY = -400.0
signal hit

func _ready() -> void:
	$AnimatedSprite2D.play(Global.bird)

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
		Global.score += 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is StaticBody2D && (body as StaticBody2D).is_in_group("obstacles"):
		$AnimatedSprite2D.play("death")
		hit.emit()
# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
