extends Control

var score: int = 0
var combo: int = 0

@onready var score_label: RichTextLabel = %ScoreLabel
@onready var combo_label: RichTextLabel = %ComboLabel

func _ready():
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)

func IncrementScore(incr: int):
	score += incr
	score_label.text = "Score: %d" % score

func IncrementCombo():
	combo += 1
	combo_label.text = "Combo: %dx" % combo

func ResetCombo():
	combo = 0
	combo_label.text = "Combo: 0"
