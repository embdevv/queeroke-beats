extends VBoxContainer

@onready var resolution_opts_button = $resolutionDropMenu
@onready var fullscreen_checkbox = $fullscreenCheckBox

var Resolutions: Dictionary = { "2560x1440":Vector2i(2560, 1440),
								"1920x1080":Vector2i(1920, 1080),
								"1366x768":Vector2i(1366, 768),
								"1280x720":Vector2i(1280, 720)}

func _ready():
	add_resolutions()
	
func add_resolutions():
	for r in Resolutions:
		resolution_opts_button.add_item(r)

func _on_option_button_item_selected(index):
	var ID = resolution_opts_button.get_item_text(index)
	get_window().set_size(Resolutions[ID])
	centre_window()

func centre_window():
	var centre_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_screen - window_size / 2)

func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
