extends Control
@onready var options: Panel = $Options

func _ready() -> void:
	options.hide()
	print("hello")
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/songSelect.tscn")

func _on_options_button_pressed() -> void:
	options.show()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_button_pressed() -> void:
	options.hide()
