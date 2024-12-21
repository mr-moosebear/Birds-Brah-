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
	print("Player hit by ", body.name)
	if body.is_in_group("object"):
		$AnimatedSprite2D.play("death")
		hit.emit()
# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
