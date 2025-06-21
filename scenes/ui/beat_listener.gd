extends Node2D

@export var falling_key = preload("res://scenes/ui/falling_key.tscn")

func _process(delta):
	if Input.is_action_just_pressed("don_hit"):
		createFallingKey()

func createFallingKey():
	var beat_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", beat_inst)
	beat_inst.Setup(position.y)
