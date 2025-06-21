extends Node2D

@export var frame_1: Sprite2D
@export var frame_2: Sprite2D

#@onready var frame_1: Sprite2D = $Frame1
#@onready var frame_2: Sprite2D = $Frame2

var showing_frame_1 := true

func _ready():
	frame_1.show()
	frame_2.hide()

func _input(event):
	if Input.is_action_just_pressed("don_hit") or Input.is_action_just_pressed("katsu_hit"):
		if showing_frame_1:
			frame_1.hide()
			frame_2.show()
			showing_frame_1 = false
		else:
			frame_1.show()
			frame_2.hide()
			showing_frame_1 = true
