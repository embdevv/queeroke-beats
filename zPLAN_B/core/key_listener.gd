extends Node2D

var frame := 0
@onready var falling_key = preload("res://zPLAN_B/core/falling_key.tscn")
@onready var score_text = preload("res://zPLAN_B/core/score_press_text.tscn")
@export var key_name: String = ""
@export var array_mum: int = 0

var falling_key_queue = []

# OFF-SET thresholds (in pixels)
var perfect_press_threshold: float = 24
var great_press_threshold  : float = 48
var good_press_threshold   : float = 72
var ok_press_threshold     : float = 96
var missed_press_threshold : float = 100

# Scores for each judgement
var perfect_press_score    : float = 250
var great_press_score      : float = 100
var good_press_score       : float = 50
var ok_press_score         : float = 20
var missed_press_score     : float = 0

var combo_reset_pending := false
var combo_reset_cooldown := 0.5
var combo_reset_timer := 0.0
@onready var sfx_hit: AudioStreamPlayer2D = $"../SFX_hit"

func _ready():
	Signals.CreateFallingKey.connect(createFallingKey)

func _process(delta):
	# Emit signals for other buttons (unchanged)
	if Input.is_action_just_pressed("button_A"):
		Signals.KeyListenerPress.emit("button_A", 0)
	if Input.is_action_just_pressed("button_S"):
		Signals.KeyListenerPress.emit("button_S", 1)
	if Input.is_action_just_pressed("button_K"):
		Signals.KeyListenerPress.emit("button_K", 2)
	if Input.is_action_just_pressed("button_L"):
		Signals.KeyListenerPress.emit("button_L", 3)

	if falling_key_queue.size() > 0 and falling_key_queue.front().has_passed:
			var missed_key = falling_key_queue.pop_front()
			missed_key.queue_free()

	# 2) Handle key press independently (outside miss block)
	if Input.is_action_just_pressed(key_name):
		if falling_key_queue.size() > 0:
			var key_to_pop = falling_key_queue.pop_front()
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			var press_score_text: String = ""

			if distance_from_pass < perfect_press_threshold:
				Signals.IncrementScore.emit(perfect_press_score)
				press_score_text = "PERFECT"
				Signals.IncrementCombo.emit()
				sfx_hit.play()
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
			elif distance_from_pass < missed_press_threshold:
				Signals.IncrementScore.emit(missed_press_score)
				press_score_text = "MISS"
				Signals.ResetCombo.emit()
			else:
				pass

			key_to_pop.queue_free()
			
			# REMOVE THIS TO WORK | combo does not reset when no input is pressed
			var miss_text = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", miss_text)
			miss_text.setTextInfo("MISS")
			miss_text.global_position = global_position + Vector2(0, -20)
			Signals.ResetCombo.emit()
		#	print("Combo reset triggered")
			#return
		
			var press_text = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", press_text)
			press_text.setTextInfo(press_score_text)
			press_text.global_position = global_position + Vector2(0, -20)

func createFallingKey(button_name: String):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, frame + 4)
		falling_key_queue.push_back(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	# Uncomment to spawn keys randomly
	# createFallingKey(key_name)
	$randomSpawnTimer.wait_time = randf_range(0.4, 3)
	$randomSpawnTimer.start()
