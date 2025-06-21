extends Node2D

@export var speed: float = 500.0
var init_x_pos: float = 545.0

func _init():
	set_process(false)

func _process(delta):
	global_position += Vector2(-speed * delta, 0)
	
	if global_position.x > 80.0 and not $Timer.is_stopped():
		print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()

func Setup(target_y: float):
	position = Vector2(init_x_pos, target_y)
	set_process(true)
	
