extends Node2D

var audio
var map
var audio_path = "res://LEVELS/MUSIC/LevelOne.ogg"
var map_path = "res://LEVELS/MUSIC/LevelOneMap.mboy" 


#var audio_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.ogg"
#var map_path = "res://songs/Middle_of_The_Night/Middle_of_The_Night_CC_BY_SA.mboy"

var tempo
var bar_length_in_m
var quarter_time_in_sec
var speed
var note_scale
var start_pos_in_sec
var start_pos_in_px
var pre_start_length

var data_ready = false

var track
const track_scn = preload("res://scenes/ui/track.tscn")
const music_scn = preload("res://scenes/music.tscn")

var music

var start_bar_index = 0

func _ready():
	audio = load(audio_path)
	map = load_map()
	setup()
	
func load_map():
	var file = FileAccess.open(map_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: %s" % map_path)
		return null
	var content = file.get_as_text()
	file.close()
   
	var json = JSON.parse_string(content)
	if json.error != OK:
		push_error("Failed to parse JSON: %s" % json.error_string)
		return null
	
	return json.result

func setup():
	print("start at:", start_bar_index)
	tempo = int(map.tempo)
	bar_length_in_m = 1600 # Godot meters
	quarter_time_in_sec = 60/float(tempo) # 60/60 = 1, 60/85 = 0.71
	speed = bar_length_in_m/float(4*quarter_time_in_sec) # each bar has 4 quarters # 
	note_scale = bar_length_in_m/float(4*400)
	start_pos_in_sec = (float(map.start_pos)/400.0) * quarter_time_in_sec
	start_pos_in_px = start_pos_in_sec * speed
	
	music = music_scn.instantiate()
	music.audio = audio
	music.speed = speed
	music.tempo = tempo 
	music.pre_start_length = 1600 + start_pos_in_px 
	# include start_pos_in_sec here
	music.start_pos_in_sec = start_pos_in_sec + start_bar_index*4*quarter_time_in_sec # we confirm that all bars have fixed length - 4 quarters
	add_child(music)
	
	var bars = map.tracks[0].bars
	bars = bars.slice(start_bar_index, bars.size()-1)
	bars.push_front({"index": -1, "quarters_count": 4, "notes": []})
	
	
	track = track_scn.instantiate()	
	track.curr_bar_x = start_pos_in_px	
	track.bars_data = bars
	track.speed = speed
	track.note_scale = note_scale
	track.quarter_time_in_sec = quarter_time_in_sec
	track.start_pos_in_sec = start_pos_in_sec
	#track.position = $TrackPos.position
	$TrackC.add_child(track)	
	
	# set title
	$Title/Label.text = join_arr([map.audio.artist, map.audio.title], " - ")
	$Title/Genre/Label.text = join_arr([map.audio.genre, map.audio.subgenre], " / ")
	
	data_ready = true
	
func join_arr(arr, delimiter):
	var presents = []
	for el in arr: 
		if str(el) != "": presents.append(el)
		
	return delimiter.join(PackedStringArray(presents))

func _process(delta):
	if not data_ready:
		return
		
	track.process_with_time(music.time, delta)
	
#func _on_ReloadButton_pressed():
#	get_tree().change_scene("res://game.tscn")
