extends Area2D
var can_click = false
var clicked = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("fire") and can_click and clicked == false:
		#get_tree().change_scene_to_file("res://scenes_for_scenes/skins.tscn")
		#get_parent().texture = load('res://resources/interactive/acid_door/on.png')
		#Engine.time_scale = 0
		##$CharacterBody2D/Music.playing = false
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton2".hide()
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton3".hide()
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton4".hide()
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton5".hide()
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton6".hide()
		#$"../../CharacterBody2D/Camera2D/TouchScreenButton".hide()
		
		$"../../CharacterBody2D/CanvasLayer/TextureRect".visible = true
		
		can_click = false
		$Sprite2D.visible = false
		#clicked = true
func _on_body_entered(body):
	if body.name == "CharacterBody2D" and clicked == false:
		$Sprite2D.visible = true
		can_click = true


func _on_body_exited(body):
	if body.name == "CharacterBody2D" and clicked == false:
		can_click = false
		$Sprite2D.visible = false
