extends CanvasLayer

onready var score_label = $Score
onready var tween = $Tween

var started = false

func update_score(new_score):
	score_label.text = str(new_score)
	if !started:
		tween.interpolate_property(score_label, "modulate:a", 0, 1, 1)
		tween.start()
		started = true
