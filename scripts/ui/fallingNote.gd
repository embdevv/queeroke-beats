#falling_note.gd
extends Sprite2D

enum NoteType {CENTER, RIM}

@export var center_texture: Texture2D
@export var rim_texture   : Texture2D
@export var fall_speed: float = 400.0
@export var pass_threshold: float = 1020.0

@export var note_type: NoteType = NoteType.CENTER
var has_passed: bool  = false

func Setup(note_type: int, y_pos: float):
	self.note_type = note_type
	global_position = Vector2(1300, y_pos)

	if note_type == NoteType.CENTER:
		texture = center_texture
	else:
		texture = rim_texture


func _process(delta):
	global_position.x -= fall_speed * delta
	
	if global_position.x < pass_threshold and !has_passed:
		has_passed = true
