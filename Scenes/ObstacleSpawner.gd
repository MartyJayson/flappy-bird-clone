extends Node2D

onready var Timer = $Timer

var Obstacle = preload("res://Scenes/Environment/Obstacle/Pipe/Pipe.tscn")

func _ready():
	randomize()

func _on_Timer_timeout():
	spawn_obstacle()
	
func spawn_obstacle():
	var obstacle = Obstacle.instance()
	add_child(obstacle)
	obstacle.position.y = randi()%400