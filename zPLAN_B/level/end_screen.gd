extends Control

@onready var score_label: RichTextLabel = $ScoreLabel
@onready var combo_label: RichTextLabel = $ComboLabel

func _ready():
	score_label.text = "Final Score: %d" % GameStats.final_score
	combo_label.text = "Max Combo  : %d" % GameStats.final_combo


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/song_select.tscn")
