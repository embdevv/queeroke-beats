extends Control

signal reload
@export var start_bar_index: int = 0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$BarIndex.value = start_bar_index

func _on_reload_btn_pressed():
	print(start_bar_index)
	emit_signal("reload", start_bar_index)
	$CurrBarIndex.text = ""
	get_tree().paused = false # back to game

func _on_bar_index_value_changed(value):
	start_bar_index = int(value)


func _on_bar_index_changed(index):
	$CurrBarIndex.text = str(index)


func _on_pause_btn_pressed() -> void:
	get_tree().paused = !get_tree().paused
