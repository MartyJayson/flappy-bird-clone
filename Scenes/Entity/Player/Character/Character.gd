extends RigidBody2D

export(float) var flap_force: float = -400.0

onready var animated_sprite: AnimatedSprite = $AnimatedSprite

func _input(event):
	if event.is_action_pressed("ui_accept"):
		flap()
		
func flap():
	linear_velocity.y = flap_force
	animated_sprite.play("flap")


func _on_AnimatedSprite_animation_finished():
	animated_sprite.play("idle")
