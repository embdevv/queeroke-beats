extends Node2D

@export var fall_speed: float = 300
var frame: int = 0

var init_y_pos: float = -360

var has_passed: bool = false
var pass_threshold = 340.0
var pass_margin = 50.0

func _init():
	set_process(false)

func _process(delta):
	global_position += Vector2(0, fall_speed * delta)
	
	# 1.368
	if global_position.y > pass_threshold + pass_margin and not $Timer.is_stopped():
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true

func Setup(target_x: float, target_frame: int):
	global_position = Vector2(target_x, init_y_pos)
	frame = target_frame
	set_process(true)

func _on_destroy_timer_timeout() -> void:
	queue_free()
