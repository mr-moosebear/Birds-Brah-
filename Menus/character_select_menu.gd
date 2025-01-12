extends Node2D

@onready var sprite: AnimatedSprite2D = $BirdSelectControl/AnimatedSprite2D
@onready var fwoosh_emitter = $ParticleSelectControl/FwooshParticlePreview
var bird: Bird
var fwoosh_config: FwooshConfig

func _ready() -> void:
	bird = Global.save_state.bird.duplicate()
	fwoosh_config = Global.save_state.fwoosh_config.duplicate()
	sprite.play(bird.animation_name())
	refresh_fwoosh_emitter()
	update_bird_preview()

func refresh_fwoosh_emitter():
	fwoosh_emitter.texture = fwoosh_config.texture
	var f: float = 1.0 if fwoosh_config.is_unlocked() else 0.6
	fwoosh_emitter.set_modulate(Color(f, f, f, f))
	$ParticleSelectControl/LockLabel.text = "Unlock at {} points!".format([fwoosh_config.unlock_req()], "{}")
	$ParticleSelectControl/LockLabel.visible = !fwoosh_config.is_unlocked()

func update_bird_preview():
	if !bird.is_unlocked():
		sprite.modulate = Color(0.6, 0.6, 0.6, 0.2)
		$BirdSelectControl/LockLabel.text = "Unlock at {} points!".format([bird.unlock_req()], "{}")
	else:
		sprite.modulate = Color(1, 1, 1, 1)
	$BirdSelectControl/LockLabel.visible = !bird.is_unlocked()
	$BirdSelectControl/BirdLabel.text = self.bird.name()
	sprite.play(bird.animation_name())

func cycle_displayed_bird(change: int):
	bird.cycle(change)
	update_bird_preview()

func _on_right_button_pressed() -> void:
	cycle_displayed_bird(1)

func _on_left_button_pressed() -> void:
	cycle_displayed_bird(-1)


func _on_select_button_pressed() -> void:
	if bird.is_unlocked():
		Global.save_state.bird = bird
	if fwoosh_config.is_unlocked():
		Global.save_state.fwoosh_config = fwoosh_config
	Global.save_game_state()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_particle_right_button_pressed():
	fwoosh_config.cycle(1)
	refresh_fwoosh_emitter()

func _on_particle_left_button_pressed():
	fwoosh_config.cycle(-1)
	refresh_fwoosh_emitter()
