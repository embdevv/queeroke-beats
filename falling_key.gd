extends Node2D

@export var speed: float = 500.0

func _process(delta):
	position += Vector2(-speed * delta, 0)
	
	if position.x > 80.0 and not $Timer.is_stopped():
		print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
