extends Control


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/level_one.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/level_two.tscn")
