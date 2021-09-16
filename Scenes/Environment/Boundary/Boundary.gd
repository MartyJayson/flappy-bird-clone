extends StaticBody2D

onready var collision_shape: CollisionShape2D = $CollisionShape2D

func init(pos: Vector2, size: Vector2):
	position = pos
#	collision_shape.shape.extents = size
