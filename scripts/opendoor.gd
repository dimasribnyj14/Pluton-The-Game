extends Area2D
var can_click = false
@onready var door = $"../Door"
var clicked = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("fire") and can_click and clicked == false:
		#get_tree().change_scene_to_file("res://scenes_for_scenes/skins.tscn")
		door.get_node('StaticBody2D').set_collision_layer_value(1, false)
		door.get_node('StaticBody2D').set_collision_mask_value(1, false)
		door.visible = false
		get_parent().texture = load('res://resources/interactive/acid_door/on.png')
		can_click = false
		$Sprite2D.visible = false
		clicked = true
func _on_body_entered(body):
	if body.name == "CharacterBody2D" and clicked == false:
		$Sprite2D.visible = true
		can_click = true


func _on_body_exited(body):
	if body.name == "CharacterBody2D" and clicked == false:
		can_click = false
		$Sprite2D.visible = false
