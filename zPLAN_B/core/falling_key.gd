extends Node2D

@export var fall_speed: float = 0.5

var init_y_pos: float = -360

func _process(delta):
	position += Vector2(0, fall_speed)
	
	# 1.368
	if position.y > 280.0 and not $Timer.is_stopped():
		print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()

func Setup(target_x: float):
	position = Vector2(target_x, init_y_pos)
