extends Node2D

const RED_COUNT = 10
@export var notes_count: int = 0: get = get_notes_count, set = set_notes_count

func _ready():
	set_notes_count(notes_count)

func set_notes_count(value):
	notes_count = value
	update_label()

func get_notes_count():
	return notes_count

func update_label():
	if $Label:
		$Label.text = str(notes_count)
		if notes_count == 0:
			$Label.hide()
		else:
			$Label.show()
			if notes_count >= RED_COUNT:
				$RedLight.show()
				$WhiteLight.hide()
			else:
				$RedLight.hide()
				$WhiteLight.show()
