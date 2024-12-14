extends CharacterBody2D

const JUMP_VELOCITY = -400.0

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func get_input() -> void:
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
