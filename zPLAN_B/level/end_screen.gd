extends Control

@onready var score_label: RichTextLabel = $ScoreLabel
@onready var combo_label: RichTextLabel = $ComboLabel
@onready var result_label: RichTextLabel = $ResultLabel

func _ready():
	score_label.text = "%d" % GameStats.final_score
	combo_label.text = "Max Combo  : %d" % GameStats.final_combo
	
	if GameStats.final_score >= 20000:
		result_label.text = "[center] [color=gold] Amazing! You are truly a star [/center][/color]"
	elif GameStats.final_score < 20000:
		result_label.text = "[center] [color=silver] Good job! Let's aim for a higher one next time [/color] [/center]"
	else:
		result_label.text = "[center][color=bronze]Keep practicing![/color][/center]"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/song_select.tscn")
