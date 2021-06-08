extends Label

var score = 0

func _process(delta):
	score += delta
	text = str(score)
