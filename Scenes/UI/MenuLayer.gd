extends CanvasLayer

signal start_game

var game_started = false

onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept") && !game_started:
		emit_signal("start_game")
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()
		game_started = true
