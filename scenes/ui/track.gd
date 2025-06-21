extends Node2D

var map_bar_index = -1  
const NOTE_SCENE = preload("res://notes/normal_note.tscn")
var bar_scn = preload("res://scenes/bar/bar.tscn")
@export var falling_key = preload("res://scenes/ui/falling_key.tscn")
var falling_key_queue = []

var bars = []
var notes_count = 0
var start_pos_in_sec = 0.0
var quarter_time_in_sec = 0.0

var bars_data = [{
					"index": 0,
					"quarters_count": 4,
					"notes": []
				},
				{
					"index": 1,
					"quarters_count": 4,
					"notes": []
				},
				{
					"index": 2,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 400,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1200,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 3,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 400,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1200,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 4,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 400,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1200,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 5,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 400,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1100,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1400,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 6,
					"quarters_count": 4,
					"notes": []
				},
				{
					"index": 7,
					"quarters_count": 4,
					"notes": []
				},
				{
					"index": 8,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 200,
							"len": 100,
							"markers": []
						},
						{
							"pos": 500,
							"len": 100,
							"markers": []
						},
						{
							"pos": 600,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1000,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1300,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1400,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 9,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 200,
							"len": 100,
							"markers": []
						},
						{
							"pos": 500,
							"len": 100,
							"markers": []
						},
						{
							"pos": 600,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1100,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1400,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 10,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 200,
							"len": 100,
							"markers": []
						},
						{
							"pos": 500,
							"len": 100,
							"markers": []
						},
						{
							"pos": 600,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1000,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1300,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1400,
							"len": 100,
							"markers": []
						}
					]
				},
				{
					"index": 11,
					"quarters_count": 4,
					"notes": [
						{
							"pos": 0,
							"len": 100,
							"markers": []
						},
						{
							"pos": 200,
							"len": 100,
							"markers": []
						},
						{
							"pos": 500,
							"len": 100,
							"markers": []
						},
						{
							"pos": 600,
							"len": 100,
							"markers": []
						},
						{
							"pos": 800,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1100,
							"len": 100,
							"markers": []
						},
						{
							"pos": 1400,
							"len": 100,
							"markers": []
						}
					]
				}
			]

var time_begin
var time_delay
var note_scale = 0.5
var speed = 800
#var pre_start_length = 0

var curr_bar_x = 0
var curr_bar_index = 0

var colliding_notes = []

func _ready():
	for i in range(0, 4):
		add_bar()
		
	var extended = false
	for bar in bars_data:
		for note in bar.notes:
			if extended:
				extended = false
				continue
				
			if note.markers.has("extended"):
				extended = true
			
			notes_count += 1
			
	$TrackProgress.notes_count = notes_count
		
	

func add_bar():
	#print("add bar")
	if curr_bar_index >= bars_data.size(): return
	var bar_data = bars_data[curr_bar_index]
	if not bar_data: return
		
	var bar = bar_scn.instantiate()
	bar.index = bar_data.index
	bar.position = Vector2(curr_bar_x, 80)
	bar.note_scale = note_scale
	bar.notes_data = bar_data.notes
	bar.length = bar_data.quarters_count * 400 * note_scale
	
	bars.append(bar)
	#bars_node.add_child(bar)
	
	curr_bar_x += bar.length
	curr_bar_index += 1

func createFallingKey():
	var beat_inst = falling_key.instantiate()
	add_child(beat_inst)
	# Set position based on your logic, e.g., start at curr_bar_x + some offset
	beat_inst.position = Vector2(curr_bar_x, 80)
	falling_key_queue.push_back(beat_inst)


func process_with_time(music_time, delta):
	for bar in bars_data:
		var bar_index = bar.index
		var bar_time = start_pos_in_sec + (bar_index * 4 * quarter_time_in_sec)
		
		for note in bar.notes:
			var note_time = bar_time + (note.pos / 400.0) * quarter_time_in_sec
			if note_time <= music_time + 2.0 and not note.has("spawned"):
				createFallingKey()
				note["spawned"] = true  


func remove_bar(bar):
	#print("delete bar")
	bar.queue_free()
	bars.erase(bar)

func _on_Picker_area_entered(area):
	if area.is_in_group("note"):
		colliding_notes.push_back(area.get_parent())

func _on_Picker_area_exited(area):
	if area.is_in_group("note"):
		
		for n in colliding_notes:
			if n == area.get_parent():
				n.fail()				
				colliding_notes.erase(n)
				
		
func on_red_left_pressed():
	#print("RL")
	collect_by_type("red", 'L')
	
func on_red_right_pressed():
	#print("RR")
	collect_by_type("red", 'R')

func on_blue_left_pressed():
	#print("BL")
	collect_by_type("blue", 'L')
		
func on_blue_right_pressed():
	#print("BR")
	collect_by_type("blue", 'R')
	

func collect_by_type(color_type, side):
	for n in colliding_notes:
		var d = n.global_position.x - $Picker.global_position.x
		if d <= 90 and d > -45:
			if n.color_type == color_type:
				var collected = n.collect(side)
				if collected:
					colliding_notes.erase(n)
					#play_collect_anim(n)
					break
		elif d < -45 or n.color_type != color_type:
			n.fail()
			colliding_notes.erase(n)
			
