extends Control
@onready var options: Panel = $Options
@onready var background: Panel = $Main
@onready var calibration_opts: Panel = $Calibration

func _ready() -> void:
	options.hide()
	calibration_opts.hide()
	print("hello, world!")
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/level_one.tscn")

func _on_options_button_pressed() -> void:
	options.show()
	background.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_button_pressed() -> void:
	options.hide()
	background.show()

func _on_calib_back_button_pressed() -> void:
	calibration_opts.hide()
	options.show()
	background.hide()

func _on_calibration_label_pressed() -> void:
	calibration_opts.show()
	options.hide()
	
