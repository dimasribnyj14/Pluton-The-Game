extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		if body.takenKey == true:
			$"Pixil-frame-0(1)".texture = load("res://resources/interactive/door/pixil-frame-0.png")
			set_collision_layer_value(1,false)
			set_collision_mask_value(1,false)
			$Area2D.set_collision_layer_value(1,false)
			$Area2D.set_collision_mask_value(1,false)
