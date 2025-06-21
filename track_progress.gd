extends Node2D

var notes_count = 100 
var curr_value = 0

func on_note_collected(note):
	curr_value += 50.0/notes_count
	print("notes_count", notes_count, "curr_val", curr_value)
	$Texture2D/TextureProgressBar.value = int(curr_value)
	

func _on_timer_timeout() -> void:
	pass # Replace with function body.
