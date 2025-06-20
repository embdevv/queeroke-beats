extends AudioStreamPlayer
class_name Conductor

@export var bpm: float = 120.0
@export var measures: int = 4

# to track beat and song position
var song_position: float = 0.0
var song_position_in_beats: int = 0
var sec_per_beat: float
var last_beat: int = 0
var measure = 1

# determine how close beat to event
var closest = 0
var time_off_beat = 0.0

signal beat(position)
signal measure(position)
# Audio synchronization
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	sec_per_beat = 60.0 / bpm
	audio_player.play()
