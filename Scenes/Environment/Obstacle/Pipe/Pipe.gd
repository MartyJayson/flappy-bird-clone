extends StaticBody2D

export(float) var speed: float = -200.0

func _physics_process(delta):
	position.x += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body: Node):
	if body.is_in_group("players"):
		print("Add Score Here!")
