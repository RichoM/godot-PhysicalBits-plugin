extends Control

export(Array, String) var exclamation_messages
const SCORE_FILE_PATH = "user://max_score.txt"

var score = 0
var max_score = 0

var msg_counter = 0
var game_over = false

func _ready():
	var score_file = File.new()
	var error = score_file.open(SCORE_FILE_PATH, File.READ)
	
	max_score = score_file.get_64()
	score_file.close()
	
	$timer.connect("timeout", self, "update")
	$timer.start(0.1)

func update():
	if msg_counter == 0:
		$msg.text = ""
	elif msg_counter > 0:
		msg_counter -= 1
		
	if not game_over:
		update_score(100)


func update_score(s = 100):
	score += s
	
	$score_list/score.text = str(score)
	$score_list/max_score.text = str(max_score)
	if score > max_score:
		$score_list/score.set("custom_colors/font_color", Color.red)
	
func _input(event):
	if Input.is_action_just_released("reset_max_score"):
		update_max_score(0)


func update_max_score(score):
	max_score = score
	var score_file = File.new()
	score_file.open(SCORE_FILE_PATH, File.WRITE)
	score_file.store_64(max_score)
	score_file.close()

func _on_airplane_game_over():
	game_over = true
	if score > max_score:
		update_max_score(score)

func _on_airplane_bullet_time_score(score):
	if game_over: return
	msg_counter = 10
	var msg := "+" + str(score)
	if score >= 3000:
		var exclamation = exclamation_messages[randi() % exclamation_messages.size()]
		msg = exclamation + "\n" + msg
	$msg.text = msg
	update_score(score)
