extends Node2D

const FallingNoteScene = preload("res://scenes/ui/fallingNote.tscn")
@onready var spawn_timer: Timer = $SpawnTimer
@export var hit_zone_x: float = 100.0
@export var perfect_threshold: float = 30.0
@export var good_threshold: float = 70.0

var note_queue: Array = []

func _ready():
	$SpawnTimer.wait_time = 1.0
	$SpawnTimer.start()

func _process(_delta):
	if Input.is_action_just_pressed("don_hit"):
		_check_hit(0)  # CENTER
	elif Input.is_action_just_pressed("katsu_hit"):
		_check_hit(1)  # RIM

func _on_SpawnTimer_timeout():
	_spawn_note()

func _spawn_note():
	var note = FallingNoteScene.instantiate()
	var note_type = randi() % 2
	note.setup(note_type, $SpawnPosition.global_position)
	add_child(note)
	note_queue.append(note)

func _check_hit(expected_type: int):
	while !note_queue.is_empty() and !is_instance_valid(note_queue[0]):
		note_queue.pop_front()

	if note_queue.is_empty():
		return

	var note = note_queue[0]

	if note.has_passed:
		note_queue.pop_front()
		note.queue_free()
		print("Missed")
		return

	if note.note_type != expected_type:
		print("Wrong type")
		return

	var distance = abs(note.global_position.x - hit_zone_x)
	if distance <= perfect_threshold:
		print("Perfect!")
	elif distance <= good_threshold:
		print("Good!")
	else:
		print("Miss!")
		return

	note_queue.pop_front()
	note.queue_free()
