extends RigidBody2D

signal died

export(float) var flap_force: float = -400.0

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

var alive = true

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && alive:
		flap()

func flap():
	linear_velocity.y = flap_force
	animated_sprite.play("flap")

func die():
	if !alive: return
	alive = false
	animated_sprite.stop()
	print("Player Character Died")
	emit_signal("died")

func _on_AnimatedSprite_animation_finished():
	animated_sprite.play("idle")

func _on_Character_body_entered(body: Node):
	if body.is_in_group("obstacles"):
		die()
