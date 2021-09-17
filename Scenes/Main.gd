extends Node2D

const Boundary = preload("res://Scenes/Environment/Boundary/Boundary.tscn")
const SAVE_FILE_PATH = "user://savedata.save"
var screen_size: Vector2 = Vector2()

onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var menu_layer = $MenuLayer
onready var character = $Character

var score = 0 setget set_score
var highscore = 0

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	setup_boundaries()
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	load_highscore()
	character.visible = false
	
func new_game():
	self.score = 0
	obstacle_spawner.start()
	character.visible = true
func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obstacle_created(obs):
	obs.connect("score",self,"player_score")

func setup_boundaries(size: Vector2 = Vector2(400, 60)):
	var screen_middle: Vector2 = screen_size / 2
	
	var top_ceiling = Boundary.instance()
	top_ceiling.init(Vector2(0, -screen_middle.y - size.y), size)
	add_child(top_ceiling)
	
	var bottom_floor = Boundary.instance()
	bottom_floor.init(Vector2(0, screen_middle.y + size.y), size)
	bottom_floor.add_to_group("obstacles")
	add_child(bottom_floor)
	
func _on_Character_died():
	game_over()
	
func game_over():
	obstacle_spawner.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	if score > highscore:
		highscore = score
		save_highscore()
	menu_layer.init_game_over_menu(score, highscore)
	
func _on_MenuLayer_start_game():
	new_game()

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()
