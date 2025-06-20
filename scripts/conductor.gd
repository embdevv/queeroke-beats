extends AudioStreamPlayer

@export var bpm : int = 100
@export var measures : int = 4

var song_position: float = 0.0
var song_position_in_beats: int = 1
var sec_per_beat = 60.0 / bpm
var last_reported_beat = 0
var beats_before_start = 0
var measure = 1

var closest = 0
var time_off_beat = 0.0

signal beat(position)
