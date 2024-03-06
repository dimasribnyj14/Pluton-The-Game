extends Node2D
var fullscreen = false

@onready var heartsContainer = $CharacterBody2D/CanvasLayer/heartsContainer


func _ready():
	heartsContainer.setMaxHearts($CharacterBody2D.maxHealth)
	heartsContainer.updateHearts($CharacterBody2D.currentHealth)
	$CharacterBody2D.healthChanged.connect(heartsContainer.updateHearts)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
			$CharacterBody2D/Camera2D/Pause.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton2.show()
			$CharacterBody2D/Camera2D/TouchScreenButton3.show()
			$CharacterBody2D/Camera2D/TouchScreenButton4.show()
			$CharacterBody2D/Camera2D/TouchScreenButton5.show()
			$CharacterBody2D/Camera2D/TouchScreenButton.show()
		else:
			Engine.time_scale = 0
			$CharacterBody2D/Camera2D/Pause.show()
			$CharacterBody2D/Camera2D/TouchScreenButton2.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton3.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton4.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton5.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton.hide()
		#get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")
