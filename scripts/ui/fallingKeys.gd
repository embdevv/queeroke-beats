extends Sprite2D

@export var fall_speed: float = 2.0

func _process(delta):
	position += Vector2(-fall_speed, 0)
	if position.x > 1000.0 and not $Timer.is_stopped():
		print($Timer.time_left)
		$Timer.stop()
