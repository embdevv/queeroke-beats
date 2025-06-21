extends Node2D

@export var falling_key = preload("res://scenes/ui/falling_key.tscn")
@export var key_name: String = ""

func _process(delta):
	if Input.is_action_just_pressed(key_name):
		print(key_name)
