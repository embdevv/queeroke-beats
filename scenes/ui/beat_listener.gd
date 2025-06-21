extends Node2D

@export var falling_key = preload("res://scenes/ui/falling_key.tscn")
var falling_key_queue = []


func _process(delta):
	if Input.is_action_just_pressed("don_hit"):
		pass
	
	if falling_key_queue.size() > 0:
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			print("Popped")

func createFallingKey():
	var beat_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", beat_inst)
	beat_inst.Setup(position.y)
	
	falling_key_queue.push_back(beat_inst)
	
func _on_random_spawn_timer_timeout() -> void:
	createFallingKey()
	$randomSpawnTimer.wait_time = randf_range(0.4, 3)
	$randomSpawnTimer.start()
	pass
