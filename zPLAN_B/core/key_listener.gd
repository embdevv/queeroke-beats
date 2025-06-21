extends Node2D

var frame := 0
@onready var falling_key = preload("res://zPLAN_B/core/falling_key.tscn")
@onready var score_text = preload("res://zPLAN_B/core/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = []

# OFF-SET
var perfect_press_threshold: float = 50
var great_press_threshold  : float = 60
var good_press_threshold   : float = 70
var ok_press_threshold     : float = 80

var perfect_press_score    : float = 250
var great_press_score      : float = 100
var good_press_score       : float = 50
var ok_press_score         : float = 20


func _process(delta):
	
	if falling_key_queue.size() > 0:
		
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.setTextInfo("MISS")
			st_inst.global_position = global_position + Vector2(0, -30)
			Signals.ResetCombo.emit()
			
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.position.y)
			
			var press_score_text: String = ""
			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				press_score_text = "PERFECT"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < great_press_threshold:
				Signals.IncrementScore.emit(great_press_score)
				press_score_text = "GREAT"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < good_press_threshold:
				Signals.IncrementScore.emit(good_press_score)
				press_score_text = "GOOD"
				Signals.IncrementCombo.emit()
			elif distance_from_pass < ok_press_threshold:
				Signals.IncrementScore.emit(ok_press_score)
				press_score_text = "OKAY"
				Signals.IncrementCombo.emit()
			else:
				press_score_text = "MISS"
				Signals.ResetCombo.emit()
			
			key_to_pop.queue_free()
			

	
func createFallingKey():
	var fk_inst = falling_key.instantiate()
	get_tree().get_root().call_deferred("add_child", fk_inst)
	fk_inst.Setup(position.x, frame + 4)
	
	falling_key_queue.push_back(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	createFallingKey()
	$randomSpawnTimer.wait_time = randf_range(0.4, 3)
	$randomSpawnTimer.start()
