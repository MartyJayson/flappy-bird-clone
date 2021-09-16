extends Node2D

const Boundary = preload("res://Scenes/Environment/Boundary/Boundary.tscn")
var screen_size: Vector2 = Vector2()

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	setup_boundaries()

func setup_boundaries(size: Vector2 = Vector2(400, 60)):
	var screen_middle: Vector2 = screen_size / 2
	
	var top_ceiling = Boundary.instance()
	top_ceiling.init(Vector2(0, -screen_middle.y - size.y), size)
	add_child(top_ceiling)
	
	var bottom_floor = Boundary.instance()
	bottom_floor.init(Vector2(0, screen_middle.y + size.y), size)
	bottom_floor.add_to_group("obstacles")
	add_child(bottom_floor)
