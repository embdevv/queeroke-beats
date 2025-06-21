extends Control

func setTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("e5ace5"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffff94e6"))
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("c4ff94e6"))
		"OKAY":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("d5a734"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("8f8d89"))
