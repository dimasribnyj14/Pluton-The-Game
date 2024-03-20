extends Control
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

var fullscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	if configFile != OK:
		config.set_value("options", "vsync", true)
		config.set_value("options", "fullscreen", true)
		config.set_value("options", "smoothcamera", true)
		config.set_value("options", "30fps", false)
		config.set_value("options", "strechscreen", false)
		config.set_value("options", "music", true)
		config.set_value("options", "light", true)
		
		config.set_value("saves","skin","default")
		
		config.save("user://config.cfg")
	
	fullscreen = config.get_value('options', 'fullscreen')
	
	if fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	if config.get_value('options', 'vsync') == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	
	if config.get_value('options', '30fps') == false:
		Engine.max_fps = 0
	else:
		Engine.max_fps = 30
	
	if config.get_value('options', 'light') == false:
		$FPSCounter.visible = false
	else:
		$FPSCounter.visible = true
		
	if config.get_value("options", "strechscreen") == false:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	else:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			fullscreen = true
			config.set_value("options", "fullscreen", true)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			fullscreen = false
			config.set_value("options", "fullscreen", false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")
