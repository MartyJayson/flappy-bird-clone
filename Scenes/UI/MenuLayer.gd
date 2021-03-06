extends CanvasLayer

signal start_game

var game_started = false
onready var restart = $CanvasLayer/RestartButton
onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu = $GameOverMenu

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && !game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()
		game_started = true

func init_game_over_menu(score, highscore):
	score_label.text = "SCORE: " +  str(score) 
	high_score_label.text = "BEST: " +  str(highscore) 
	start_message.visible = false
	game_over_menu.visible = true
	restart.visible = true

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
