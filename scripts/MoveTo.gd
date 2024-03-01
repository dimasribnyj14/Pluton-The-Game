extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if get_tree().current_scene.name == 'first_LVL':
		get_tree().change_scene_to_file("res://main_scenes/second_LVL.tscn")
	elif get_tree().current_scene.name == 'second_LVL':
		get_tree().change_scene_to_file("res://main_scenes/third_lvl.tscn")
	elif get_tree().current_scene.name == 'third_lvl':
		get_tree().change_scene_to_file("res://main_scenes/fourth_level.tscn")
	elif get_tree().current_scene.name == 'fourth_level':
		get_tree().change_scene_to_file("res://main_scenes/cloudlvl.tscn")
	else:
		get_tree().change_scene_to_file("res://main_scenes/lvlsChoice.tscn")
