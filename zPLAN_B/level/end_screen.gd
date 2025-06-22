extends Control

@onready var score_label: RichTextLabel = $ScoreLabel
@onready var combo_label: RichTextLabel = $ComboLabel
@onready var result_label: RichTextLabel = $ResultLabel

var rolling_duration := 5
var rolling_timer := 0.0
var showing_actual := false

func _ready():
	
	rolling_timer = 0.0
	showing_actual = false
	score_label.text = "[center]---"
	result_label.text = "[center]Calculating results..."
	
	#score_label.text = "[center] %d [/center]" % GameStats.final_score
	#combo_label.text = "Max Combo  : %d" % GameStats.final_combo

func _process(delta):
	
	if not showing_actual:
		rolling_timer += delta
		if rolling_timer >= rolling_duration:
			showing_actual = true
			show_actual_results()
		else:
			show_random_results()

func show_random_results():
	var random_score = randi() % 99999
	
	score_label.text = "[center] %d " % random_score
	result_label.text = "[center][color=yellow]Calculating..."

func show_actual_results():
	score_label.text = "[center] %d" % GameStats.final_score
	
	if GameStats.final_score >= 50000:
		result_label.text = "[center] [color=gold] Amazing! You are truly a star"
	elif GameStats.final_score < 50000:
		result_label.text = "[center] [color=silver] Good job! Let's aim for a higher one next time"
	elif GameStats.final_score <= 20000:
		result_label.text = "[center][color=bronze]Keep practicing!"
	else:
		pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
