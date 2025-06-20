extends Sprite2D

enum NoteType { CENTER, RIM }
const FallingNoteScene = preload("res://scenes/ui/fallingNote.tscn")

@export var hit_zone_x: float = 1000.0
@export var perfect_threshold: float = 30.0
@export var good_threshold: float = 70.0

var falling_key_queue: Array = []

func _process(_delta):
	if Input.is_action_just_pressed("don_hit"):
		_try_hit(NoteType.CENTER)
	elif Input.is_action_just_pressed("katsu_hit"):
		_try_hit(NoteType.RIM)

func _try_hit(note_type: int):
	while !falling_key_queue.is_empty() and not is_instance_valid(falling_key_queue[0]):
		falling_key_queue.pop_front()

	if falling_key_queue.is_empty():
		return

	var front_note = falling_key_queue[0]

	if front_note.has_passed:
		print("Missed note popped")
		falling_key_queue.pop_front()
		front_note.queue_free()
		return

	if front_note.note_type != note_type:
		print("Wrong hit type")
		return

	var distance = abs(front_note.global_position.x - hit_zone_x)

	if distance <= perfect_threshold:
		print("Perfect!")
	elif distance <= good_threshold:
		print("Good!")
	else:
		print("Miss!")
		return  # Don't remove the note on a total miss

	falling_key_queue.pop_front()
	front_note.queue_free()

func createBeat():
	var fk_inst = FallingNoteScene.instantiate()
	fk_inst.note_type = randi() % 2
	fk_inst.Setup(fk_inst.note_type, position.y)
	get_tree().get_root().call_deferred("add_child", fk_inst)
	falling_key_queue.append(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	createBeat()
	$randomSpawnTimer.wait_time = randf_range(0.4, 3.0)
	$randomSpawnTimer.start()
