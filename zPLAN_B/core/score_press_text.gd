extends Control
@onready var trans_light: PointLight2D = $ScoreLevelText/TRANS_LIGHT
@onready var shine_light: PointLight2D = $ScoreLevelText/Shine_Light

# perfect - flag   (TRANS_LIGHT.show())
# great   - Gold   [ffff94e6]
# good    - green  [c4ff94e6] 
# ok      - orange [d5a734]
# miss    - gray   [8f8d89]


func setTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("e5ace5"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffff94e6"))
			#shine_light.show()
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("c4ff94e6"))
			#shine_light.show()
		"OKAY":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("d5a734"))
			#shine_light.hide()
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("8f8d89"))
			#shine_light.hide()
