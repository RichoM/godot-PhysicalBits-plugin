extends Control

const SCORE_FILE_PATH = "user://max_score.txt"

var score = 0
var max_score = 0

func _ready():
	var score_file = File.new()
	var error = score_file.open(SCORE_FILE_PATH, File.READ)
	
	max_score = score_file.get_64()
	score_file.close()
	
	$score_list/max_score.text = str(max_score)
	$timer.connect("timeout", self, "update_score")
	$timer.start(0.1)

func update_score():
	score += 100
	$score_list/score.text = str(score)
	if score > max_score:
		$score_list/score.set("custom_colors/font_color", Color.red)


func _on_airplane_game_over():
	$timer.stop()
	if score > max_score:
		max_score = score
		
		var score_file = File.new()
		score_file.open(SCORE_FILE_PATH, File.WRITE)
		score_file.store_64(max_score)
		score_file.close()
