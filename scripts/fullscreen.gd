extends Node2D
var fullscreen = false
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
@onready var heartsContainer = $CharacterBody2D/CanvasLayer/heartsContainer


func _ready():
	heartsContainer.setMaxHearts($CharacterBody2D.maxHealth)
	heartsContainer.updateHearts($CharacterBody2D.currentHealth)
	$CharacterBody2D.healthChanged.connect(heartsContainer.updateHearts)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if config.get_value("options", "strechscreen") == false:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	else:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	
	if config.get_value('options', 'light') == false:
		$CharacterBody2D/Camera2D/FPSCounter.visible = false
	else:
		$CharacterBody2D/Camera2D/FPSCounter.visible = true
	
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			fullscreen = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			fullscreen = false
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("escape"):
		if Engine.time_scale == 0:
			Engine.time_scale = 1
			#$CharacterBody2D/Music.playing = true
			$CharacterBody2D/Camera2D/Pause.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton2.show()
			$CharacterBody2D/Camera2D/TouchScreenButton3.show()
			$CharacterBody2D/Camera2D/TouchScreenButton4.show()
			$CharacterBody2D/Camera2D/TouchScreenButton5.show()
			$CharacterBody2D/Camera2D/TouchScreenButton.show()
		else:
			Engine.time_scale = 0
			#$CharacterBody2D/Music.playing = false
			$CharacterBody2D/Camera2D/Pause.show()
			$CharacterBody2D/Camera2D/TouchScreenButton2.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton3.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton4.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton5.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton.hide()
		#get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")
