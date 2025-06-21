extends Node2D

# set this constant before game starts
const in_edit_mode: bool = true
var current_level_name = "TRANSition"

var fk_fall_time: float = 2.2
var fk_output_arr = [[], [], [], []]

var level_info = {
	"TRANSition" = {
		"fk_times": "[[1], [2], [3], [4]]",
		"music": preload("res://zPLAN_B/MUSIC/gamejamtest2 (1).mp3")
	}
}

func _ready():
	
	$MusicPlayer.stream = level_info.get(current_level_name).get("music")
	$MusicPlayer.play()

	if in_edit_mode:
		Signals.KeyListenerPress.connect(KeyListenerPress)
	else:
		var fk_times = level_info.get(current_level_name).get("fk_times")
		var fk_times_arr = str_to_var(fk_times)
		#print(fk_times_arr[0])
		
		var counter: int = 0
		for key in fk_times_arr:
			
			var button_name: String = ""
			match counter:
				0:
					button_name = "button_A"
				1: 
					button_name = "button_S"
				2:
					button_name = "button_K"
				3:
					button_name = "button_L"
				
			for delay in key:
				SpawnFallingKey(button_name, delay)
			
			counter += 1

func KeyListenerPress(button_name: String, array_num: int):
	print(array_num)

func SpawnFallingKey(button_name: String, delay: float):
	await get_tree().create_timer(delay).timeout
	Signals.CreateFallingKey.emit(button_name)
