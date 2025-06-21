extends Node2D

@onready var falling_key = preload("res://zPLAN_B/core/falling_key.tscn")
@export var key_name: String = ""


func _process(delta):
	if Input.is_action_just_pressed(key_name):
		print(key_name)

func createFallingKey():
	var fk_inst = falling_key.instantiate()
	call_deferred("add_child", fk_inst)
