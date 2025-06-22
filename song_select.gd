extends Control

@onready var description_label: RichTextLabel = $Panel/Panel/descriptionLabel

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/level_one.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://zPLAN_B/level/level_two.tscn")

func _ready():
	description_label.visible = false

func _on_level_1_mouse_entered() -> void:
	description_label.text = "NEW CLOTHESSSSS"
	description_label.visible = true

func _on_level_1_mouse_exited() -> void:
	description_label.visible = false

func _on_level_2_mouse_entered() -> void:
	description_label.text = "WLW: No assets yet :3 but you can play it"
	description_label.visible = true

func _on_level_2_mouse_exited() -> void:
	description_label.visible = false

func _on_level_3_mouse_entered() -> void:
	description_label.text = "Coming soon :3"
	description_label.visible = true

func _on_level_3_mouse_exited() -> void:
	description_label.visible = false

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
