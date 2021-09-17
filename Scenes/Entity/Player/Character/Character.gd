extends RigidBody2D

signal died

export(float) var flap_force: float = -400.0

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var flap_audio_player: AudioStreamPlayer2D = $FlapAudioPlayer
onready var death_audio_player: AudioStreamPlayer2D = $DeathAudioPlayer
onready var hit_audio_player: AudioStreamPlayer2D = $HitAudioPlayer

var alive = true

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && alive:
		flap()

func flap():
	linear_velocity.y = flap_force
	animated_sprite.play("flap")
	flap_audio_player.play()

func die():
	if !alive: return
	alive = false
	animated_sprite.stop()
	hit_audio_player.play()
	print("Player Character Died")
	emit_signal("died")

func _on_AnimatedSprite_animation_finished():
	animated_sprite.play("idle")

func _on_Character_body_entered(body: Node):
	if body.is_in_group("obstacles"):
		die()

func _on_HitAudioPlayer_finished():
	death_audio_player.play()
