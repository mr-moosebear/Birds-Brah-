extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY
